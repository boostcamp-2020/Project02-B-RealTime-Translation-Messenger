import { PrismaClient, User } from '@prisma/client';
import { getRandomNumber, randomImage } from '@utils/util';
import generateToken from '@utils/generateToken';

const prisma = new PrismaClient();

interface CreateRoomResponse {
  userId: number;
  roomId: number;
  code: string;
  token: string;
}

export default {
  Mutation: {
    createRoom: async (_: CreateRoomResponse, args: User): Promise<CreateRoomResponse> => {
      const { nickname, avatar, lang } = args;
      const newUser = await prisma.user.create({
        data: {
          nickname,
          lang,
          avatar,
        },
      });
      const randomCode = getRandomNumber(6);
      const newRoom = await prisma.room.create({
        data: {
          users: {
            connect: {
              id: newUser.id,
            },
          },
          avatar: randomImage(),
          code: randomCode,
        },
      });
      const jwtToken = generateToken(newUser, newRoom.id);

      return { userId: newUser.id, roomId: newRoom.id, code: randomCode, token: jwtToken };
    },
  },
};
