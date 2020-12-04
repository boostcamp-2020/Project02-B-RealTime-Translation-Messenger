import React, { FC, useEffect } from 'react';
import { RouteComponentProps, useLocation } from 'react-router-dom';
import { NEW_MESSAGE, ALL_MESSAGES_BY_ID } from '@/queries/room.queires';
import { useQuery } from '@apollo/client';
import ChatLog from '@components/ChatLog';

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
    <div>
      <div>New massages</div>
      <ChatLog messages={data.allMessagesById} />
    </div>
  );
};

export default Room;
