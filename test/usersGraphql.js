import request from 'supertest';
import chai from 'chai';
import chaiHttp from 'chai-http';

import createServer from 'app/server';
import { USER_ROLE } from 'app/constants';

import { createUserAndLogin, removeAllUsers } from './utils';

chai.should();
chai.use(chaiHttp);

let server;
process.on('exit', () => {
  if (server) {
    server.stop({ timeout: 0 });
  }
});

const USER_DATA = {
  email: 'user@test.com',
  password: 'password',
  role: USER_ROLE.USER,
  displayName: 'Test User',
};

describe('Users GraphQL', () => {
  before((done) => {
    createServer()
      .then((createdServer) => {
        server = createdServer;
      })
      .then(() => done())
      .catch(done);
  });

  describe('query:me', () => {
    let userToken;

    before((done) => {
      removeAllUsers()
        .then(() => createUserAndLogin(USER_DATA))
        .then(({ token }) => {
          userToken = token;
        })
        .then(() => done())
        .catch(done);
    });

    it('should return current user for authenticated users', (done) => {
      request(server.listener)
        .post('/graphql')
        .send({
          query: 'query { me { id, email } }',
          variables: null,
        })
        .set('Authorization', userToken)
        .set('Content-Type', 'application/json')
        .set('Accept', 'application/json')
        .expect(200)
        .expect((req) => {
          req.should.be.json;
          req.body.should.be.a('object');
          req.body.should.have.property('data').that.is.a('object');

          req.body.data.should.have.property('me').that.is.a('object');
          req.body.data.me.should.have.property('email').to.equal(USER_DATA.email);
          req.body.data.me.should.have.property('id').that.is.a('number');
        })
        .end(done);
    });

    it('should not allow to return password', (done) => {
      request(server.listener)
        .post('/graphql')
        .send({
          query: 'query { me { password } }',
          variables: null,
        })
        .set('Authorization', userToken)
        .set('Content-Type', 'application/json')
        .set('Accept', 'application/json')
        .expect(400, done);
    });
  });
});
