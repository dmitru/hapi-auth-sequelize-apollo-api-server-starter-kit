import Joi from 'joi';
import Boom from 'boom';
import bcrypt from 'bcryptjs';

import models from 'app/models';
import { createSessionTokenAndLogin } from '../auth';

const authenticateUserSchema = Joi.object({
  email: Joi.string()
    .email()
    .required(),
  password: Joi.string().required(),
});

function verifyEmailPasswordCredentials(req, res) {
  const { email, password } = req.payload;

  models.User
    .findOne({
      where: { email },
    })
    .then((user) => {
      if (!user) {
        res(Boom.unauthorized('Incorrect email or password'));
        return;
      }
      bcrypt.compare(password, user.password, (err, isValid) => {
        if (isValid) {
          res(user);
          return;
        }
        res(Boom.unauthorized('Incorrect email or password'));
      });
    });
}

export default {
  method: 'POST',
  path: '/api/loginWithEmailAndPassword/',
  config: {
    auth: false,
    // Check the user's password against the DB
    pre: [{ method: verifyEmailPasswordCredentials, assign: 'user' }],
    handler: async (req, res) => {
      const { user } = req.pre;
      const token = await createSessionTokenAndLogin(user);
      res({ token, user });
    },
    validate: {
      payload: authenticateUserSchema,
    },
  },
};
