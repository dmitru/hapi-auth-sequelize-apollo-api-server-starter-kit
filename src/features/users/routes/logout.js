import { invalidateSessionBySessionId } from '../auth';

export default {
  method: 'POST',
  path: '/api/logout/',
  config: {
    handler: async (req, res) => {
      const { credentials } = req.auth;
      const sessionId = credentials.id;
      await invalidateSessionBySessionId(sessionId);
      res({ text: 'You have been logged out' });
    },
  },
};
