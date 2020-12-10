import { PrismaClient } from '@prisma/client';
import translateText from '@utils/translateText';
import { withFilter } from 'graphql-subscriptions';
import TRIGGER from '@utils/trigger';

const prisma = new PrismaClient();

export default {
  Subscription: {
    newMessage: {
      subscribe: withFilter(
        (_: any, __: any, { pubsub }: any) => pubsub.asyncIterator(TRIGGER.NEW_MESSAGE),
        async (payload, variables): Promise<boolean> => {
          if (payload.newMessage.roomId === variables.roomId) {
            const message = payload.newMessage;
            const { roomId, lang } = variables;
            const users = await prisma.room
              .findOne({
                where: {
                  id: roomId,
                },
              })
              .users();
            payload.newMessage.text = await translateText(message, lang, users);
            return true;
          }
          return false;
        },
      ),
    },
  },
};
