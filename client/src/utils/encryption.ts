import { createHash } from 'crypto';

const encrypt = (targetString: string): string => {
  return createHash('sha512').update(targetString).digest('base64');
};

export default encrypt;
