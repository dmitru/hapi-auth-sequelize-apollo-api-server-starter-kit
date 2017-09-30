import nodemailer from 'nodemailer';
import crypto from 'crypto';
import uuid from 'uuid/v4';
import JWT from 'jsonwebtoken';
import Boom from 'boom';
import bcrypt from 'bcryptjs';

import models from 'app/models';

import logger from 'app/logger';
import sessionStore from 'app/sessionStore';
import config from 'app/config';

/**
 * Generate a salt at level 10 strength
 * @param {string} password 
 * @returns Promise resolving to password hash
 */
export function hashPassword(password) {
  return new Promise((resolve, reject) => {
    bcrypt.genSalt(10, (err, salt) => {
      if (err) {
        return reject(err);
      }
      bcrypt.hash(password, salt, (err, hash) => {
        if (err) {
          return reject(err);
        }
        return resolve(hash);
      });
    });
  });
}

/**
 * @returns Random token to be used for password reset
 */
export function generatePasswordResetToken() {
  return new Promise((resolve, reject) => {
    crypto.randomBytes(16, (err, buf) => {
      if (err) {
        return reject(err);
      }
      resolve(buf.toString('hex'));
    });
  });
}

const SEVEN_DAYS_IN_MS = 1000 * 3600 * 24 * 7;

/**
 * Creates a new session token for a given user, saves it in the session store
 * @param {*} user 
 * @returns The created session token
 */
export function createSessionTokenAndLogin(user) {
  const session = {
    valid: true,
    id: uuid(),
    userId: user.id,
    exp: new Date().getTime() + SEVEN_DAYS_IN_MS,
  };

  const token = JWT.sign(session, config.jwtSecret);
  sessionStore.set(session.id, session);
  logger.debug('createTokenAndLogin: creating a token for user', {
    userId: user.id,
    email: user.email,
  });
  return token;
}

export function invalidateSessionToken(session) {
  logger.debug('invalidateSessionToken:', { sessionId: session.id });
  sessionStore.del(session.id);
}

/**
 * Validates a session
 * @param {*} decodedSession 
 * @param {*} req 
 * @param {*} callback - (error: any?, sessionIsValid: bool) 
 */
export function validateSession(decodedSession, req, callback) {
  const sessionId = decodedSession.id;
  sessionStore
    .get(sessionId)
    .then(storedSession => {
      if (!storedSession) {
        logger.warn('validateSession: no stored session', { sessionId });
        return callback(null, false);
      }
      const session = JSON.parse(storedSession);
      logger.debug('validateSession: validating session for user', {
        userId: session.userId,
        sessionId,
      });
      if (session.exp < new Date().getTime()) {
        invalidateToken(decodedSession);
        logger.debug('validateSession: session has expired', {
          userId: session.id,
          sessionId,
        });
        return callback(new Error('Session has expired'), false);
      }
      if (!session.valid === true) {
        invalidateToken(decodedSession);
        logger.debug('validateSession: session is invalid', {
          userId: session.id,
          sessionId,
        });
        return callback(new Error('Session is invalid'), false);
      }
      return callback(null, true);
    })
    .catch(err => {
      logger.error('validateSession: error', err, { sessionId });
      callback(err, false);
    });
}

/**
 * Hapi pre- hook for fetching user data from the DB
 */
export function fetchUserData(req, res) {
  const userId = req.auth.credentials && req.auth.credentials.userId;
  if (!userId) {
    return res(null);
  }
  return models.User.findById(req.auth.credentials.userId).then(user => {
    if (!user) {
      logger.warn('fetchUserData: no such user', { userId });
      return res(null);
    }
    return res(user);
  });
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
    transporter.sendMail(mailOptions, err => {
      if (err) {
        logger.error('sendPasswordResetEmail: error: ', err);
        return reject(err);
      }
      resolve();
    });
  });
}
