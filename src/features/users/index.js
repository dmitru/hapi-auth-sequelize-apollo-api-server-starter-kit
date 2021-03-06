import typeDefs from './typeDefs';
import createResolvers from './resolvers';
import Feature from '../feature';

export default new Feature({
  typeDefs,
  createResolversFunc: createResolvers,
  createContextFunc: async (request) => {
    const { credentials = {} } = request.auth;
    return {
      isAuthenticated: request.auth.isAuthenticated,
      ...credentials,
    };
  },
});
