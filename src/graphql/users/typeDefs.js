const User = `
type User {
  id: Int!
  email: String!
  displayName: String
}

extend type Query {
  users: [User!]!
  user(id: Int!): User
}
`;

export default [User];
