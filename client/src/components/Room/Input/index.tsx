import React, { useState } from 'react';
import { debounce } from 'lodash';
import { useMutation } from '@apollo/client';
import { CREATE_MESSAGE, TRANSLATION } from '@queries/messege.queries';
import { Microphone } from '@components/Icons';
import S from './style';

const Input: React.FC = () => {
  const [text, setText] = useState('');
  const [translatedText, setTranslatedText] = useState('텍스트를 입력하세요');
  const [createMessageMutation] = useMutation(CREATE_MESSAGE, {
    variables: {
      text,
    },
  });

  const [translationMutation] = useMutation(TRANSLATION, {
    variables: {
      text,
      target: 'en', // TODO: target 언어 수정하기
    },
  });

  const getTranslatedText = debounce(async () => {
    const { data } = await translationMutation();
    setTranslatedText(data ? data.translation.translatedText : '...');
  }, 500);

  const onKeyUp = () => {
    const checkText = text.replace(/\s/gi, '');
    if (checkText.length === 0) return;
    getTranslatedText();
  };

  const onChangeText = (e: React.ChangeEvent<HTMLInputElement>) => {
    setText(e.target.value);
    setTranslatedText('...');
  };

  const onKeyPressEnter = async (e: React.KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      const checkText = text.replace(/\s/gi, '');
      if (checkText.length === 0) return;

      await createMessageMutation();
      setText('');
      setTranslatedText('텍스트를 입력하세요');
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
        <S.Translation>{translatedText}</S.Translation>
      </S.InputWrapper>
    </S.Wrapper>
  );
};

export default Input;
