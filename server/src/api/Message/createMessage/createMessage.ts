import { Context } from './../../../interfaces/context';
import { PrismaClient, Message } from '@prisma/client';
import dect from '@utils/dect';
import TRIGGER from '@utils/trigger';

const prisma = new PrismaClient();

export default {
  Mutation: {
    createMessage: async (
      _: Message,
      args: Message,
      { pubsub, isAuthenticated, request }: Context,
    ): Promise<boolean> => {
      isAuthenticated(request);
      const { id: userId, roomId } = request.user;
      const { text } = args;
      const lang = await dect(text);
      const newMessage = await prisma.message.create({
        data: {
          text,
          source: lang,
          user: {
            connect: {
              id: userId,
            },
          },
          room: {
            connect: {
              id: roomId,
            },
          },
        },
        include: {
          user: true,
        },
      });
      pubsub.publish(TRIGGER.NEW_MESSAGE, {
        newMessage,
      });
      return true;
    },
  },
};
