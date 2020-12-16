import ERROR_MSG from '@utils/errorMessage';
import { RequestWithUser } from '@interfaces/request';

export default (req: RequestWithUser): void => {
  if (!req.user) {
    throw Error(ERROR_MSG.unauthorized);
  }
  return;
};
