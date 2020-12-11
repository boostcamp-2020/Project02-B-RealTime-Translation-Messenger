import { withFilter } from 'graphql-subscriptions';
import TRIGGER from '@utils/trigger';

export default {
  Subscription: {
    newUser: {
      subscribe: withFilter(
        (_: any, __: any, { pubsub }: any) => pubsub.asyncIterator(TRIGGER.NEW_USER),
        async (payload, variables, context): Promise<boolean> => {
          const { roomId } = context.connection.context.user;
          if (payload.newUser.roomId === roomId) return true;
          return false;
        },
      ),
    },
  },
};
