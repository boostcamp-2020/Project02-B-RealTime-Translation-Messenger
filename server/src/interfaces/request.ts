import { User } from '@prisma/client';
import { Request } from 'express';

export interface UserToken extends User {
  roomId: number;
}

export interface RequestWithUser extends Request {
  user: UserToken;
}
