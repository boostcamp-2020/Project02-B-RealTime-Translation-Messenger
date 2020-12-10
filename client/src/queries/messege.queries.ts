import { gql } from '@apollo/client';

// eslint-disable-next-line import/prefer-default-export
export const CREATE_MESSAGE = gql`
  mutation createMessage($text: String!) {
    createMessage(text: $text)
  }
`;

export const TRANSLATION = gql`
  mutation translation($text: String!) {
    translation(text: $text) {
      translatedText
    }
  }
`;

export const ALL_MESSAGES_BY_PAGE = gql`
  query allMessagesByPage($page: Int!) {
    allMessagesByPage(page: $page) {
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
