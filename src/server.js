import path from 'path';
import glob from 'glob';
import Hapi from 'hapi';
import Good from 'good';

import { graphqlHapi, graphiqlHapi } from 'apollo-server-hapi';
import { schema as graphQLSchema } from 'app/graphql/schema';

import logger from 'app/logger';
import GoodWinston from 'good-winston';

import { validateSession } from 'app/api/auth/utils';
import config from 'app/config';
import models from 'app/models';

const goodWinstonStream = new GoodWinston({ winston: logger });

function createServer() {
  return new Promise(async (resolve, reject) => {
    // Create a server with a host and port
    const server = new Hapi.Server();
    server.connection({
      host: process.env.HOST || 'localhost',
      port: process.env.PORT || 8000,
    });

    try {
      await models.sequelize.authenticate();
      logger.info('Server: connection to the DB has been established successfully');
    } catch (err) {
      logger.error('Server: error while connecting to the DB', err);
      throw err;
    }

    server.state('auth-token', {
      path: '/',
      isSameSite: 'Lax',
      ttl: 1000 * 60 * 30, // 30 mins
      isSecure: process.env.NODE_ENV === 'production',
      isHttpOnly: false,
      clearInvalid: false,
      strictHeader: true,
    });

    models.sequelize.sync().then(() => {
      server.register(
        [
          {
            register: graphqlHapi,
            options: {
              path: '/graphql',
              graphqlOptions: async request => ({
                schema: graphQLSchema,
                context: {
                  auth: request.auth,
                },
              }),
              route: {
                cors: true,
              },
            },
          },
          {
            register: graphiqlHapi,
            options: {
              path: '/graphiql',
              graphiqlOptions: {
                endpointURL: '/graphql',
              },
            },
          },
          {
            register: Good,
            options: {
              reporters: {
                winston: [goodWinstonStream],
              },
            },
          },
          {
            register: require('hapi-auth-jwt2'),
          },
          {
            register: require('bell'),
          },
        ],
        (err) => {
          if (err) {
            reject(err);
          }

          server.auth.strategy('jwt', 'jwt', 'required', {
            key: config.jwtSecret,
            verifyOptions: { algorithms: ['HS256'], ignoreExpiration: true },
            validateFunc: validateSession,
            errorFunc: (errorContext) => {
              errorContext.errorType = 'unauthorized';
              errorContext.message = 'session-expired';
              return errorContext;
            },
          });

          server.auth.strategy('google', 'bell', {
            provider: 'google',
            password: config.jwtSecret,
            clientId: config.socialAuth.google.clientId,
            clientSecret: config.socialAuth.google.clientSecret,
            isSecure: process.env.NODE_ENV === 'production',
            location: config.webAppPublicUrl,
          });

          // Look through the routes in
          // all the subdirectories of API
          // and create a new route for each
          logger.debug('createServer: Scanning api/**/routes/*.js for route files...');
          glob.sync(path.join(__dirname, 'api/**/routes/*.js')).forEach((file) => {
            logger.debug(`createServer: Adding route ${file}`);
            const route = require(file).default;
            server.route(route);
          });

          resolve(server);
        },
      );
    });
  });
}

module.exports = createServer;
