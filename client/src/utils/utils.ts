import { avatar } from '../constants/avatar';

const getRandomAvatar = (): string => {
  const randomNum = Math.floor(Math.random() * avatar.length);
  return avatar[randomNum];
};

export default { getRandomAvatar };
