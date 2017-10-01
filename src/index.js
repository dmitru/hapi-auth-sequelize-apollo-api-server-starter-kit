import createServer from 'app/server';
import logger from 'app/logger';

createServer()
  .then(server =>
    new Promise((resolve, reject) => {
      server.start((err) => {
        if (err) {
          reject(err);
          return;
        }
        resolve(server);
      });
    }))
  .catch((err) => {
    logger.error(err);
    process.exit(1);
  })
  .then((server) => {
    logger.info('Server running at:', server.info.uri);
  });
