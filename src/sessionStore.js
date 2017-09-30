import redis from 'redis';
import logger from 'app/logger';

export class SessionStore {
  init(options) {
    this.client = redis.createClient(options);
    this.client.on('error', err => {
      logger.error('SessionStore: redis error: ', err);
    });
  }

  set(key, data) {
    const dataTransformed =
      typeof data === 'string' ? data : JSON.stringify(data);
    logger.debug(`SessionStore: set ${key}`);
    this.client.set(key, dataTransformed);
  }

  del(key) {
    logger.debug(`SessionStore: del ${key}`);
    this.client.del(key);
  }

  get(key) {
    return new Promise((resolve, reject) => {
      logger.debug(`SessionStore: get ${key}`);
      this.client.get(key, (err, result) => {
        if (err) {
          logger.error('SessionStore: redis error (get): ', err);
          return reject(err);
        }
        return resolve(result);
      });
    });
  }
}

const sessionStore = new SessionStore();
sessionStore.init({
  host: process.env.REDIS_HOST || '127.0.0.1',
  port: process.env.REDIS_PORT || '6379',
});

export default sessionStore;
