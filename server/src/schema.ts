import { makeExecutableSchema } from 'graphql-tools';
import { fileLoader, mergeResolvers, mergeTypes } from 'merge-graphql-schemas';
import path from 'path';

const allTypes = fileLoader(path.join(__dirname, '/api/**/*.graphql'));
const allResolvers = fileLoader(path.join(__dirname, '/api/**/*.ts'));

const schema = makeExecutableSchema({
  typeDefs: mergeTypes(allTypes),
  resolvers: mergeResolvers(allResolvers),
});

export default schema;
