/* eslint-disable no-unused-vars */
import Boom from 'boom';

import { AuthenticationRequiredError, ForbiddenError, DoesNotExistError } from 'app/graphql/errors';
import { baseResolver } from 'app/graphql/resolvers';
import { USER_ROLE } from 'app/constants';

import User from './dao';
import { hashPassword } from './authUtils';

export const isAuthenticatedResolver = baseResolver.createResolver(async (parent, args, { user }) => {
  if (!user) throw new AuthenticationRequiredError();
});

export const isAdminResolver = isAuthenticatedResolver.createResolver((parent, args, { user }) => {
  if (!user || user.role != USER_ROLE.ADMIN) throw new ForbiddenError();
});

export default pubsub => ({
  Query: {
    users: isAuthenticatedResolver.createResolver(() => User.getUsers()),
    user: isAuthenticatedResolver.createResolver(async (obj, { id }) => {
      const user = await User.getUser(id);
      if (!user) {
        throw new DoesNotExistError({
          message: 'User does not exist',
        });
      }
    }),
    me: isAuthenticatedResolver.createResolver((obj, info, context) => context.user),
  },
  Mutation: {
    updateMyProfile: isAuthenticatedResolver.createResolver((obj, data, { user }) =>
      User.update(user.id, data)),
    changeRole: isAdminResolver.createResolver((obj, { id, role }, context) =>
      User.update(id, { role })),
    updateMyPassword: isAuthenticatedResolver.createResolver(async (obj, { password }, { user }) =>
      User.update(user.id, {
        password: await hashPassword(password),
      })),
    deleteUser: isAdminResolver.createResolver(async (obj, { id }) => (await User.delete(id)) === 1),
  },
  Subscription: {},
});
