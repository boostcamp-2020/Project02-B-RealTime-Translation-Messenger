import React, { useState } from 'react';
import styled from 'styled-components';

const LanguageWrapper = styled.div`
  text-align: center;
`;

const LanguageButton = styled.input<{ selected: boolean }>`
  width: 50px;
  height: 50px;
  color: ${(props) =>
    props.selected ? props.theme.blackColor : props.theme.whiteColor};
  background-color: ${(props) =>
    props.selected ? props.theme.lightGrayColor : props.theme.darkGrayColor};
  border: ${(props) => props.theme.boxBorder};
  border-radius: ${(props) => props.theme.borderRadius};
  font-size: 1.2rem;

  &:hover {
    color: ${(props) => props.theme.blackColor};
    background-color: ${(props) => props.theme.lightGrayColor};
  }
`;

const Language: React.FC = () => {
  const [lang, setLang] = useState('ko');

  return (
    <LanguageWrapper>
      <LanguageButton
        type="button"
        value="한"
        selected={lang === 'ko'}
        onClick={() => setLang('ko')}
      />
      <LanguageButton
        type="button"
        value="En"
        selected={lang === 'en'}
        onClick={() => setLang('en')}
      />
    </LanguageWrapper>
  );
};

export default Language;
