import { gql } from '@apollo/client';

// eslint-disable-next-line import/prefer-default-export
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

export const TRANSLATION = gql`
  mutation translation($text: String!, $source: String!, $target: String!) {
    translation(text: $text, source: $source, target: $target) {
      translatedText
    }
  }
`;
