/* eslint-disable no-unused-vars */
import models from 'app/models';

export default pubsub => ({
  Query: {
    users: () => models.User.findAll(),
    user: (obj, { id }) => models.User.findById(id),
    me: (obj, info, context) => {
      const { auth } = context;
      if (!auth || !auth.isAuthenticated || !auth.credentials || !auth.credentials.userId) {
        return null;
      }

      const { credentials: { userId } } = auth;
      return models.User.findById(userId);
    },
  },
  Mutation: {},
  Subscription: {},
});
