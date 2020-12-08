import { useEffect } from 'react';
import { ALL_MESSAGES_BY_ID, NEW_MESSAGE } from '@/queries/messege.queries';
import { useQuery } from '@apollo/client';

interface VariablesType {
  roomId: number;
  page: number;
  lang: string;
}

interface QueryReturnType {
  data: any;
  loading: boolean;
  onLoadMore: any;
}

const useMessages = ({
  roomId,
  page,
  lang,
}: VariablesType): QueryReturnType => {
  const { data, loading, subscribeToMore, fetchMore } = useQuery(
    ALL_MESSAGES_BY_ID,
    {
      variables: {
        id: roomId,
        page,
      },
    },
  );

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

  const onLoadMore = (variables: { roomId: number; page: number }) => {
    fetchMore({
      variables,
      updateQuery: (prev: any, { fetchMoreResult }) => {
        if (!fetchMoreResult) return prev;
        return {
          ...prev,
          allMessagesById: {
            ...prev.allMessagesById,
            messages: [
              ...fetchMoreResult.allMessagesById.messages,
              ...prev.allMessagesById.messages,
            ],
            nextPage: fetchMoreResult.allMessagesById.nextPage,
          },
        };
      },
    });
  };

  return { data, loading, onLoadMore };
};

export default useMessages;
