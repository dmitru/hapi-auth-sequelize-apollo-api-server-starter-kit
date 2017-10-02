import jwt from 'jsonwebtoken';

import config from 'app/config';

import { refreshTokens } from './authUtils';
import typeDefs from './typeDefs';
import createResolvers from './resolvers';
import Feature from '../feature';

export default new Feature({
  typeDefs,
  createResolversFunc: createResolvers,
  createContextFunc: async (req, connectionParams) => {
    let tokenUser = null;

    if (
      connectionParams &&
      connectionParams.token &&
      connectionParams.token !== 'null' &&
      connectionParams.token !== 'undefined'
    ) {
      try {
        const { user } = jwt.verify(connectionParams.token, config.jwtSecret);
        tokenUser = user;
      } catch (err) {
        const newTokens = await refreshTokens(connectionParams.refreshToken);
        tokenUser = newTokens.user;
      }
    } else if (req) {
      if (req.user) {
        tokenUser = req.user;
      }
    }

    return {
      user: tokenUser,
    };
  },
});
