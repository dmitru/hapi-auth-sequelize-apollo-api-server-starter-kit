import { makeExecutableSchema, addMockFunctionsToSchema } from 'graphql-tools';

const typeDefs = `
type User {
   id: ID!
   email: String!
   role: String!
   displayName: String!
}

type Query {
  me: User!
  users: [User!]!
}
`;

const graphQLSchema = makeExecutableSchema({ typeDefs });
export { graphQLSchema };
