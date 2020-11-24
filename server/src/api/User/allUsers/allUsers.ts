import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export default {
  Query: {
    allUsers: () =>
      prisma.user.findMany({
        include: {
          rooms: true,
          messages: true,
        },
      }),
  },
};
