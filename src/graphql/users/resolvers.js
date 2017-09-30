import models from 'app/models';

const resolvers = {
  Query: {
    users: () => models.User.findAll(),
    user: (_, { id }) => models.User.findById(id),
  },
};

export default resolvers;
