import { gql } from '@apollo/client';

export const NEW_USER = gql`
  subscription newUser($roomId: Int!) {
    newUser(roomId: $roomId) {
      id
      avatar
      nickname
      lang
    }
  }
`;

export const DELETE_USER = gql`
  mutation {
    deleteUser
  }
`;

export const SUBSCRIBE_DELETE_USER = gql`
  subscription deleteUser($roomId: Int!) {
    deleteUser(roomId: $roomId) {
      id
    }
  }
`;
