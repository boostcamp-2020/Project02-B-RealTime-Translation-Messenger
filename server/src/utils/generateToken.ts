import jwt from 'jsonwebtoken';

interface User {
  id: number;
  nickname: string;
  avatar: string;
  lang: string;
}

export default (user: User, roomId: number): string => {
  const { id, nickname, avatar, lang } = user;
  return jwt.sign({ id, nickname, avatar, lang, roomId }, process.env.JWT_SECRET_KEY as string);
};
