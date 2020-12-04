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
    }
  }
`;

export const CREATE_ROOM = gql`
  mutation createRoom($nickname: String!, $avatar: String!, $lang: String!) {
    createRoom(nickname: $nickname, avatar: $avatar, lang: $lang) {
      userId
      roomId
      code
    }
  }
`;

export const ROOM_BY_ID = gql`
  query roomById($id: Int!) {
    roomById(id: $id) {
      users {
        avatar
        nickname
        lang
      }
    }
  }
`;

export const ALL_MESSAGES_BY_ID = gql`
  query allMessagesById($id: Int!) {
    allMessagesById(id: $id) {
      id
      text
      source
      createdAt
      user {
        id
        nickname
        avatar
        lang
      }
    }
  }
`;

export const CREATE_MESSAGE = gql`
  mutation createMessage(
    $text: String!
    $source: String!
    $userId: Int!
    $roomId: Int!
  ) {
    createMessage(
      text: $text
      source: $source
      userId: $userId
      roomId: $roomId
    )
  }
`;

export const NEW_MESSAGE = gql`
  subscription($roomId: Int!, $lang: String!) {
    newMessage(roomId: $roomId, lang: $lang) {
      id
      text
      source
      createdAt
      user {
        id
        nickname
        avatar
        lang
      }
    }
  }
`;
