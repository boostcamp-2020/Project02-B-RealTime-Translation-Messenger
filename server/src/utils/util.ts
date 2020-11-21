const fillZero = (num: string, width: number): string => {
  return '0'.repeat(width - num.length) + num;
};

const getRandomRoomNumber = (): string => {
  const randomNum = Math.floor(Math.random() * 1000000);
  return fillZero(String(randomNum), 6);
};

export default { getRandomRoomNumber };
