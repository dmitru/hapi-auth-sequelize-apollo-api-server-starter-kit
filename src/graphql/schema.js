import { makeExecutableSchema } from 'graphql-tools';

import features from 'app/features';

const RootQuery = `
type Query {
  dummy: Int
}

type Mutation {
  dummy: Int
}

type Subscription {
  dummy: Int
}
`;
const SchemaDefinition = `
schema {
  query: Query
  mutation: Mutation
  subscription: Subscription
}
`;

const typeDefs = [SchemaDefinition, RootQuery, ...features.typeDefs];
const resolvers = features.createResolvers();

const schema = makeExecutableSchema({ typeDefs, resolvers });
export { schema };
