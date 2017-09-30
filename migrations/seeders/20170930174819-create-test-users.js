import 'babel-polyfill';

import { hashPassword } from 'app/api/auth/utils';
import { USER_ROLE } from 'app/constants';

module.exports = {
  async up(queryInterface, Sequelize) {
    const hashedPassword = await hashPassword('password');
    return queryInterface.bulkInsert(
      'Users',
      [
        {
          email: 'user@test.com',
          password: hashedPassword,
          role: USER_ROLE.USER,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          email: 'admin@test.com',
          password: hashedPassword,
          role: USER_ROLE.ADMIN,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ],
      {},
    );
  },

  down(queryInterface, Sequelize) {
    return queryInterface.bulkDelete('Users', null, {});
  },
};
