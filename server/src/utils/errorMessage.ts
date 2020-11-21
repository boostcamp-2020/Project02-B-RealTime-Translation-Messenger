const ERROR_MSG = {
  create: 'CREATE ERROR',
  read: 'READ ERROR',
  update: 'UPDATE ERROR',
  delete: 'DELETE ERROR',
  invalid: 'INVALID ERROR : the received data is invalid',
  server: 'INTERNAL ERROR : Unexpected error occurred',
  unauthorized: 'AUTH ERROR : The request is not authorized',
  notFound: 'NOT FOUND : The data is not found',
  already: 'CREATE ERROR : The data is already registered',
};

export default ERROR_MSG;
