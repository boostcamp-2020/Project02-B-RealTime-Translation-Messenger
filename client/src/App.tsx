import React, { useState } from 'react';
import { BrowserRouter } from 'react-router-dom';
import styled, { ThemeProvider } from 'styled-components';
import { Sun, Moon } from '@components/Icons';
import GlobalStyles from '@styles/GlobalStyles';
import { lightTheme, darkTheme } from '@styles/Theme';
import Routes from '@routes/.';
import { LocalizationContextProvider } from '@contexts/LocalizationContext';
import { UserContextProvider } from '@contexts/UserContext';

const Button = styled.button`
  position: fixed;
  right: 2.5rem;
  bottom: 2rem;
  z-index: 1;
  svg {
    fill: ${(props) => props.theme.text};
  }
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    right: 1rem;
    bottom: 0.5rem;
    svg {
      width: 25px;
      height: 25px;
    }
  }
`;

const App: React.FC = () => {
  const [isLight, setIsLight] = useState(true);

  const toggleTheme = () => {
    setIsLight(!isLight);
  };

  return (
    <ThemeProvider theme={isLight ? lightTheme : darkTheme}>
      <LocalizationContextProvider>
        <UserContextProvider>
          <GlobalStyles />
          <Button onClick={toggleTheme}>
            {isLight ? <Sun size={36} /> : <Moon size={36} />}
          </Button>
          <BrowserRouter>
            <Routes />
          </BrowserRouter>
        </UserContextProvider>
      </LocalizationContextProvider>
    </ThemeProvider>
  );
};

export default App;
