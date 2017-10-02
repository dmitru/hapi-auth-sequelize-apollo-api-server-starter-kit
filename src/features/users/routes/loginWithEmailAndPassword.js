import Joi from 'joi';
import Boom from 'boom';
import bcrypt from 'bcryptjs';

import User from '../dao';
import { createSessionTokenAndLogin } from '../authUtils';

const authenticateUserSchema = Joi.object({
  email: Joi.string()
    .email()
    .required(),
  password: Joi.string().required(),
});

export default {
  method: 'POST',
  path: '/api/loginWithEmailAndPassword/',
  config: {
    auth: false,
    handler: async (req, res) => {
      const { email, password } = req.payload;

      const user = await User.getUserByEmail(email);
      if (!user) {
        res(Boom.unauthorized('Incorrect email or password'));
        return;
      }

      const isValid = await bcrypt.compare(password, user.password);
      if (!isValid) {
        res(Boom.unauthorized('Incorrect email or password'));
        return;
      }

      const token = await createSessionTokenAndLogin(user);
      res({ token, user });
    },
    validate: {
      payload: authenticateUserSchema,
    },
  },
};
