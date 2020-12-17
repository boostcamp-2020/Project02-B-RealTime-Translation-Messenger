import React, { useState, useEffect } from 'react';
import { debounce } from 'lodash';
import { useLocation } from 'react-router-dom';
import { useMutation } from '@apollo/client';
import { CREATE_MESSAGE, TRANSLATION } from '@queries/messege.queries';
import { getText } from '@constants/localization';
import SpeechRecognition, {
  useSpeechRecognition,
} from 'react-speech-recognition';
import Listening from '@components/Listening';
import Badge from './Badge';
import S from './style';

interface LocationState {
  lang: string;
}

const Input: React.FC = () => {
  const [text, setText] = useState('');
  const location = useLocation<LocationState>();
  const { lang } = location.state;
  const { inputText, translationText, translationErrorText } = getText(lang);
  const [translatedText, setTranslatedText] = useState(translationText);
  const [isListening, setIsListening] = useState(false);
  const { transcript } = useSpeechRecognition();

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
    if (data.translation.translatedText === null)
      setTranslatedText(translationText);
    else
      setTranslatedText(
        data.translation.translatedText.length > 0
          ? data.translation.translatedText
          : translationErrorText,
      );
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
      setTranslatedText(translationText);
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
    getTranslatedText();
    return () => {
      clearTimeout(timer);
    };
  }, [transcript]);

  return (
    <S.Wrapper>
      <S.InputWrapper>
        <S.InputContainer>
          <S.Input
            placeholder={inputText}
            value={text}
            onChange={onChangeText}
            onKeyUp={onKeyUp}
            onKeyPress={onKeyPressEnter}
            maxLength={190}
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
        <S.Translation placeholder={translationText} value={translatedText} />
        <Badge textLength={text.length} />
      </S.InputWrapper>
    </S.Wrapper>
  );
};

export default Input;
