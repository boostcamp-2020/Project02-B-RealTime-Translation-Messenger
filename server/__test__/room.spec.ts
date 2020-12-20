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

const ENTER_ROOM = gql`
  mutation enterRoom($nickname: String!, $avatar: String!, $lang: String!, $code: String!) {
    enterRoom(nickname: $nickname, avatar: $avatar, lang: $lang, code: $code) {
      userId
      roomId
      token
    }
  }
`;

const ROOM_BY_ID = gql`
  query roomById($id: Int!) {
    roomById(id: $id) {
      id
      users {
        id
      }
      messages {
        id
      }
    }
  }
`;

const ALL_ROOMS = gql`
  query {
    allRooms {
      id
      users {
        id
      }
      messages {
        id
      }
    }
  }
`;

describe('채팅방 생성/입장 API TEST', () => {
  const { nickname, avatar, lang } = requestUser;
  let code: string;
  test('채팅방 생성', async () => {
    const {
      data: { createRoom },
      errors,
    } = await mutate({
      mutation: CREATE_ROOM,
      variables: {
        nickname,
        avatar,
        lang,
      },
    });
    expect(errors).toEqual(undefined);
    code = createRoom.code;
  });
  test('생성한 채팅방에 입장', async () => {
    const {
      data: { enterRoom },
    } = await mutate({
      mutation: ENTER_ROOM,
      variables: { nickname, avatar, lang, code },
    });
    expect(enterRoom).toHaveProperty('userId');
    expect(enterRoom).toHaveProperty('roomId');
    expect(enterRoom).toHaveProperty('token');
  });
});

test('채팅방 정보를 채팅방 id로 조회하는 API TEST', async () => {
  const { roomId } = requestUser;
  const {
    data: { roomById },
  } = await query({ query: ROOM_BY_ID, variables: { id: roomId } });
  expect(roomById).toHaveProperty('id');
  expect(roomById.users).not.toBeNull();
  expect(roomById.messages).not.toBeNull();
});

test('모든 채팅방을 조회하는 API TEST', async () => {
  const {
    data: { allRooms },
  } = await query({ query: ALL_ROOMS });
  expect(allRooms[0]).toHaveProperty('id');
  expect(allRooms[0].users).not.toBeNull();
  expect(allRooms[0].messages).not.toBeNull();
});
