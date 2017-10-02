import { graphqlHapi, graphiqlHapi } from 'apollo-server-hapi';
import { formatError as apolloFormatError } from 'apollo-errors';

import { GraphQLError } from 'graphql';
import { schema as graphQLSchema } from 'app/graphql/schema';
import logger from 'app/logger';

import { UnknownError } from '../errors';

const formatError = (error) => {
  logger.error('graphql error: ', error);
  let e = apolloFormatError(error);

  if (e instanceof GraphQLError) {
    e = apolloFormatError(new UnknownError({
      data: {
        originalMessage: e.message,
        originalError: e.name,
      },
    }));
  }

  return e;
};

export const getGraphqlOptions = async (request) => {
  const { credentials = {} } = request.auth;
  return {
    schema: graphQLSchema,
    context: {
      isAuthenticated: request.auth.isAuthenticated,
      ...credentials,
    },
    formatError,
  };
};

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
