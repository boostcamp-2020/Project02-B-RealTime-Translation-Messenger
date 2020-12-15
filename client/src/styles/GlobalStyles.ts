import { createGlobalStyle } from 'styled-components';
import reset from 'styled-reset';

export default createGlobalStyle`
  ${reset};
  @import url('https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600;700&display=swap');
  * {
    box-sizing: border-box;
  }
  body {
    color: ${(props) => props.theme.blackColor};
    background-color: ${(props) => props.theme.bgColor};
    font-size: 14px;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
  }
  a {
    color: ${(props) => props.theme.blueColor};
    text-decoration: none;
  }
  input {
    padding: 0;
    background: inherit;
    border: 0;
    outline: none;
  }
  input[type="button"] {
    &:hover {
      cursor: pointer;
    }
  }
  button {
    padding: 0;
    background: none;
    border: 0;
    outline: none;
    &:hover {
      cursor: pointer;
      outline: none;
    }
  }

  *::-webkit-scrollbar {
    width: 10px;
    height: 10px;
  }

  *::-webkit-scrollbar-thumb {
    background-color: ${(props) => props.theme.blueColor};
    background-clip: padding-box;
    border: 2px solid transparent;
    border-radius: 16px;
  }
`;
