import React from 'react';
import { User } from '@contexts/UserContext';
import { Hamburger } from '@components/Icons';
import { useQuery } from '@apollo/client';
import { ROOM_BY_ID } from '@/queries/room.queires';
import S from './style';

interface Props {
  visible: boolean;
  setVisible: React.Dispatch<React.SetStateAction<boolean>>;
}

const SideBar: React.FC<Props> = ({ visible, setVisible }) => {
  if (!visible) return null;

  const roomId = 1; // HACK: mock data

  const { loading, error, data } = useQuery(ROOM_BY_ID, {
    variables: { id: roomId },
  });
  if (loading) return null;

  const { users }: { users: User[] } = data.roomById;

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
            // eslint-disable-next-line react/jsx-key
            <li>
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
