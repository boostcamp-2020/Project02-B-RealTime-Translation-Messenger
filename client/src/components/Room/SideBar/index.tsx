import React from 'react';
import { useLocation } from 'react-router-dom';
import { User } from '@generated/types';
import { getText } from '@constants/localization';
import S from './style';

interface Props {
  visible: boolean;
  setVisible: React.Dispatch<React.SetStateAction<boolean>>;
  users: User[];
}

interface LocationState {
  lang: string;
}

const SideBar: React.FC<Props> = ({ visible, users }) => {
  const location = useLocation<LocationState>();
  const { lang } = location.state;
  const { userList } = getText(lang);
  return (
    <S.SideBarWrapper visible={visible}>
      <S.SideBarHeader>
        <S.HeaderText>
          <div>{userList}</div>
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
  );
};

export default SideBar;
