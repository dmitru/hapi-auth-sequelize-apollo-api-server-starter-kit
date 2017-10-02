/* eslint-disable no-unused-vars */

import { isAuthenticatedResolver } from 'app/features/users/resolvers';
import { baseResolver } from 'app/graphql/resolvers';

export default pubsub => ({
  Query: {
    ping: baseResolver.createResolver(() => 'pong'),
    pingProtected: isAuthenticatedResolver.createResolver(() => 'pong'),
  },
  Mutation: {},
  Subscription: {},
});
