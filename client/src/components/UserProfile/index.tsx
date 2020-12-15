import React, { useState } from 'react';
import LANGUAGE from '@constants/language';
import util from '@utils/utils';
import {
  useLocalizationState,
  useLocalizationDispatch,
} from '@contexts/LocalizationContext';
import { useUserDispatch, useUserState } from '@contexts/UserContext';
import { Refresh } from '@components/Icons';
import S from './style';

interface Props {
  isNicknameValid: boolean;
  setIsNicknameValid: React.Dispatch<React.SetStateAction<boolean>>;
}

const UserProfile: React.FC<Props> = ({
  isNicknameValid,
  setIsNicknameValid,
}) => {
  const { avatar, nickname, lang } = useUserState();
  const dispatch = useUserDispatch();
  const {
    inputNickName,
    nicknameError,
    selectLanguage,
  } = useLocalizationState();
  const localDispatch = useLocalizationDispatch();

  const minNicknameLength = 1;
  const maxNicknameLength = 12;

  const onClickRefresh = () => {
    const randomAvatar: string = util.getRandomAvatar();
    dispatch({
      type: 'SET_AVATAR',
      avatar: randomAvatar,
    });
  };

  const onChangeNickname = (e: React.ChangeEvent<HTMLInputElement>) => {
    const { value: nicknameValue } = e.target;
    const nicknameValueLength = nicknameValue.length;
    if (
      nicknameValueLength < minNicknameLength ||
      nicknameValueLength > maxNicknameLength
    ) {
      setIsNicknameValid(false);
      if (nicknameValueLength > 10) return;
    } else setIsNicknameValid(true);
    dispatch({
      type: 'SET_NICKNAME',
      nickname: e.target.value,
    });
  };

  const onClickLang = (language: string) => {
    dispatch({
      type: 'SET_LANG',
      lang: language,
    });
    localDispatch({
      type: 'SET_LOCAL',
      lang: language as 'ko' | 'en',
    });
  };

  return (
    <S.ProfileWrapper>
      <S.AvatarWrapper>
        <S.Avatar src={avatar} />
        <S.RefreshButton onClick={onClickRefresh}>
          <Refresh size={30} />
        </S.RefreshButton>
      </S.AvatarWrapper>
      <S.NicknameWrapper>
        <S.NicknameInput
          placeholder={inputNickName}
          value={nickname}
          onChange={onChangeNickname}
        />
        <S.NicknameValidator>
          <span>{isNicknameValid ? '' : nicknameError}</span>
          <span>
            {/* eslint-disable-next-line react/jsx-one-expression-per-line */}
            {nickname.length}/{maxNicknameLength}
          </span>
        </S.NicknameValidator>
      </S.NicknameWrapper>
      <S.LanguageWrapper>
        <S.LanguageTitle>{selectLanguage}</S.LanguageTitle>
        <S.LanguageButton
          type="button"
          value="한"
          selected={lang === LANGUAGE.KO}
          onClick={() => onClickLang(LANGUAGE.KO)}
        />
        <S.LanguageButton
          type="button"
          value="En"
          selected={lang === LANGUAGE.EN}
          onClick={() => onClickLang(LANGUAGE.EN)}
        />
      </S.LanguageWrapper>
    </S.ProfileWrapper>
  );
};

export default UserProfile;
