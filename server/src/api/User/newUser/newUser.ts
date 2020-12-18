import { User } from '@prisma/client';
import { Context } from '@interfaces/context';
import { withFilter } from 'graphql-subscriptions';
import TRIGGER from '@utils/trigger';

export default {
  Subscription: {
    newUser: {
      subscribe: withFilter(
        (_: User, __: null, { pubsub }: Context) => pubsub.asyncIterator(TRIGGER.NEW_USER),
        async (payload, variables, context): Promise<boolean> => {
          const { roomId } = context.connection.context.user;
          if (payload.newUser.roomId === roomId) return true;
          return false;
        },
      ),
    },
  },
};
