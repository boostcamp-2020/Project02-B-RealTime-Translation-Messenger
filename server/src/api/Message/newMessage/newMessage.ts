import { PrismaClient } from '@prisma/client';
import translateText from '@utils/translateText';
import { withFilter } from 'graphql-subscriptions';
import TRIGGER from '@utils/trigger';

const prisma = new PrismaClient();

interface User {
  id: number;
  avatar: string;
  nickname: string;
  lang: string;
}

export default {
  Subscription: {
    newMessage: {
      subscribe: withFilter(
        (_: any, __: any, { pubsub }: any) => pubsub.asyncIterator(TRIGGER.NEW_MESSAGE),
        async (payload, variables): Promise<boolean> => {
          if (payload.newMessage.roomId === variables.roomId) {
            const message = payload.newMessage;
            const { roomId, id } = variables;

            if (message.source === 'in' || message.source === 'out') {
              return true;
            }
            const user = await prisma.user.findOne({ where: { id } });
            const users = await prisma.room
              .findOne({
                where: {
                  id: roomId,
                },
              })
              .users();
            payload.newMessage.text = await translateText(message, user as User, users);
            return true;
          }
          return false;
        },
      ),
    },
  },
};
