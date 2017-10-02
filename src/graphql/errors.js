import { createError } from 'apollo-errors';

export const UnknownError = createError('UnknownError', {
  message: 'An unknown error has occurred.  Please try again later',
});

export const DoesNotExistError = createError('DoesNotExistError', {
  message: 'The object you tried to access does not exist',
});

export const ForbiddenError = createError('ForbiddenError', {
  message: 'You are not allowed to do this',
});

export const AuthenticationRequiredError = createError('AuthenticationRequiredError', {
  message: 'You must be logged in to do this',
});

export const ServerError = createError('ServerError', {
  message: 'Server error occurred while processing your request',
});
