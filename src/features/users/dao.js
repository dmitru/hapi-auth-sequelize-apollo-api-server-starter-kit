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

  async getUsers() {
    return models.User.findAll();
  }

  async create(data) {
    return models.User.build(data).save();
  }

  async delete(id) {
    return models.User.destroy({
      where: { id },
      limit: 1,
    });
  }

  async update(id, data) {
    const user = await this.getUser(id);
    if (!user) {
      throw new Error('No such user');
    }
    return user.update(data);
  }
}

const userDao = new UserDAO();

export default userDao;
