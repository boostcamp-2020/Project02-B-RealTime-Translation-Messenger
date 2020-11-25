import { withFilter } from 'graphql-subscriptions';

export default {
  Subscription: {
    newMessage: {
      subscribe: withFilter(
        (_: any, __: any, { pubsub }: any) => pubsub.asyncIterator('NEW_MESSAGE'),
        (payload, variables) => {
          return payload.newMessage.roomId === variables.roomId;
        },
      ),
    },
  },
};
