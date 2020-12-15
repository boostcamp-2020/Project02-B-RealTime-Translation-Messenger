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
  const { avatar, nickname } = useUserState();
  const dispatch = useUserDispatch();
  const {
    inputNickName,
    nicknameError,
    selectLanguage,
  } = useLocalizationState();
  const localDispatch = useLocalizationDispatch();

  const [selectedLangNum, setSelectedLangNum] = useState(0);
  const [selectedLangValue, setSelectedLangValue] = useState('한');

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
      lang: selected.code,
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
