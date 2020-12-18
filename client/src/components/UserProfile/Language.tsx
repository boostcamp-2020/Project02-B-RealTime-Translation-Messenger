import React, { useState } from 'react';
import styled from 'styled-components';
import { useUserDispatch, useUserState } from '@contexts/UserContext';
import { getText } from '@/constants/localization';
import LANGUAGE from '@constants/language';
import { Refresh } from '../Common/Icons';

const LanguageTitle = styled.div`
  margin: 0 0 1rem 0;
  color: ${({ theme }) => theme.darkGrayColor};
  font-size: 18px;
`;
const LanguageWrapper = styled.div`
  margin: 1rem 0;
  text-align: center;
`;
const LanguageButtonWrapper = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
`;
const LanguageButton = styled.div`
  display: flex;
  align-items: center;
  justify-content: center;
  width: 50px;
  height: 50px;
  margin: 0 0.3rem;
  background-color: ${({ theme }) => theme.lightGrayColor};
  border-radius: ${({ theme }) => theme.borderRadius};
  font-size: 1.2rem;
`;
const LanguageRefreshButton = styled.button`
  display: flex;
  justify-content: center;
  align-items: center;
  width: 50px;
  height: 50px;
  margin: 0 0.3rem;
  background-color: ${({ theme }) => theme.darkGrayColor};
  border-radius: ${({ theme }) => theme.borderRadius};
  &:hover {
    filter: brightness(85%);
  }
  svg {
    fill: ${({ theme }) => theme.whiteColor};
  }
`;

const Language: React.FC = () => {
  const { lang } = useUserState();
  const dispatch = useUserDispatch();

  const { langCode, selectLanguage } = getText(lang);

  const onClickLanguageRefresh = () => {
    dispatch({
      type: 'SET_LANG',
      lang: getNextLang(),
    });
  };

  const getNextLang = () => {
    const langIndex = LANGUAGE.indexOf(lang);
    const langLength = LANGUAGE.length;
    const newLang = LANGUAGE[(langIndex + 1) % langLength];
    return newLang;
  };

  return (
    <LanguageWrapper>
      <LanguageTitle>{selectLanguage}</LanguageTitle>
      <LanguageButtonWrapper>
        <LanguageButton>{langCode}</LanguageButton>
        <LanguageRefreshButton onClick={onClickLanguageRefresh}>
          <Refresh size={24} />
        </LanguageRefreshButton>
      </LanguageButtonWrapper>
    </LanguageWrapper>
  );
};

export default Language;
