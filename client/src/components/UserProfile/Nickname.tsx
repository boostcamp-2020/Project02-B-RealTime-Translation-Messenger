import React from 'react';
import styled from 'styled-components';
import { useUserDispatch, useUserState } from '@/contexts/UserContext';
import { getText } from '@/constants/localization';

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

interface NicknameProps {
  isNicknameValid: boolean;
  setIsNicknameValid: React.Dispatch<React.SetStateAction<boolean>>;
}

const Nickname: React.FC<NicknameProps> = ({
  isNicknameValid,
  setIsNicknameValid,
}) => {
  const { nickname, lang } = useUserState();
  const dispatch = useUserDispatch();

  const { inputNickName, nicknameError } = getText(lang);
  const minNicknameLength = 1;
  const maxNicknameLength = 12;

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

  return (
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
  );
};

export default Nickname;
