'use strict';

const sessionStore = require('app/sessionStore');
const userFunctions = require('../util');
const { invalidateSessionToken } = userFunctions;

module.exports = {
  method: 'POST',
  path: '/api/logout/',
  config: {
    handler: (req, res) => {
      const credentials = req.auth.credentials;
      sessionStore.get(credentials.id).then(reply => {
        const session = JSON.parse(reply);
        session.valid = false;
        session.ended = new Date().getTime();
        invalidateSessionToken(session);
        res({ text: 'You have been logged out' });
      });
    },
  },
};
