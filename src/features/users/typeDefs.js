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
  updateMyProfile(
    displayName: String
  ): User!

  updateMyPassword(
    password: String!
  ): User!

  changeRole(
    id: Int!
    role: String!
  ): User!

  deleteUser(id: Int!): Boolean!
}
`;

export default [User];
