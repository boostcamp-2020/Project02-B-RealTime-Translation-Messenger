import { RequestWithUser } from '@interfaces/request';

export default (req: RequestWithUser): void => {
  if (!req.user) {
    throw Error('This user is a non-existent user.');
  }
  return;
};
