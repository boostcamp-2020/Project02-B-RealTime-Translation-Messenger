import generateToken from '@utils/generateToken';
import { PrismaClient } from '@prisma/client';
import ERROR_MSG from '@utils/errorMessage';

const prisma = new PrismaClient();

interface EnterInfo {
  nickname: string;
  avatar: string;
  lang: string;
  code: string;
  token: string;
}

interface EnterRoomResponse {
  userId: number;
  roomId: number;
  token: string;
}

export default {
  Mutation: {
    enterRoom: async (
      _: EnterRoomResponse,
      { nickname, avatar, lang, code }: EnterInfo,
    ): Promise<EnterRoomResponse> => {
      if (!nickname || !avatar || !lang || !code) throw new Error(ERROR_MSG.invalid);
      try {
        const newUser = await prisma.user.create({
          data: {
            nickname,
            lang,
            avatar,
            rooms: {
              connect: { code },
            },
          },
          include: { rooms: true },
        });
        const jwtToken = generateToken(newUser, newUser.rooms[0].id);
        return { userId: newUser.id, roomId: newUser.rooms[0].id, token: jwtToken };
      } catch (err) {
        throw new Error(ERROR_MSG.create);
      }
    },
  },
};
