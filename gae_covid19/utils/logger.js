const {
    createLogger, format, transports,
  } = require('winston');

  // Imports the Google Cloud client library for Winston
const {LoggingWinston} = require('@google-cloud/logging-winston');

const loggingWinston = new LoggingWinston({
    serviceContext: {
      service: 'covid19', // required to auto-report logged errors to the Google Cloud Error Reporting console
      version: '1.0'
  }
});

  const {
    timestamp, json, combine, colorize, align, simple,
  } = format;
  
  let logFormat;
  if (process.env.LOCAL_DEV === 'true') {
    logFormat = combine(
      colorize({ all: true }),
      timestamp({
        format: 'YYYY-MM-DD HH:mm:ss',
      }),
      align(),
      simple(),
    );
  } else {
    logFormat = combine(
      timestamp({
        format: 'YYYY-MM-DD HH:mm:ss',
      }),
      json(),
    );
  }
  
  const logger = createLogger({
    transports: [new transports.Console({
      level: process.env.LOG_LEVEL || 'info',
    }),
    // Add Stackdriver Logging
    loggingWinston,
    ],
    format: logFormat,
    // automatically capture uncaught exceptions - not a default behavior
    exceptionHandlers: [
      new transports.Console(),
    ],
    defaultMeta: {
    },
  });
  module.exports = logger;
  