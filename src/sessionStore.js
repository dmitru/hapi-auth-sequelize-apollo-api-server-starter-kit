import redis from 'redis';
import logger from 'app/logger';

export class RedisSessionStore {
  init(options) {
    this.client = redis.createClient(options);
    this.client.on('error', (err) => {
      logger.error('RedisSessionStore: redis error: ', err);
    });
  }

  set(key, data, expireSeconds = null) {
    const dataTransformed = typeof data === 'string' ? data : JSON.stringify(data);
    logger.debug(`RedisSessionStore: set ${key}`);

    if (expireSeconds != null) {
      this.client.set(key, dataTransformed, 'EX', expireSeconds);
    } else {
      this.client.set(key, dataTransformed);
    }
    return Promise.resolve();
  }

  del(key) {
    logger.debug(`RedisSessionStore: del ${key}`);
    this.client.del(key);
    return Promise.resolve();
  }

  get(key) {
    return new Promise((resolve, reject) => {
      logger.debug(`RedisSessionStore: get ${key}`);
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

export class MockedSessionStore {
  init() {
    this._store = {};
  }

  set(key, data) {
    const dataTransformed = typeof data === 'string' ? data : JSON.stringify(data);
    logger.debug(`MockedSessionStore: set ${key}`);
    this._store[key] = dataTransformed;
    return Promise.resolve();
  }

  del(key) {
    logger.debug(`MockedSessionStore: del ${key}`);
    delete this._store[key];
    return Promise.resolve();
  }

  get(key) {
    return Promise.resolve(this._store[key]);
  }
}

const SessionStore = process.env.NODE_ENV === 'test' ? MockedSessionStore : RedisSessionStore;

const sessionStore = new SessionStore();
sessionStore.init({
  host: process.env.REDIS_HOST || '127.0.0.1',
  port: process.env.REDIS_PORT || '6379',
});

export default sessionStore;
