import React from 'react';
import { Hamburger } from '@components/Icons';
import { User } from '@generated/types';
import S from './style';

interface Props {
  visible: boolean;
  setVisible: React.Dispatch<React.SetStateAction<boolean>>;
  users: User[];
}

const SideBar: React.FC<Props> = ({ visible, setVisible, users }) => {
  return (
    <>
      <S.SideBarWrapper visible={visible}>
        <S.SideBarHeader>
          <S.HeaderText>
            <div>대화 상대</div>
            <div>{users.length}</div>
          </S.HeaderText>
        </S.SideBarHeader>
        <S.UserList>
          {users.map((user) => (
            <li key={user.id}>
              <S.UserInfo>
                <S.Avatar src={user.avatar} />
                <div>{user.nickname}</div>
                <div>{user.lang}</div>
              </S.UserInfo>
            </li>
          ))}
        </S.UserList>
      </S.SideBarWrapper>
    </>
  );
};

export default SideBar;
