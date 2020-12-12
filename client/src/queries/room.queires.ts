import { gql } from '@apollo/client';

export const ENTER_ROOM = gql`
  mutation enterRoom(
    $nickname: String!
    $avatar: String!
    $lang: String!
    $code: String!
  ) {
    enterRoom(nickname: $nickname, avatar: $avatar, lang: $lang, code: $code) {
      userId
      roomId
      token
    }
  }
`;

export const CREATE_ROOM = gql`
  mutation createRoom($nickname: String!, $avatar: String!, $lang: String!) {
    createRoom(nickname: $nickname, avatar: $avatar, lang: $lang) {
      userId
      roomId
      code
      token
    }
  }
`;

export const ROOM_BY_ID = gql`
  query roomById($id: Int!) {
    roomById(id: $id) {
      users {
        id
        avatar
        nickname
        lang
        isDeleted
      }
    }
  }
`;
