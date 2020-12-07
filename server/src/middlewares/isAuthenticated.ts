export default (req: any): any => {
  if (!req.user) {
    throw Error('This user is a non-existent user.');
  }
  return;
};
