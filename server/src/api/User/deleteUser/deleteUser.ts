import { PrismaClient } from '@prisma/client';
import errorMessage from '@utils/errorMessage';

const prisma = new PrismaClient();

interface User {
  id: number;
}

export default {
  Mutation: {
    deleteUser: async (_: any, args: User): Promise<boolean> => {
      const { id: userId } = args;
      try {
        /**
         * 1. 유저 삭제 (삭제할때 해당 유저가 속한 방번호 조회)
         * 2. 유저가 속했던 방에 남은 유저가 몇명 있는지 조회해서
         * 3. 해당 방에 유저가 0명 있으면 방도 같이 지우기
         */
        const deleteUserResult = await prisma.user.delete({
          where: { id: userId },
          include: { rooms: true },
        });

        const roomId = deleteUserResult.rooms[0].id;

        const afterRoom = await prisma.room.findOne({
          where: { id: roomId },
          include: { users: true },
        });

        if (afterRoom?.users.length === 0) {
          await prisma.room.delete({
            where: { id: roomId },
          });
        }

        return true;
      } catch (error) {
        throw new Error(errorMessage.delete);
      }
    },
  },
};
