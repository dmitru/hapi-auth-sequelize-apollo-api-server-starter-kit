import glob from 'glob';
import path from 'path';
import Sequelize from 'sequelize';

import config from 'app/config';

const sequelize = new Sequelize(
  config.db.database,
  config.db.username,
  config.db.password,
  config.db,
);
const models = {};

// Import models from all files in the current directory
glob.sync(path.join(__dirname, '../features/**/models/*.js')).forEach((file) => {
  const model = sequelize.import(file);
  models[model.name] = model;
});

Object.keys(models).forEach((modelName) => {
  if ('associate' in models[modelName]) {
    models[modelName].associate(models);
  }
});

sequelize._models = models;
models.sequelize = sequelize;
models.Sequelize = Sequelize;

export default models;
