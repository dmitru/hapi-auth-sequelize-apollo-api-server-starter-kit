const User = `
type User {
  id: Int!
  email: String!
  displayName: String
  role: String!
}

extend type Query {
  me: User
  user(id: Int!): User
  users: [User!]!
}

extend type Mutation {
  updateProfile(
    id: Int!
    displayName: String
  ): User!
}
`;

export default [User];
