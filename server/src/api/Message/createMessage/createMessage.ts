import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

interface Message {
  text: string;
  source: string;
  nickname: string;
  roomId: number;
}

export default {
  Mutation: {
    createMessage: async (_: Message, args: Message, { pubsub }: any): Promise<boolean> => {
      const { text, source, nickname, roomId } = args;
      const newMessage = await prisma.message.create({
        data: {
          text,
          source,
          user: {
            connect: {
              nickname,
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
