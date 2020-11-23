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
    createMessage: async (_: Message, args: Message): Promise<boolean> => {
      const { text, source, nickname, roomId } = args;
      await prisma.message.create({
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
      });
      return true;
    },
  },
};
