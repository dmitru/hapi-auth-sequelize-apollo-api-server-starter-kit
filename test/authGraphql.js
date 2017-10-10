import request from 'supertest';
import chai from 'chai';
import chaiHttp from 'chai-http';

import createServer from 'app/server';

chai.should();
chai.use(chaiHttp);

let server;
process.on('exit', () => {
  if (server) {
    server.stop({ timeout: 0 });
  }
});

describe('Auth GraphQL', () => {
  before((done) => {
    createServer()
      .then((createdServer) => {
        server = createdServer;
      })
      .then(() => done())
      .catch(done);
  });

  describe('query:me', () => {
    it('should not allow to execute GraphQL without authentication', (done) => {
      request(server.listener)
        .post('/graphql')
        .send({
          query: 'query { me { id } }',
          variables: null,
        })
        .set('Content-Type', 'application/json')
        .set('Accept', 'application/json')
        .expect(401, done);
    });

    it('should not allow to access GrapihQL without authentication', (done) => {
      request(server.listener)
        .get('/graphiql')
        .expect(401, done);
    });
  });
});
