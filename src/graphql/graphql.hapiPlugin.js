import { graphqlHapi, graphiqlHapi } from 'apollo-server-hapi';
import { graphqlOptions } from 'app/graphql';

import logger from 'app/logger';

function register(server, options, next) {
  server.register(
    [
      {
        register: graphqlHapi,
        options: {
          path: '/graphql',
          graphqlOptions,
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
