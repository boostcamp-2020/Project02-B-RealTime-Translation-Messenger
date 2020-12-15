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

const UserProfile: React.FC = () => {
  const { avatar, nickname } = useUserState();
  const dispatch = useUserDispatch();
  const { inputNickName, selectLanguage } = useLocalizationState();
  const localDispatch = useLocalizationDispatch();

  const [selectedLangNum, setSelectedLangNum] = useState(0);
  const [selectedLangValue, setSelectedLangValue] = useState('한');

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

  const onClickLanguageRefresh = () => {
    const selectedNum = (selectedLangNum + 1) % 4;

    const selected: any = Object.values(LANGUAGE)[selectedNum];
    setSelectedLangNum(selectedNum);
    setSelectedLangValue(selected.value);

    dispatch({
      type: 'SET_LANG',
      lang: selected.code,
    });

    localDispatch({
      type: 'SET_LOCAL',
      lang: selected.code === 'en' ? 'en' : 'ko',
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
        <S.LanguageButtonWrapper>
          <S.LanguageButton>{selectedLangValue}</S.LanguageButton>
          <S.LanguageRefreshButton onClick={onClickLanguageRefresh}>
            <Refresh size={24} />
          </S.LanguageRefreshButton>
        </S.LanguageButtonWrapper>
      </S.LanguageWrapper>
    </S.ProfileWrapper>
  );
};

export default UserProfile;
