'use strict';

const config = require('app/config');

const Boom = require('boom');
const constants = require('app/constants');
const { ACCOUNT_TYPE, SUBSCRIPTION_PLAN_IDS, BILLING_PERIOD } = constants;

const logger = require('app/logger');
const models = require('app/models');
const signupSchema = require('../schemas/signup');
const userFunctions = require('../util');
const { hashPassword, verifyUniqueUser, createToken } = userFunctions;

module.exports = {
  method: 'POST',
  path: '/api/signupWithEmailAndPassword/',
  config: {
    auth: false,
    // Before the route handler runs, verify that the user is unique
    pre: [{ method: verifyUniqueUser }],
    handler: (req, res) => {
      const {
        stripeToken,
        email,
        accountType,
        firstName,
        lastName,
        pkcCode,
        billingPeriod,
      } = req.payload;

      const userSetupPromise = ([stripeCustomer, subscription]) => {
        const userData = {
          stripeCustomerId: stripeCustomer.id,
          subscriptionId: subscription.id,
        };
        return Promise.all([
          Promise.resolve(userData),
          hashPassword(req.payload.password),
        ])
          .then(([{ stripeCustomerId, subscriptionId }, passwordHash]) =>
            models.User
              .build({
                accountType,
                email,
                password: passwordHash,
                firstName,
                lastName,
                stripeCustomerId,
                stripeSubscriptionId: subscriptionId,
                signupCompleted: true,
                billingPeriod,
                subscriptionPlan,
              })
              .save()
          )
          .then(user => res({ user, token: createToken(user) }).code(201))
          .catch(err => {
            res(Boom.badImplementation(err));
          });
      };

      stripeSetupPromise.then(userSetupPromise, error => {
        logger.error('signup: error while processing payment:', error);
        let errorMsg = 'Could not process the payment.';
        if (error.message) {
          errorMsg += ` Reason: ${error.message}`;
        }
        res(Boom.serverUnavailable(errorMsg));
      });
    },
    // Validate the payload against the Joi schema
    validate: {
      payload: signupSchema,
    },
  },
};
