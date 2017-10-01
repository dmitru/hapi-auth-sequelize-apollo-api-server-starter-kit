import users from './users';
import graphqlTypes from './graphqlTypes';

import { combineFeatures } from './feature';

const features = combineFeatures(users, graphqlTypes);
export default features;
