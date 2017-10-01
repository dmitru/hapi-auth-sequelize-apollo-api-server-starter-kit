import logger from 'app/logger';
import { schema as graphQLSchema } from 'app/graphql/schema';

export const graphqlOptions = async request => ({
  schema: graphQLSchema,
  context: {
    auth: request.auth,
  },
  formatError: (err) => {
    logger.error('graphql error: ', err);
    return err;
  },
});
