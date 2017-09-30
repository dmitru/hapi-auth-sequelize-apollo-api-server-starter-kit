import models from 'app/models';
import { createSessionTokenAndLogin, hashPassword } from 'app/api/auth/utils';

export async function createUser(data) {
  const { password } = data;
  const hashedPassword = await hashPassword(password);
  const dataWithHashedPassword = Object.assign({}, data, {
    password: hashedPassword,
  });
  return models.User.build(dataWithHashedPassword).save();
}

export async function createUserAndLogin(data) {
  const user = await createUser(data);
  const token = await createSessionTokenAndLogin(user);
  return { user, token };
}

export function removeAll() {
  return models.User.destroy({ truncate: true, cascade: true });
}

export function removeAllUsers() {
  return models.User.destroy({ truncate: true, cascade: true });
}
