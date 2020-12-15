import { PubSub } from 'graphql-yoga';
import { RequestWithUser } from './request';

export interface Context {
  request: RequestWithUser;
  isAuthenticated: (req: RequestWithUser) => void;
  pubsub: PubSub;
}
