import React, { FC, useState } from 'react';
import { useLocation } from 'react-router-dom';
import ChatLog from '@components/ChatLog';
import RoomHeader from '@components/RoomHeader';
import SideBar from '@components/SideBar';
import RoomInput from '@components/RoomInput';
import useMessages from '@hooks/useMessages';
import useUsers from '@hooks/useUsers';
import { User } from '@generated/types';
import Loader from '@components/Common/Loader';
import { getText } from '@constants/localization';

interface LocationState {
  userId: number;
  roomId: number;
  code: string;
  lang: string;
}

const Room: FC = () => {
  const location = useLocation<LocationState>();
  const { userId, roomId, code, lang } = location.state;
  const [visible, setVisible] = useState<boolean>(false);
  const [page, setPage] = useState(2);
  const { tokenErrorText } = getText(lang);

  try {
    const { data: usersData, loading: usersLoading } = useUsers({
      roomId,
    });
    const {
      data: messagesData,
      loading: messagesLoading,
      onLoadMore,
    } = useMessages({
      roomId,
      page: 1,
      id: userId,
    });

    if (messagesLoading || usersLoading) return <Loader />;

    const validUser = usersData.roomById.users.filter(
      (user: User) => !user.isDeleted,
    );
    return (
      <>
        <RoomHeader
          visible={visible}
          setVisible={setVisible}
          code={code}
          users={validUser}
        />
        <SideBar visible={visible} setVisible={setVisible} users={validUser} />
        <ChatLog
          messages={messagesData.allMessagesByPage.messages}
          page={page}
          setPage={setPage}
          onLoadMore={onLoadMore}
        />
        <RoomInput />
      </>
    );
  } catch (e) {
    alert(tokenErrorText);
    window.location.href = '/';
    return <div />;
  }
};

export default Room;
