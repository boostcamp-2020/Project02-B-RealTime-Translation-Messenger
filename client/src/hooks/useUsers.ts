import { useState, useEffect } from 'react';
import { NEW_USER, SUBSCRIBE_DELETE_USER } from '@queries/user.queries';
import { useQuery } from '@apollo/client';
import { User } from '@generated/types';
import { ROOM_BY_ID } from '@queries/room.queires';

interface Variables {
  roomId: number;
}

interface QueryReturnType {
  data: any;
  loading: boolean;
}

const useUsers = ({ roomId }: Variables): QueryReturnType => {
  const { data, loading, subscribeToMore } = useQuery(ROOM_BY_ID, {
    variables: {
      id: roomId,
    },
  });

  useEffect(() => {
    const unsubscribe = subscribeToMore({
      document: NEW_USER,
      variables: { roomId },
      updateQuery: (prev, { subscriptionData }) => {
        if (!subscriptionData.data) return prev;
        const { newUser } = subscriptionData.data;
        return {
          ...prev,
          roomById: {
            ...prev.roomById,
            users: [...prev.roomById.users, newUser],
          },
        };
      },
    });
    return () => {
      unsubscribe();
    };
  }, []);

  useEffect(() => {
    const unsubscribe = subscribeToMore({
      document: SUBSCRIBE_DELETE_USER,
      variables: { roomId },
      updateQuery: (prev, { subscriptionData }) => {
        if (!subscriptionData.data) return prev;
        const { deleteUser } = subscriptionData.data;

        const newList = prev.roomById.users.filter((user: User) => {
          if (user.id !== deleteUser.id) return true;
          return false;
        });
        return {
          ...prev,
          roomById: {
            ...prev.roomById,
            users: newList,
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

export default useUsers;
