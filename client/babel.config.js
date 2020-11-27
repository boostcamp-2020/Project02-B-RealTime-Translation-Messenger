module.exports = {
  presets: ['@babel/preset-react', '@babel/preset-env', '@babel/preset-typescript'],
  "env": {
    "development": {
      "plugins": ["babel-plugin-styled-components"]
    }
  }
};
