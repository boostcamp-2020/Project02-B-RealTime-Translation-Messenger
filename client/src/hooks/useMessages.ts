import { useEffect } from 'react';
import { ALL_MESSAGES_BY_ID, NEW_MESSAGE } from '@/queries/messege.queries';
import { useQuery } from '@apollo/client';

interface Variables {
  roomId: number;
  page: number;
  lang: string;
}

interface QueryReturnType {
  data: any;
  loading: boolean;
}

const useMessages = ({ roomId, page, lang }: Variables): QueryReturnType => {
  const { data, loading, subscribeToMore } = useQuery(ALL_MESSAGES_BY_ID, {
    variables: {
      id: roomId,
      page,
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
          ...prev,
          allMessagesById: {
            ...prev.allMessagesById,
            messages: [...prev.allMessagesById.messages, newMessage],
          },
        };
      },
    });
    return () => {
      unsubscribe();
    };
  }, []);

  return { data, loading };
};

export default useMessages;
