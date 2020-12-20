import { gql } from 'apollo-server';
import { query, mutate } from './testServer';
import { requestUser } from './mockData.json';

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

const ALL_USERS = gql`
  query {
    allUsers {
      id
      nickname
      lang
      avatar
    }
  }
`;

const ME = gql`
  query {
    me {
      id
      nickname
      lang
      avatar
    }
  }
`;

describe('모든 사용자를 조회하는 API TEST', () => {
  const { nickname, avatar, lang } = requestUser;
  test('방 생성 후 사용자 수가 증가했는지 확인', async () => {
    const {
      data: { allUsers: beforeUser },
    } = await query({ query: ALL_USERS });
    const { errors } = await mutate({
      mutation: CREATE_ROOM,
      variables: {
        nickname,
        avatar,
        lang,
      },
    });
    expect(errors).toEqual(undefined);
    const {
      data: { allUsers: afterUser },
    } = await query({ query: ALL_USERS });

    const subtraction = afterUser.length - beforeUser.length;
    expect(subtraction).toEqual(1);
  });
});

describe('요청한 사용자의 정보를 반환하는 API TEST', () => {
  const { id, nickname, avatar, lang } = requestUser;
  test('방 생성', async () => {
    const { errors } = await mutate({
      mutation: CREATE_ROOM,
      variables: {
        nickname,
        avatar,
        lang,
      },
    });
    expect(errors).toEqual(undefined);
  });
  test('방 생성 후 해당 사용자 조회', async () => {
    const {
      data: { me },
    } = await query({ query: ME });
    expect(me).toMatchObject({ id, nickname, avatar, lang });
  });
});
