import React, { useState } from 'react';
import { debounce } from 'lodash';
import { useMutation } from '@apollo/client';
import { MutationCreateMessageArgs } from '@generated/types';
import { CREATE_MESSAGE } from '@queries/messege.queries';
import { Microphone } from '@components/Icons';
import S from './style';

const Input: React.FC = () => {
  const [text, setText] = useState('');
  const [createMessageMutation] = useMutation<MutationCreateMessageArgs>(
    CREATE_MESSAGE,
    {
      variables: {
        text,
        source: 'ko',
        userId: 3,
        roomId: 1,
      },
    },
  );

  const getTranslatedText = debounce(async (value: string) => {
    // const result = await request(value, 'ko', 'en');
  }, 1000);

  const onChangeText = (e: React.ChangeEvent<HTMLInputElement>) => {
    setText(e.target.value);
    // getTranslatedText(e.target.value);
  };

  const onKeyPressEnter = async (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      await createMessageMutation();
    }
    setText('');
  };

  return (
    <S.Wrapper>
      <S.InputWrapper>
        <S.InputContainer>
          <S.Input
            placeholder="텍스트를 입력하세요"
            value={text}
            onChange={onChangeText}
            onKeyPress={onKeyPressEnter}
          />
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
