import React from 'react';
import { Hamburger } from '@components/Icons';
import { User } from '@/generated/types';
import S from './style';

interface Props {
  visible: boolean;
  setVisible: React.Dispatch<React.SetStateAction<boolean>>;
  users: User[];
}

const SideBar: React.FC<Props> = ({ visible, setVisible, users }) => {
  if (!visible) return null;

  return (
    <>
      <S.SideBarWrapper>
        <S.SideBarHeader>
          <S.HamburgerButton onClick={() => setVisible(!visible)}>
            <Hamburger size={24} />
          </S.HamburgerButton>
          <div>대화 상대</div>
          {users.length}
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
