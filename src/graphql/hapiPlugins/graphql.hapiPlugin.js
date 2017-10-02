import { graphqlHapi, graphiqlHapi } from 'apollo-server-hapi';
import { schema as graphQLSchema } from 'app/graphql/schema';

import logger from 'app/logger';

export const getGraphqlOptions = async request => ({
  schema: graphQLSchema,
  context: {
    auth: request.auth,
  },
  formatError: (err) => {
    logger.error('graphql error: ', err);
    return err;
  },
});

function register(server, options, next) {
  server.register(
    [
      {
        register: graphqlHapi,
        options: {
          path: '/graphql',
          graphqlOptions: getGraphqlOptions,
          route: {
            cors: true,
          },
        },
      },
      {
        register: graphiqlHapi,
        options: {
          path: '/graphiql',
          graphiqlOptions: {
            endpointURL: '/graphql',
          },
        },
      },
    ],
    (err) => {
      if (err) {
        logger.error('Error while registering graphql Hapi plugins', err);
        throw err;
      }

      next();
    },
  );
}

register.attributes = {
  name: 'graphql-hapi-plugin',
};

export default {
  register,
};
