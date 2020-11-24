export default {
  Subscription: {
    newMessage: {
      subscribe: (_: any, __: any, { pubsub }: any): any => pubsub.asyncIterator('NEW_MESSAGE'),
    },
  },
};
