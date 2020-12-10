import { withFilter } from 'graphql-subscriptions';
import TRIGGER from '@utils/trigger';

export default {
  Subscription: {
    newUser: {
      subscribe: withFilter(
        (_: any, __: any, { pubsub }: any) => pubsub.asyncIterator(TRIGGER.NEW_USER),
        async (payload, variables): Promise<boolean> => {
          if (payload.newUser.rooms[0].id === variables.roomId) return true;
          return false;
        },
      ),
    },
  },
};
