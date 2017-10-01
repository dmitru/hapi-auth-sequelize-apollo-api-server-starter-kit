import models from 'app/models';

class UserDAO {
  async getUser(id) {
    return models.User.findById(id);
  }

  async getUserByEmail(email) {
    return models.User.findOne({
      where: {
        email,
      },
    });
  }

  async create(data) {
    return models.User.build(data).save();
  }
}

const userDao = new UserDAO();

export default userDao;
