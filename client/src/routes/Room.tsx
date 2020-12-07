import React, { FC, useEffect, useState } from 'react';
import { RouteComponentProps, useLocation } from 'react-router-dom';
import { NEW_MESSAGE, ALL_MESSAGES_BY_ID } from '@queries/messege.queries';
import { useQuery } from '@apollo/client';
import ChatLog from '@components/ChatLog';
import Header from '@components/Room/Header';
import SideBar from '@components/Room/SideBar';
import Input from '@components/Room/Input';
import useMessages from '@/hooks/useMessages';

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
  const { data, loading } = useMessages({
    roomId,
    page: 1,
    lang,
  });

  const [visible, setVisible] = useState<boolean>(false);

  if (loading) return <div>Loading!</div>;

  return (
    <>
      <Header visible={visible} setVisible={setVisible} code={code} />
      <SideBar visible={visible} setVisible={setVisible} roomId={roomId} />
      <ChatLog messages={data.allMessagesById.messages} />
      <Input />
    </>
  );
};

export default Room;
