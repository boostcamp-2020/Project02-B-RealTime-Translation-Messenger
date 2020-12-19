import { gql } from 'apollo-server';
import { query, mutate } from './testServer';
import {
  createMessageData,
  requestUser,
  allMessageByPageData,
  createSystemMessageData,
} from './mockData.json';

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

const ALL_MESSAGES_BY_TIME = gql`
  query allMessagesByTime($time: String!) {
    allMessagesByTime(time: $time) {
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

const CREATE_SYSTEM_MESSAGE = gql`
  mutation($source: String!) {
    createSystemMessage(source: $source)
  }
`;

test('Create Message', async () => {
  const { text } = createMessageData;
  const {
    data: { createMessage },
  } = await mutate({ mutation: CREATE_MESSAGE, variables: { text } });
  expect(createMessage).toEqual(true);
});

describe('메시지 생성후 all message by page로 페이지 데이터 조회', () => {
  const user = requestUser;
  test('Create Message', async () => {
    const { text } = createMessageData;
    const {
      data: { createMessage },
    } = await mutate({ mutation: CREATE_MESSAGE, variables: { text } });
    expect(createMessage).toEqual(true);
  });
  test('all messages by page', async () => {
    const { page } = allMessageByPageData;
    const {
      data: { allMessagesByPage },
    } = await query({ query: ALL_MESSAGES_BY_PAGE, variables: { page } });
    const messages = allMessagesByPage.messages;
    const messageCnt = messages.length;
    expect(messages[messageCnt - 1].user.nickname).toEqual(user.nickname);
  });
});

describe('특정 timestamp 이후의 메시지를 조회', () => {
  let latestTimestamp = '';
  it('all messages by page', async () => {
    const { page } = allMessageByPageData;
    const {
      data: { allMessagesByPage },
    } = await query({ query: ALL_MESSAGES_BY_PAGE, variables: { page } });
    const messages = allMessagesByPage.messages;
    const messageCnt = messages.length;
    latestTimestamp = messages[messageCnt - 1].createdAt;
  });
  test('Create Message', async () => {
    const { text } = createMessageData;
    const {
      data: { createMessage },
    } = await mutate({ mutation: CREATE_MESSAGE, variables: { text } });
    expect(createMessage).toEqual(true);
  });
  test('all messages by time', async () => {
    const {
      data: { allMessagesByTime },
    } = await mutate({ mutation: ALL_MESSAGES_BY_TIME, variables: { time: latestTimestamp } });
    expect(allMessagesByTime.length).toEqual(1);
  });
});

describe('system message test', () => {
  const { source } = createSystemMessageData;
  test('Create System Message', async () => {
    const {
      data: { createSystemMessage },
    } = await mutate({ mutation: CREATE_SYSTEM_MESSAGE, variables: { source } });
    expect(createSystemMessage).toEqual(true);
  });
  let latestMessage = { text: '', source: '' };
  it('all messages by page', async () => {
    const { page } = allMessageByPageData;
    const {
      data: { allMessagesByPage },
    } = await query({ query: ALL_MESSAGES_BY_PAGE, variables: { page } });
    const messages = allMessagesByPage.messages;
    const messageCnt = messages.length;
    latestMessage = messages[messageCnt - 1];
  });
  test('Check system message', async () => {
    expect(latestMessage.source).toEqual(source);
  });
});
