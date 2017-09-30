import Joi from 'joi';
import Boom from 'boom';

import logger from 'app/logger';
import models from 'app/models';

import { USER_ROLE } from 'app/constants';

import { hashPassword, createSessionTokenAndLogin } from '../utils';

const signupSchema = Joi.object({
  email: Joi.string()
    .trim()
    .email()
    .required(),
  password: Joi.string()
    .required()
    .trim()
    .min(6),
});

export default {
  method: 'POST',
  path: '/api/signupWithEmailAndPassword/',
  config: {
    auth: false,
    handler: async (req, res) => {
      const { email, password } = req.payload;

      const hashedPassword = await hashPassword(password);
      try {
        const newUser = await models.User
          .build({
            role: USER_ROLE.USER,
            email,
            password: hashedPassword,
            displayName: email,
          })
          .save();

        const token = await createSessionTokenAndLogin(newUser);
        res({ user: newUser, token }).code(201);
      } catch (err) {
        if (err.name === 'SequelizeUniqueConstraintError') {
          res(Boom.conflict('The email is already taken'));
          return;
        }
        logger.error('signupWithEmailAndPassword: ', err);
        res(Boom.badImplementation(err));
      }
    },
    // Validate the payload against the Joi schema
    validate: {
      payload: signupSchema,
    },
  },
};
