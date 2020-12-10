import React, { useState, useEffect } from 'react';
import { debounce } from 'lodash';
import { useLocation } from 'react-router-dom';
import { useMutation } from '@apollo/client';
import { CREATE_MESSAGE, TRANSLATION } from '@queries/messege.queries';
import SpeechRecognition, {
  useSpeechRecognition,
} from 'react-speech-recognition';
import Listening from '@components/Listening';
import S from './style';

interface LocationState {
  lang: string;
}

const Input: React.FC = () => {
  const [text, setText] = useState('');
  const [translatedText, setTranslatedText] = useState('텍스트를 입력하세요');
  const [isListening, setIsListening] = useState(false);
  const { transcript } = useSpeechRecognition();
  const location = useLocation<LocationState>();
  const { lang } = location.state;
  const [createMessageMutation] = useMutation(CREATE_MESSAGE, {
    variables: {
      text,
    },
  });

  const [translationMutation] = useMutation(TRANSLATION, {
    variables: {
      text,
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

  const onClickVoiceButton = () => {
    if (!isListening) {
      SpeechRecognition.startListening({ language: lang });
    }
  };

  useEffect(() => {
    const timer = setTimeout(() => setIsListening(false), 2000);
    setText(transcript);
    return () => {
      clearTimeout(timer);
    };
  }, [transcript]);

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
          <S.VoiceButton onClick={onClickVoiceButton}>
            <Listening
              isListening={isListening}
              setIsListening={setIsListening}
              setText={setText}
            />
          </S.VoiceButton>
        </S.InputContainer>
        <S.Margin />
        <S.Translation>{translatedText}</S.Translation>
      </S.InputWrapper>
    </S.Wrapper>
  );
};

export default Input;
