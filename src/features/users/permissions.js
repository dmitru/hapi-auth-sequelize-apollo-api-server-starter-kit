import { USER_ROLE } from 'app/constants';

import User from './dao';

const createResolver = (resolver) => {
  const baseResolver = resolver;
  baseResolver.createResolver = (childResolver) => {
    const newResolver = async (parent, args, context) => {
      await resolver(parent, args, context);
      return childResolver(parent, args, context);
    };
    return createResolver(newResolver);
  };
  return baseResolver;
};

export const requiresAuth = createResolver(async (parent, args, context) => {
  const { auth } = context;
  if (!auth || !auth.isAuthenticated || !auth.credentials || !auth.credentials.userId) {
    throw new Error('Not authenticated');
  }

  const { credentials: { userId } } = auth;
  const user = await User.getUser(userId);

  if (!user) {
    throw new Error('Not authenticated');
  }
  context.user = user;
});

export const requiresAdmin = requiresAuth.createResolver((parent, args, context) => {
  if (!context.user || context.user.role !== USER_ROLE.ADMIN) {
    throw new Error('Requires admin access');
  }
});
