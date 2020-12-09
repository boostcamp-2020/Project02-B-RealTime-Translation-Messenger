import { withFilter } from 'graphql-subscriptions';
import req from '@utils/request';

export default {
  Subscription: {
    newMessage: {
      subscribe: withFilter(
        (_: any, __: any, { pubsub }: any) => pubsub.asyncIterator('NEW_MESSAGE'),
        async (payload, variables): Promise<boolean> => {
          if (payload.newMessage.roomId === variables.roomId) {
            const { text, source } = payload.newMessage;
            const target = variables.lang;

            if (source === 'in' || source === 'out') {
              payload.newMessage.text = text;
              return true;
            }
            const translatedText = await req(text, source, target);
            const texts = {
              originText: text,
              translatedText,
            };
            payload.newMessage.text = JSON.stringify(texts);

            return true;
          }
          return false;
        },
      ),
    },
  },
};
