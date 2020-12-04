module.exports = {
  parser: '@typescript-eslint/parser',
  plugins: ['@typescript-eslint', 'react-hooks'],
  extends: [
    'airbnb',
    'plugin:react/recommended',
    'plugin:jsx-a11y/recommended',
    'plugin:import/errors',
    'plugin:import/warnings',
    'plugin:@typescript-eslint/recommended',
    'plugin:prettier/recommended',
  ],
  rules: {
    'prettier/prettier': ['error'],
    'no-use-before-define': 0,
    'react/jsx-filename-extension': 0,
    'import/extensions': 0,
    'import/no-unresolved': 0,
    'react/prop-types': 0,
  },
  settings: {
    'import/resolver': {
      node: {
        extensions: ['.js', '.jsx', '.ts', '.tsx'],
      },
      alias: {
        map: [
          ['@', './src'],
          ['@components', './src/components'],
          ['@contexts', './src/contexts'],
          ['@constants', './src/constants'],
          ['@generated', './src/generated'],
          ['@queries', './src/queries'],
          ['@routes', './src/routes'],
          ['@styles', './src/styles'],
          ['@utils', './src/utils'],
        ],
      },
    },
  },
};
