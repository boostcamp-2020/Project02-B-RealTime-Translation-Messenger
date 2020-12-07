import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

interface Args {
  time: string;
}

export default {
  Query: {
    allMessagesByTime: async (_: any, args: Args, { request, isAuthenticated }: any) => {
      isAuthenticated(request);
      const { time } = args;
      const { roomId } = request.user;
      return prisma.message.findMany({
        where: {
          AND: [
            {
              room: {
                id: roomId,
              },
            },
            {
              createdAt: {
                gt: new Date(+time),
              },
            },
          ],
        },
        include: {
          user: true,
        },
      });
    },
  },
};
