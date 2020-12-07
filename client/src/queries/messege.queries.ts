import { gql } from '@apollo/client';

// eslint-disable-next-line import/prefer-default-export
export const CREATE_MESSAGE = gql`
  mutation createMessage($text: String!) {
    createMessage(text: $text)
  }
`;

export const TRANSLATION = gql`
  mutation translation($text: String!, $target: String!) {
    translation(text: $text, target: $target) {
      translatedText
    }
  }
`;

export const ALL_MESSAGES_BY_ID = gql`
  query allMessagesById($id: Int!, $page: Int!) {
    allMessagesById(id: $id, page: $page) {
      messages {
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
      nextPage
    }
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
