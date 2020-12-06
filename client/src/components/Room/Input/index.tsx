import React, { useState } from 'react';
import { debounce } from 'lodash';
import { useMutation } from '@apollo/client';
import {
  MutationCreateMessageArgs,
  MutationTranslationArgs,
} from '@generated/types';
import { CREATE_MESSAGE, TRANSLATION } from '@queries/messege.queries';
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
  const [translationMutation] = useMutation<MutationTranslationArgs>(
    TRANSLATION,
    {
      variables: {
        text,
        source: 'ko',
        target: 'en',
      },
    },
  );

  const getTranslatedText = debounce(async () => {
    const checkText = text.replace(/(\s*)/g, '');
    if (checkText.length === 0) return;

    const translatedText = await translationMutation();
  }, 500);

  const onKeyUp = () => {
    getTranslatedText();
  };

  const onChangeText = (e: React.ChangeEvent<HTMLInputElement>) => {
    setText(e.target.value);
  };

  const onKeyPressEnter = async (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      await createMessageMutation();
      setText('');
    }
  };

  return (
    <S.Wrapper>
      <S.InputWrapper>
        <S.InputContainer>
          <S.Input
            placeholder="텍스트를 입력하세요"
            value={text}
            onChange={onChangeText}
            onKeyUp={onKeyUp}
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
