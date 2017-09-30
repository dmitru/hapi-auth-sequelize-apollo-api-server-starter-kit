import fs from 'fs';
import path from 'path';
import Sequelize from 'sequelize';

const basename = path.basename(module.filename);
const env = process.env.NODE_ENV || 'development';

import config from 'app/config';

const sequelize = new Sequelize(
  config.db.database,
  config.db.username,
  config.db.password,
  config.db
);
const models = {};

// Import models from all files in the current directory
fs
  .readdirSync(__dirname)
  .filter(file => file.indexOf('.') !== 0 && file !== basename)
  .forEach(file => {
    const model = sequelize.import(path.join(__dirname, file));
    models[model.name] = model;
  });

Object.keys(models).forEach(modelName => {
  if ('associate' in models[modelName]) {
    models[modelName].associate(models);
  }
});

sequelize._models = models;
models.sequelize = sequelize;
models.Sequelize = Sequelize;

export default models;
