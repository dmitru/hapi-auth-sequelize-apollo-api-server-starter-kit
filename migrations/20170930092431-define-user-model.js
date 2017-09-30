import { USER_ROLE } from 'app/constants';

module.exports = {
  up: function(queryInterface, Sequelize) {
    return queryInterface.createTable('Users', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER,
      },
      emailForLogin: {
        type: Sequelize.STRING,
        allowNull: false,
        unique: true,
      },
      password: {
        type: Sequelize.STRING,
      },
      displayName: {
        type: Sequelize.STRING,
      },
      role: {
        type: Sequelize.ENUM(USER_ROLE.USER, USER_ROLE.ADMIN),
        allowNull: false,
      },
      passwordResetToken: {
        type: Sequelize.STRING,
      },
      passwordResetTokenExpires: {
        type: Sequelize.DATE,
      },
      googleAccountEmail: {
        type: Sequelize.STRING,
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
    });
  },

  down: function(queryInterface, Sequelize) {
    return queryInterface.dropTable('Users');
  },
};
