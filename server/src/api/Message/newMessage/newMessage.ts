import { withFilter } from 'graphql-subscriptions';
import req from '@utils/request';
import TRIGGER from '@utils/trigger';

export default {
  Subscription: {
    newMessage: {
      subscribe: withFilter(
        (_: any, __: any, { pubsub }: any) => pubsub.asyncIterator(TRIGGER.NEW_MESSAGE),
        async (payload, variables): Promise<boolean> => {
          if (payload.newMessage.roomId === variables.roomId) {
            const { text, source } = payload.newMessage;
            const target = variables.lang;
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
