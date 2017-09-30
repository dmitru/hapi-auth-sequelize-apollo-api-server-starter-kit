'use strict';

const winston = require('winston');

const tsFormat = () => new Date().toISOString();
const logger = new winston.Logger({
  transports: [
    new winston.transports.Console({
      timestamp: tsFormat,
      colorize: true,
    }),
  ],
});

logger.level = process.env.LOG_LEVEL || 'info';

module.exports = logger;
