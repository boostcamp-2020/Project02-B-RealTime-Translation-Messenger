import React, { useState } from 'react';
import LANGUAGE from '@constants/language';
import util from '@utils/utils';
import {
  useLocalizationState,
  useLocalizationDispatch,
} from '@contexts/LocalizationContext';
import { useUserDispatch, useUserState } from '@contexts/UserContext';
import { Refresh } from '@components/Common/Icons';
import styled from 'styled-components';

const ProfileWrapper = styled.div`
  display: flex;
  flex-direction: column;
  align-items: center;
`;
const AvatarWrapper = styled.div`
  position: relative;
  width: 14.5rem;
  height: 14.5rem;
  background: ${({ theme }) => theme.whiteColor};
  border: ${({ theme }) => theme.boxBorder};
  border-radius: 50%;
`;
const Avatar = styled.img`
  width: inherit;
  height: inherit;
  background: none;
`;
const RefreshButton = styled.button`
  position: absolute;
  display: flex;
  align-items: center;
  justify-content: center;
  bottom: 0.8rem;
  right: 0.8rem;
  padding: 0.5rem;
  background: ${({ theme }) => theme.grayColor};
  border-radius: 50%;
  svg {
    fill: ${({ theme }) => theme.whiteColor};
  }
`;
const NicknameWrapper = styled.div`
  width: 80%;
  margin-top: 0.5rem;
  margin-bottom: 0.2rem;
`;
const NicknameInput = styled.input`
  width: 100%;
  margin: 0 auto;
  padding: 0.5rem;
  color: ${({ theme }) => theme.text};
  border-bottom: ${({ theme }) => theme.boxBorder};
  font-size: 18px;
  text-align: center;
`;
const NicknameValidator = styled.div`
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  margin-top: 0.3rem;

  span {
    &:first-child {
      color: red;
    }
    color: ${(props) => props.theme.text};
  }
`;
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
    <ProfileWrapper>
      <AvatarWrapper>
        <Avatar src={avatar} />
        <RefreshButton onClick={onClickRefresh}>
          <Refresh size={30} />
        </RefreshButton>
      </AvatarWrapper>
      <NicknameWrapper>
        <NicknameInput
          placeholder={inputNickName}
          value={nickname}
          onChange={onChangeNickname}
        />
        <NicknameValidator>
          <span>{isNicknameValid ? '' : nicknameError}</span>
          <span>
            {/* eslint-disable-next-line react/jsx-one-expression-per-line */}
            {nickname.length}/{maxNicknameLength}
          </span>
        </NicknameValidator>
      </NicknameWrapper>
      <LanguageWrapper>
        <LanguageTitle>{selectLanguage}</LanguageTitle>
        <LanguageButtonWrapper>
          <LanguageButton>{selectedLangValue}</LanguageButton>
          <LanguageRefreshButton onClick={onClickLanguageRefresh}>
            <Refresh size={24} />
          </LanguageRefreshButton>
        </LanguageButtonWrapper>
      </LanguageWrapper>
    </ProfileWrapper>
  );
};

export default UserProfile;
