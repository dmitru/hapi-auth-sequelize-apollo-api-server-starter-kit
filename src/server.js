import path from 'path';
import glob from 'glob';
import Hapi from 'hapi';
import Good from 'good';

import AuthHapiPlugin from 'app/features/users/auth.hapiPlugin';
import SocialAuthHapiPlugin from 'app/features/users/socialAuth.hapiPlugin';
import GraphQLHapiPlugin from 'app/graphql/graphql.hapiPlugin';

import logger from 'app/logger';
import GoodWinston from 'good-winston';

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
      await models.sequelize.sync();
      logger.info('Server: connection to the DB has been established successfully');
    } catch (err) {
      logger.error('Server: error while connecting to the DB', err);
      reject(err);
      return;
    }
    try {
      server.register(
        [
          {
            register: AuthHapiPlugin,
          },
          {
            register: SocialAuthHapiPlugin,
          },
          {
            register: GraphQLHapiPlugin,
          },
          {
            register: Good,
            options: {
              reporters: {
                winston: [goodWinstonStream],
              },
            },
          },
        ],
        (err) => {
          if (err) {
            logger.error('Error while registering Hapi plugins: ', err);
            reject(err);
            return;
          }

          // Look through the routes in
          // all the subdirectories of API
          // and create a new route for each
          logger.debug('createServer: Scanning features/**/routes/*.js for route files...');
          glob.sync(path.join(__dirname, 'features/**/routes/*.js')).forEach((file) => {
            logger.debug(`createServer: Adding route ${file}`);
            const route = require(file).default;
            server.route(route);
          });

          resolve(server);
        },
      );
    } catch (err) {
      reject(err);
    }
  });
}

module.exports = createServer;
