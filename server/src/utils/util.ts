const fillZero = (num: string, width: number): string => {
  return '0'.repeat(width - num.length) + num;
};

const getRandomNumber = (width: number): string => {
  const randomNum = Math.floor(Math.random() * 10 ** width);
  return fillZero(String(randomNum), width);
};

const randomImage = (): string => 'https://picsum.photos/200';

export { getRandomNumber, randomImage };
