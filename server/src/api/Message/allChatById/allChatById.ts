import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    allChatById: (_: any, { id }: { id: number }) =>
      prisma.message.findMany({
        where: {
          room: { id },
        },
        include: {
          user: true,
        },
      }),
  },
};
