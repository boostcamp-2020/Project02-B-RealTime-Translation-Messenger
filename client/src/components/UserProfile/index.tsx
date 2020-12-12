import React from 'react';
import LANGUAGE from '@constants/language';
import util from '@utils/utils';
import {
  useLocalizationState,
  useLocalizationDispatch,
} from '@contexts/LocalizationContext';
import { useUserDispatch, useUserState } from '@contexts/UserContext';
import { Refresh } from '@components/Icons';
import S from './style';

const UserProfile: React.FC = () => {
  const { avatar, nickname, lang } = useUserState();
  const dispatch = useUserDispatch();
  const { inputNickName, selectLanguage } = useLocalizationState();
  const localDispatch = useLocalizationDispatch();

  const onClickRefresh = () => {
    const randomAvatar: string = util.getRandomAvatar();
    dispatch({
      type: 'SET_AVATAR',
      avatar: randomAvatar,
    });
  };

  const onChangeNickname = (e: React.ChangeEvent<HTMLInputElement>) => {
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
      <S.NicknameInput
        placeholder={inputNickName}
        value={nickname}
        onChange={onChangeNickname}
      />
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
