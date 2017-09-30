import path from 'path';
import normalizeUrl from 'normalize-url';

import dotenv from 'dotenv';

dotenv.config({ path: path.join(__dirname, '../.env') });

const webAppPublicUrl = normalizeUrl(process.env.WEBAPP_PUBLIC_URL || 'http://localhost:3000');

export default {
  webAppPublicUrl,
  jwtSecret:
    process.env.JWT_SECRET || 'development-secret-key-at-least-32-chars-long',

  db: {
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD || null,
    database: process.env.DB_DATABASE,
    host: process.env.DB_HOST || '127.0.0.1',
    port: process.env.DB_PORT || 5432,
    dialect: 'postgres',
    logging: false,
  },

  recaptchaSecretKey: process.env.RECAPTCHA_SECRET_KEY,

  socialAuth: {
    redirectTo: `${webAppPublicUrl}/`,
    google: {
      clientId: process.env.AUTH_GOOGLE_CLIENT_ID || 'XXX',
      clientSecret: process.env.AUTH_GOOGLE_CLIENT_SECRET || 'XXX',
    },
  },
};
