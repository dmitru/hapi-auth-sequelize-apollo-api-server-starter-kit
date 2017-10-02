/* eslint-disable no-unused-vars */
import Boom from 'boom';
import User from 'app/features/users/dao';

export default pubsub => ({
  Query: {
    users: () => User.getUsers(),
    user: (obj, { id }) => User.getUser(id),
    me: (obj, info, context) => {
      const { auth } = context;
      if (!auth || !auth.isAuthenticated || !auth.credentials || !auth.credentials.userId) {
        throw new Error(Boom.unauthorized());
      }

      const { credentials: { userId } } = auth;
      return User.getUser(userId);
    },
  },
  Mutation: {
    updateProfile: (obj, { id, ...otherData }) => User.update(id, otherData),
  },
  Subscription: {},
});
