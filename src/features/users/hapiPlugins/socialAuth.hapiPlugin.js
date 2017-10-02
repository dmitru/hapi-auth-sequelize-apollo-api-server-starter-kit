import bellPlugin from 'bell';

import logger from 'app/logger';
import config from 'app/config';

function register(server, options, next) {
  // Enable social auth providers
  server.register(
    [
      {
        register: bellPlugin,
      },
    ],
    (err) => {
      if (err) {
        logger.error('Error while registering bell Hapi plugin', err);
        throw err;
      }

      server.auth.strategy('google', 'bell', {
        provider: 'google',
        password: config.jwtSecret,
        clientId: config.socialAuth.google.clientId,
        clientSecret: config.socialAuth.google.clientSecret,
        isSecure: process.env.NODE_ENV === 'production',
        location: config.webAppPublicUrl,
      });

      next();
    },
  );
}

register.attributes = {
  name: 'auth-social-hapi-plugin',
};

export default {
  register,
};
