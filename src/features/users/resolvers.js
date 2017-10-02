/* eslint-disable no-unused-vars */
import Boom from 'boom';

import User from './dao';
import { requiresAdmin, requiresAuth } from './permissions';

export default pubsub => ({
  Query: {
    users: requiresAdmin.createResolver(() => User.getUsers()),
    user: (obj, { id }) => User.getUser(id),
    me: requiresAuth.createResolver((obj, info, context) => context.user),
  },
  Mutation: {
    updateProfile: (obj, { id, ...otherData }) => User.update(id, otherData),
  },
  Subscription: {},
});
