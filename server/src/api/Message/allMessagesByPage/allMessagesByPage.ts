import { PrismaClient } from '@prisma/client';
import req from '@utils/request';

const prisma = new PrismaClient();

interface Pagination {
  page: number;
}

interface Message {
  id: number;
  text: string;
  source: string;
}

export default {
  Query: {
    allMessagesByPage: async (_: any, args: Pagination, { request, isAuthenticated }: any) => {
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

      const promises = Messages.map(async (message: Message) => {
        const { text, source } = message;
        const { lang: target } = request.user;

        if (source === 'in' || source === 'out') {
          message.text = text;
        } else {
          const translatedText = await req(text, source, target);
          const texts = {
            originText: text,
            translatedText,
          };
          message.text = JSON.stringify(texts);
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
