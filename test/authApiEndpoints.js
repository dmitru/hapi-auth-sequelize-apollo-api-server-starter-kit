import request from 'supertest';
import chai from 'chai';
import chaiHttp from 'chai-http';

import createServer from 'app/server';
import { USER_ROLE } from 'app/constants';

import { createUser, createUserAndLogin, removeAllUsers } from './utils';

const should = chai.should();
chai.use(chaiHttp);

const API_PREFIX = '/api';

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

describe('Auth', () => {
  before((done) => {
    createServer()
      .then((createdServer) => {
        server = createdServer;
      })
      .then(() => done())
      .catch(done);
  });

  describe('/loginWithEmailAndPassword/ POST', () => {
    before((done) => {
      removeAllUsers()
        .then(() => createUser(USER_DATA))
        .then(() => done())
        .catch(done);
    });

    it('should not login with non-existent email', (done) => {
      request(server.listener)
        .post(`${API_PREFIX}/loginWithEmailAndPassword/`)
        .send({
          email: 'foo@bar.com',
          password: 'password',
        })
        .set('Content-Type', 'application/json')
        .set('Accept', 'application/json')
        .expect(401, done);
    });

    it('should login and return user and token', (done) => {
      request(server.listener)
        .post(`${API_PREFIX}/loginWithEmailAndPassword/`)
        .send({
          email: 'user@test.com',
          password: 'password',
        })
        .set('Content-Type', 'application/json')
        .set('Accept', 'application/json')
        .expect(200)
        .expect((req) => {
          req.should.be.json;
          req.body.should.be.a('object');
          req.body.should.have.property('token').that.is.a('string');

          req.body.should.have.property('user').that.is.a('object');
          req.body.user.should.have.property('email').to.equal('user@test.com');
          req.body.user.should.have.property('id').that.is.a('number');

          req.body.user.should.not.have.property('password');
        })
        .end(done);
    });
  });

  describe('/signupWithEmailAndPassword/ POST', () => {
    const URL = `${API_PREFIX}/signupWithEmailAndPassword/`;

    const SIGNUP_DATA = {
      email: 'user2@test.com',
      password: 'password',
    };

    before((done) => {
      removeAllUsers()
        .then(() => createUserAndLogin(USER_DATA))
        .then(() => done())
        .catch(done);
    });

    it('should create new user and return user and token', (done) => {
      request(server.listener)
        .post(URL)
        .send(SIGNUP_DATA)
        .set('Content-Type', 'application/json')
        .set('Accept', 'application/json')
        .expect(201)
        .expect((req) => {
          req.should.be.json;
          req.body.should.be.a('object');
          req.body.should.have.property('token').that.is.a('string');

          req.body.should.have.property('user').that.is.a('object');
          req.body.user.should.have.property('email').to.equal('user2@test.com');
          req.body.user.should.have.property('id').that.is.a('number');
          req.body.user.should.not.have.property('password');
        })
        .end(done);
    });

    it('should return 409 for existing email', (done) => {
      request(server.listener)
        .post(URL)
        .send(SIGNUP_DATA)
        .set('Content-Type', 'application/json')
        .set('Accept', 'application/json')
        .expect(409, done);
    });

    it('should validate data', (done) => {
      function checkStatus({ data, status = 400 }) {
        return Promise.resolve(request(server.listener)
          .post(URL)
          .send(data)
          .set('Content-Type', 'application/json')
          .set('Accept', 'application/json')
          .expect(status));
      }

      const testCases = [
        { data: { password: 'abc' }, status: 400 },
        { data: { email: 'abc' }, status: 400 },
        { data: { email: 'abc', password: 'abc' }, status: 400 },
        { data: { email: 'abc@def.com', password: '' }, status: 400 },
        { data: { email: 'abc@def.com', password: 'abc' }, status: 400 },
        { data: { email: '', password: 'abcdef' }, status: 400 },
        { data: { email: 'abc@def.com', password: 'abcdef' }, status: 201 },
      ];
      Promise.all(testCases.map(checkStatus)).then(() => done(), done);
    });
  });

  describe('/logout/ POST', () => {
    let userToken;

    beforeEach((done) => {
      removeAllUsers()
        .then(() => createUserAndLogin(USER_DATA))
        .then(({ token }) => {
          userToken = token;
        })
        .then(() => done())
        .catch(done);
    });

    it('should not allow unauthenticated access', (done) => {
      request(server.listener)
        .post(`${API_PREFIX}/logout/`)
        .send()
        .set('Content-Type', 'application/json')
        .set('Accept', 'application/json')
        .expect(401, done);
    });

    it('should return 200 for an authenticated user', (done) => {
      request(server.listener)
        .post(`${API_PREFIX}/logout/`)
        .send()
        .set('Authorization', userToken)
        .set('Content-Type', 'application/json')
        .set('Accept', 'application/json')
        .expect(200, done);
    });

    it('should return 401 for a repeated logout attempt', (done) => {
      request(server.listener)
        .post(`${API_PREFIX}/logout/`)
        .send()
        .set('Authorization', userToken)
        .set('Content-Type', 'application/json')
        .set('Accept', 'application/json')
        .expect(200)
        .end(() => {
          request(server.listener)
            .post(`${API_PREFIX}/logout/`)
            .send()
            .set('Content-Type', 'application/json')
            .set('Accept', 'application/json')
            .expect(401, done);
        });
    });
  });
});
