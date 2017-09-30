import models from 'app/models';

const resolvers = {
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
};

export default resolvers;
