import { USER_ROLE } from 'app/constants';

export default function defineUserModel(sequelize, DataTypes) {
  const User = sequelize.define(
    'User',
    {
      emailForLogin: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
      },
      password: DataTypes.STRING,
      role: {
        type: DataTypes.ENUM(USER_ROLE.USER, USER_ROLE.ADMIN),
        allowNull: false,
      },
      displayName: {
        type: DataTypes.STRING,
        allowNull: false,
      },

      passwordResetToken: DataTypes.STRING,
      passwordResetTokenExpires: DataTypes.DATE,

      googleAccountEmail: DataTypes.STRING,
    },
    {
      hooks: {
        async afterCreate(user, options) {
          // TODO: actions to do after a user signs up
        },
      },
    }
  );

  User.prototype.toJSON = function() {
    const privateAttributes = [
      'password',
      'passwordResetToken',
      'passwordResetTokenExpires',
    ];
    return _.omit(this.dataValues, privateAttributes);
  };

  return User;
}
