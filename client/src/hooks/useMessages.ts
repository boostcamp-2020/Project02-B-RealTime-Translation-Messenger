import { useEffect } from 'react';
import { ALL_MESSAGES_BY_PAGE, NEW_MESSAGE } from '@/queries/messege.queries';
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
    ALL_MESSAGES_BY_PAGE,
    {
      variables: {
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
          allMessagesByPage: {
            ...prev.allMessagesByPage,
            messages: [...prev.allMessagesByPage.messages, newMessage],
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
          allMessagesByPage: {
            ...prev.allMessagesByPage,
            messages: [
              ...fetchMoreResult.allMessagesByPage.messages,
              ...prev.allMessagesByPage.messages,
            ],
            nextPage: fetchMoreResult.allMessagesByPage.nextPage,
          },
        };
      },
    });
  };

  return { data, loading, onLoadMore };
};

export default useMessages;
