import React, { FC, useState } from 'react';
import { RouteComponentProps, useLocation } from 'react-router-dom';
import ChatLog from '@components/ChatLog';
import Header from '@components/Room/Header';
import SideBar from '@components/Room/SideBar';
import Input from '@components/Room/Input';
import useMessages from '@/hooks/useMessages';
import useUsers from '@/hooks/useUsers';

interface MatchParams {
  id: string;
}

interface LocationState {
  lang: string;
  userId: number;
  code: string;
}

const Room: FC<RouteComponentProps<MatchParams>> = ({ match }) => {
  const roomId = +match.params.id;
  const location = useLocation<LocationState>();
  const { lang, code } = location.state;
  const { data: messagesData, loading: messagesLoading } = useMessages({
    roomId,
    page: 1,
    lang,
  });
  const { data: usersData, loading: usersLoading } = useUsers({ roomId });

  const [visible, setVisible] = useState<boolean>(false);

  if (messagesLoading || usersLoading) return <div>Loading!</div>;

  return (
    <>
      <Header
        visible={visible}
        setVisible={setVisible}
        code={code}
        users={usersData.roomById.users}
      />
      <SideBar
        visible={visible}
        setVisible={setVisible}
        users={usersData.roomById.users}
      />
      <ChatLog messages={messagesData.allMessagesById.messages} />
      <Input />
    </>
  );
};

export default Room;
