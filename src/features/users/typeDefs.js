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

  changeRole(
    id: Int!
    role: String!
  ): User!

  changePassword(
    id: Int!
    password: String!
  ): User!

  deleteUser(id: Int!)
}
`;

export default [User];
