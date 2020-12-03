import React from 'react';
import { Microphone } from '@components/Icons';
import S from './style';

const Input: React.FC = () => {
  return (
    <S.Wrapper>
      <S.InputWrapper>
        <S.InputContainer>
          <S.Input placeholder="텍스트를 입력하세요" type="text" />
          <S.VoiceButton>
            <Microphone size={30} />
          </S.VoiceButton>
        </S.InputContainer>
        <S.Margin />
        <S.Translation>blabla</S.Translation>
      </S.InputWrapper>
    </S.Wrapper>
  );
};

export default Input;
