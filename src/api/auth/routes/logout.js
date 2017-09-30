import sessionStore from 'app/sessionStore';
import { invalidateSessionToken } from '../utils';

export default {
  method: 'POST',
  path: '/api/logout/',
  config: {
    handler: (req, res) => {
      const { credentials } = req.auth;
      sessionStore.get(credentials.id).then((reply) => {
        const session = JSON.parse(reply);
        session.valid = false;
        session.ended = new Date().getTime();

        invalidateSessionToken(session);

        res({ text: 'You have been logged out' });
      });
    },
  },
};
