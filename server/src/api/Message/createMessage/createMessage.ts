import { PrismaClient } from '@prisma/client';
import dect from '@utils/dect';

const prisma = new PrismaClient();

interface Message {
  text: string;
  source: string;
  userId: number;
  roomId: number;
}

export default {
  Mutation: {
    createMessage: async (
      _: Message,
      args: Message,
      { pubsub, isAuthenticated, request }: any,
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
      pubsub.publish('NEW_MESSAGE', {
        newMessage,
      });
      return true;
    },
  },
};
