import config from 'app/config';
import logger from 'app/logger';
import HapiAuthJWT2 from 'hapi-auth-jwt2';

import { validateSession } from './auth';

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
        validateFunc: validateSession,
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
