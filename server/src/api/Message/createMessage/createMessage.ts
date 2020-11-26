import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

interface Message {
  text: string;
  source: string;
  userId: number;
  roomId: number;
}

export default {
  Mutation: {
    createMessage: async (_: Message, args: Message, { pubsub }: any): Promise<boolean> => {
      const { text, source, userId, roomId } = args;
      const newMessage = await prisma.message.create({
        data: {
          text,
          source,
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
