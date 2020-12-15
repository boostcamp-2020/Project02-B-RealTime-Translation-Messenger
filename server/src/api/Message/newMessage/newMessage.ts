import { PrismaClient, Message } from '@prisma/client';
import translateText from '@utils/translateText';
import { withFilter } from 'graphql-subscriptions';
import TRIGGER from '@utils/trigger';
import { Context } from '@interfaces/context';
import ERROR_MSG from '@utils/errorMessage';

const prisma = new PrismaClient();

export default {
  Subscription: {
    newMessage: {
      subscribe: withFilter(
        (_: Message, __: null, { pubsub }: Context) => pubsub.asyncIterator(TRIGGER.NEW_MESSAGE),
        async (payload, variables, context): Promise<boolean> => {
          const { id, roomId } = context.connection.context.user;
          if (payload.newMessage.roomId === roomId) {
            const message = payload.newMessage;

            if (message.source === 'in' || message.source === 'out') {
              return true;
            }
            const user = await prisma.user.findOne({ where: { id } });
            if (!user) throw new Error(ERROR_MSG.read);
            const users = await prisma.room
              .findOne({
                where: {
                  id: roomId,
                },
              })
              .users();
            payload.newMessage.text = await translateText(message, { ...user, roomId }, users);
            return true;
          }
          return false;
        },
      ),
    },
  },
};
