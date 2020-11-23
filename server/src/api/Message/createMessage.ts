import { PrismaClient } from '@prisma/client';
import errorMessage from '@utils/errorMessage';

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
      try {
        const message = await prisma.message.create({
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
        if (message) return true;
        return false;
      } catch (error) {
        throw new Error(errorMessage.server);
      }
    },
  },
};
