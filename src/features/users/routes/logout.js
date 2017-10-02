import { invalidateSessionBySessionId } from '../authUtils';

export default {
  method: 'POST',
  path: '/api/logout/',
  config: {
    handler: async (req, res) => {
      const { credentials: { sessionId } } = req.auth;
      await invalidateSessionBySessionId(sessionId);
      res({ text: 'You have been logged out' });
    },
  },
};
