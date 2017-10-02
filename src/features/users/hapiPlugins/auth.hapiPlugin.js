import config from 'app/config';
import logger from 'app/logger';
import HapiAuthJWT2 from 'hapi-auth-jwt2';

import sessionStore from 'app/sessionStore';

import User from '../dao';
import { invalidateSessionBySessionId } from '../authUtils';

/**
 * Validates a session and fetched user data for authenticated users
 * @param {*} decodedSession
 * @param {*} req
 * @param {*} callback - (error: any?, sessionIsValid: bool)
 */
async function validateSessionAndFetchUserData(decodedSession, req, callback) {
  const { userId, id: sessionId } = decodedSession;
  try {
    const storedSession = await sessionStore.get(sessionId);
    if (!storedSession) {
      logger.warn('validateSession: no stored session', { sessionId });
      callback(null, false);
      return;
    }

    if (1000 * decodedSession.exp < new Date().getTime()) {
      invalidateSessionBySessionId(sessionId);
      logger.debug('validateSession: session has expired', {
        userId,
        sessionId,
      });
      callback(new Error('Session has expired'), false);
      return;
    }

    const user = await User.getUser(userId);
    if (!user) {
      logger.warn('validateSession: no user', { userId });
      callback(new Error('Unauthorized'), false);
    }

    const credentials = {
      sessionId: decodedSession.id,
      userId: decodedSession.userId,
      role: user.role,
      user,
    };

    callback(null, true, credentials);
  } catch (err) {
    logger.error('validateSession: error', err, { sessionId });
    callback(err, false);
  }
}

function register(server, options, next) {
  server.register(
    {
      register: HapiAuthJWT2,
    },
    (err) => {
      if (err) {
        logger.error('Error while registering hapi-auth-jwt2 Hapi plugin', err);
        throw err;
      }
      server.auth.strategy('jwt', 'jwt', 'required', {
        key: config.jwtSecret,
        verifyOptions: { algorithms: ['HS256'], ignoreExpiration: true },
        validateFunc: validateSessionAndFetchUserData,
      });
      next();
    },
  );
}

register.attributes = {
  name: 'auth-hapi-plugin',
};

export default {
  register,
};
