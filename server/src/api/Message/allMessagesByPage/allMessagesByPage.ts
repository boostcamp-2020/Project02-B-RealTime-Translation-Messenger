import { PrismaClient } from '@prisma/client';
import translateText from '@utils/translateText';

const prisma = new PrismaClient();

interface Pagination {
  page: number;
}

interface User {
  id: number;
  avatar: string;
  nickname: string;
  lang: string;
}

interface Message {
  id: number;
  text: string;
  source: string;
  user: User;
}

export default {
  Query: {
    allMessagesByPage: async (
      _: any,
      args: Pagination,
      { request, isAuthenticated }: any,
    ): Promise<any> => {
      isAuthenticated(request);
      const { page } = args;
      const { roomId } = request.user;
      const maxId = await prisma.$queryRaw`SELECT MAX(id) from Message WHERE roomId = ${roomId}`;
      const lastId = maxId[0]['MAX(id)'];
      if (!lastId) return { messages: [], nextPage: null };
      const Messages: any = await prisma.message.findMany({
        where: {
          room: { id: roomId },
        },
        take: -10,
        skip: 10 * (page - 1),
        cursor: {
          id: lastId,
        },
        include: {
          user: true,
        },
      });

      const users = await prisma.room
        .findOne({
          where: {
            id: roomId,
          },
        })
        .users();

      const promises = Messages.map(async (message: Message) => {
        const { text, source } = message;
        const { lang } = request.user;
        if (source !== 'in' && source !== 'out') {  
          message.text = await translateText(message, lang, users);
        }
      });

      await Promise.all(promises);

      if (Messages.length === 10) {
        return {
          messages: Messages,
          nextPage: page + 1,
        };
      }
      return {
        messages: Messages,
        nextPage: null,
      };
    },
  },
};
