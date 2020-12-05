import React, { FC, useEffect, useState } from 'react';
import styled from 'styled-components';
import { RouteComponentProps, useLocation } from 'react-router-dom';
import { NEW_MESSAGE, ALL_MESSAGES_BY_ID } from '@/queries/room.queires';
import { useQuery } from '@apollo/client';
import ChatLog from '@components/ChatLog';
import Header from '@components/Room/Header';
import SideBar from '@components/Room/SideBar';
import Input from '@components/Room/Input';

interface MatchParams {
  id: string;
}

const Room: FC<RouteComponentProps<MatchParams>> = ({ match }) => {
  const roomId = +match.params.id;
  const location: any = useLocation();
  const { lang } = location.state;
  const { data, loading, subscribeToMore } = useQuery(ALL_MESSAGES_BY_ID, {
    variables: {
      id: roomId,
    },
  });
  const [visible, setVisible] = useState<boolean>(false);

  useEffect(() => {
    const unsubscribe = subscribeToMore({
      document: NEW_MESSAGE,
      variables: { roomId, lang },
      updateQuery: (prev, { subscriptionData }) => {
        if (!subscriptionData.data) return prev;
        const { newMessage } = subscriptionData.data;
        return {
          allMessagesById: [...prev.allMessagesById, newMessage],
        };
      },
    });
    return () => {
      unsubscribe();
    };
  }, []);
  if (loading) return <div>Loading!</div>;

  return (
    <>
      <Header visible={visible} setVisible={setVisible} />
      <SideBar visible={visible} setVisible={setVisible} />
      <ChatLog messages={data.allMessagesById} />
      <Input />
    </>
  );
};

export default Room;
