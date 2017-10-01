import _ from 'lodash';
import { makeExecutableSchema } from 'graphql-tools';

import { resolvers as userResolvers, typeDefs as userTypeDefs } from 'app/modules/users';

const RootQuery = `
type Query {
  dummy: Int
}
`;
const SchemaDefinition = `
schema {
  query: Query
}
`;

const typeDefs = [SchemaDefinition, RootQuery, ...userTypeDefs];

const rootResolvers = {};
const resolvers = _.merge(rootResolvers, userResolvers);

const schema = makeExecutableSchema({ typeDefs, resolvers });
export { schema };
