import React, { FC, useState } from 'react';
import { RouteComponentProps, useLocation } from 'react-router-dom';
import ChatLog from '@components/ChatLog';
import Header from '@components/Room/Header';
import SideBar from '@components/Room/SideBar';
import Input from '@components/Room/Input';
import useMessages from '@hooks/useMessages';
import useUsers from '@hooks/useUsers';
import { User } from '@/generated/types';
import Loader from '@components/Loader';

interface MatchParams {
  id: string;
}

interface LocationState {
  userId: number;
  code: string;
}

const Room: FC<RouteComponentProps<MatchParams>> = ({ match }) => {
  const roomId = +match.params.id;
  const location = useLocation<LocationState>();
  const { userId, code } = location.state;
  const [visible, setVisible] = useState<boolean>(false);
  const [page, setPage] = useState(2);

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
      <Header
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
      <Input />
    </>
  );
};

export default Room;
