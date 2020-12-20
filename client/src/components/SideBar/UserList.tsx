import React from 'react';
import { User } from '@generated/types';
import styled from 'styled-components';

const UserListWrapper = styled.ul`
  width: 100%;
  height: 85vh;
  overflow-x: hidden;
  overflow-y: scroll;

  &::-webkit-scrollbar {
    width: 10px;
    background-color: inherit;
  }
  &::-webkit-scrollbar-thumb {
    background-color: ${(props) => props.theme.whiteColor};
    background-clip: padding-box;
    border: 2px solid transparent;
    border-radius: 16px;
  }
`;
const UserInfo = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1.5rem 1.5rem 0 1.5rem;
`;
const Avatar = styled.img`
  width: 3rem;
  height: 3rem;
  background-color: ${(props) => props.theme.whiteColor};
  border-radius: 100%;
`;

interface Props {
  users: User[];
}

const UserList: React.FC<Props> = ({ users }) => {
  return (
    <UserListWrapper>
      {users.map((user) => (
        <li key={user.id}>
          <UserInfo>
            <Avatar src={user.avatar} />
            <div>{user.nickname}</div>
            <div>{user.lang}</div>
          </UserInfo>
        </li>
      ))}
    </UserListWrapper>
  );
};

export default UserList;
