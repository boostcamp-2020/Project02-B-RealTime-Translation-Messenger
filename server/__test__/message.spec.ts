import { gql } from 'apollo-server';
import { query, mutate } from './testServer';
import { testUser } from './mock.json';

const ALL_MESSAGES_BY_PAGE = gql`
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

const CREATE_MESSAGE = gql`
  mutation createMessage($text: String!) {
    createMessage(text: $text)
  }
`;

const CREATE_ROOM = gql`
  mutation createRoom($nickname: String!, $avatar: String!, $lang: String!) {
    createRoom(nickname: $nickname, avatar: $avatar, lang: $lang) {
      userId
      roomId
      code
      token
    }
  }
`;

describe('방 생성 후 채팅 API 테스트', () => {
  const user = testUser;
  test('Create Room', async () => {
    const { errors } = await mutate({
      mutation: CREATE_ROOM,
      variables: {
        nickname: user.nickname,
        avatar: user.avatar,
        lang: user.lang,
      },
    });
    expect(errors).toEqual(undefined);
  });
  test('Create Message', async () => {
    const text = '안녕';
    const {
      data: { createMessage },
    } = await mutate({ mutation: CREATE_MESSAGE, variables: { text } });
    expect(createMessage).toEqual(true);
  });
});

describe('메시지 생성후 all message by page로 1페이지 조회', () => {
  const user = testUser;
  test('Create Message', async () => {
    const text = '새로운 메시지';
    const {
      data: { createMessage },
    } = await mutate({ mutation: CREATE_MESSAGE, variables: { text } });
    expect(createMessage).toEqual(true);
  });
  test('all messages by page 1', async () => {
    const page = 1;
    const {
      data: { allMessagesByPage },
    } = await query({ query: ALL_MESSAGES_BY_PAGE, variables: { page } });
    const messages = allMessagesByPage.messages;
    const messageCnt = messages.length;
    expect(messages[messageCnt - 1].user.nickname).toEqual(user.nickname);
  });
});
