import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

interface Pagination {
  page: number;
}

export default {
  Query: {
    allMessagesById: async (_: any, args: Pagination, { request, isAuthenticated }: any) => {
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
