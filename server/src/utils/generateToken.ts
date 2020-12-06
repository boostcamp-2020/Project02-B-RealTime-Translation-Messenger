import jwt from 'jsonwebtoken';

export default (
  id: number,
  nickname: string,
  avatar: string,
  lang: string,
  roomId: number,
): string => {
  return jwt.sign({ id, nickname, avatar, lang, roomId }, process.env.JWT_SECRET_KEY as string);
};
