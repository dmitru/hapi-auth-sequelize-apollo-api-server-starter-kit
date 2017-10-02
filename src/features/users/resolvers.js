/* eslint-disable no-unused-vars */
import Boom from 'boom';

import { USER_ROLE } from 'app/constants';

import User from './dao';
import { hashPassword } from './authUtils';
import { canUserUpdateProfile, requiresAdmin, requiresAuth } from './permissions';

export default pubsub => ({
  Query: {
    users: requiresAuth.createResolver(() => User.getUsers()),
    user: (obj, { id }) => User.getUser(id),
    me: requiresAuth.createResolver((obj, info, context) => context.user),
  },
  Mutation: {
    updateProfile: requiresAuth.createResolver((obj, { id, ...otherData }, context) => {
      if (!(context.user.role === USER_ROLE.ADMIN || context.user.id === id)) {
        throw new Error('unauthorized');
      }
      return User.update(id, otherData);
    }),
    changeRole: requiresAdmin.createResolver((obj, { id, role }, context) =>
      User.update(id, { role })),
    updatePassword: requiresAuth.createResolver(async (obj, { id, password }, context) => {
      if (!(context.user.role === USER_ROLE.ADMIN || context.user.id === id)) {
        throw new Error('unauthorized');
      }
      return User.update(id, {
        password: await hashPassword(password),
      });
    }),
    deleteUser: requiresAuth.createResolver(async (obj, { id }, context) => {
      if (!(context.user.role === USER_ROLE.ADMIN || context.user.id === id)) {
        throw new Error('unauthorized');
      }
      return (await User.delete(id)) === 1;
    }),
  },
  Subscription: {},
});
