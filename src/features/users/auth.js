import nodemailer from 'nodemailer';
import crypto from 'crypto';
import JWT from 'jsonwebtoken';
import bcrypt from 'bcryptjs';
import uuid from 'uuid/v4';

import logger from 'app/logger';
import sessionStore from 'app/sessionStore';
import config from 'app/config';

import User from 'app/features/users/dao';

/**
 * Returns a hashed password
 * @param {string} password
 * @returns Promise resolving to password hash
 */
export function hashPassword(password) {
  return bcrypt.hash(password, 12);
}

/**
 * @returns Random token to be used for password reset
 */
export async function generatePasswordResetToken() {
  const buf = await crypto.randomBytes(16);
  return buf.toString('hex');
}

/**
 * Creates a new session token for a given user, saves it in the session store
 * @param {*} user
 * @returns The created session token
 */
export async function createSessionTokenAndLogin(user) {
  const session = {
    id: uuid(),
    userId: user.id,
  };

  const token = JWT.sign(session, config.jwtSecret, {
    expiresIn: '7 days',
  });
  await sessionStore.set(session.id, session);
  logger.debug('createTokenAndLogin: creating a token for user', {
    userId: user.id,
    email: user.email,
  });

  return Promise.resolve(token);
}

export async function invalidateSessionBySessionId(sessionId) {
  logger.debug('invalidateSessionBySessionId:', { sessionId });
  await sessionStore.del(sessionId);
}

/**
 * Validates a session
 * @param {*} decodedSession
 * @param {*} req
 * @param {*} callback - (error: any?, sessionIsValid: bool)
 */
export async function validateSession(decodedSession, req, callback) {
  const sessionId = decodedSession.id;
  try {
    const storedSession = await sessionStore.get(sessionId);
    if (!storedSession) {
      logger.warn('validateSession: no stored session', { sessionId });
      callback(null, false);
      return;
    }

    const session = JSON.parse(storedSession);
    logger.debug('validateSession: validating session for user', {
      userId: session.userId,
      sessionId,
    });

    if (session.exp < new Date().getTime()) {
      invalidateSessionBySessionId(decodedSession.id);
      logger.debug('validateSession: session has expired', {
        userId: session.id,
        sessionId,
      });
      callback(new Error('Session has expired'), false);
      return;
    }

    callback(null, true);
  } catch (err) {
    logger.error('validateSession: error', err, { sessionId });
    callback(err, false);
  }
}

/**
 * Hapi pre- hook for fetching user data from the DB
 */
export async function fetchUserData(req, res) {
  const userId = req.auth.credentials && req.auth.credentials.userId;
  if (!userId) {
    return res(null);
  }

  const user = await User.getUser(req.auth.credentials.userId);
  if (!user) {
    logger.warn('fetchUserData: no such user', { userId });
    return res(null);
  }

  return res(user);
}

/**
 * Generates and saves password reset token for a given user,
 * then sends out a password reset email
 * @param {*} user
 */
export function sendPasswordResetEmail(user) {
  return new Promise((resolve, reject) => {
    const transporter = nodemailer.createTransport({
      service: 'Mailgun',
      auth: {
        user: config.email.mailgun.user,
        pass: config.email.mailgun.password,
      },
    });
    const token = user.passwordResetToken;
    if (!token) {
      return reject(new Error('User does not have passwordResetToken'));
    }
    const mailOptions = {
      to: user.email,
      from: config.email.passwordReset.from,
      subject: config.email.passwordReset.subject,
      text:
        'You are receiving this email because you (or someone else) have requested the reset of the password for your account.\n\n' +
        'Please click on the following link, or paste this into your browser to complete the process:\n\n' +
        `${config.email.passwordReset.resetLink}${token}\n\n` +
        'If you did not request this, please ignore this email and your password will remain unchanged.\n',
    };
    transporter.sendMail(mailOptions, (err) => {
      if (err) {
        logger.error('sendPasswordResetEmail: error: ', err);
        return reject(err);
      }
      resolve();
    });
  });
}
