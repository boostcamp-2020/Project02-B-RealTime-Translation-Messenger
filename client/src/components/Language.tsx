import React, { useState } from 'react';
import styled from 'styled-components';
import LANGUAGE from '../constants/language';

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
  const [lang, setLang] = useState(LANGUAGE.KO);

  return (
    <LanguageWrapper>
      <LanguageButton
        type="button"
        value="한"
        selected={lang === LANGUAGE.KO}
        onClick={() => setLang(LANGUAGE.KO)}
      />
      <LanguageButton
        type="button"
        value="En"
        selected={lang === LANGUAGE.EN}
        onClick={() => setLang(LANGUAGE.EN)}
      />
    </LanguageWrapper>
  );
};

export default Language;
