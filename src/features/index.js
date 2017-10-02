import glob from 'glob';
import path from 'path';

import logger from 'app/logger';

import { combineFeatures } from './feature';

const featureModules = [];
glob.sync(path.join(__dirname, '*/index.js')).forEach((file) => {
  logger.debug(`features: Adding feature ${file}`);
  const featureModule = require(file).default;
  featureModules.push(featureModule);
});
const features = combineFeatures(...featureModules);

export default features;
