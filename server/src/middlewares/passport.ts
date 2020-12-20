import { PrismaClient } from '@prisma/client';
import { Strategy as JwtStrategy, ExtractJwt } from 'passport-jwt';
import passport from 'passport';
import { Request, Response, NextFunction } from 'express';

const prisma = new PrismaClient();

const jwtOptions = {
  jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
  secretOrKey: process.env.JWT_SECRET_KEY,
};

const verifyJwt = async (payload: any, done: any) => {
  try {
    const isExist: any = await prisma.user.findOne({
      where: {
        id: payload.id,
      },
    });

    const user = {
      id: payload.id,
      nickname: payload.nickname,
      avatar: payload.avatar,
      lang: payload.lang,
      roomId: payload.roomId,
    };

    if (isExist) {
      return done(null, user);
    } else {
      return done(null, false);
    }
  } catch (err) {
    return done(err, false);
  }
};

export const authenticateJwt = (req: Request, res: Response, next: NextFunction): void => {
  passport.authenticate('jwt', { session: false }, (error, user) => {
    if (user) {
      req.user = user;
    }
    next();
  })(req, res, next);
};

passport.use(new JwtStrategy(jwtOptions, verifyJwt));
