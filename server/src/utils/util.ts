const fillZero = (num: string, width: number): string => {
  return new Array(width - (num.length ? num.length - 1 : 0)).join('0') + num;
};

const getRandomRoomNumber = (): string => {
  const randomNum = Math.floor(Math.random() * 1000000);
  return fillZero(String(randomNum), 6);
};

export default { getRandomRoomNumber };
