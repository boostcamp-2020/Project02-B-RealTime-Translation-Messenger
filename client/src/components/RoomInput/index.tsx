import React, { useState, useEffect } from 'react';
import { debounce } from 'lodash';
import { useHistory, useLocation } from 'react-router-dom';
import { useMutation } from '@apollo/client';
import { CREATE_MESSAGE, TRANSLATION } from '@queries/messege.queries';
import { getText } from '@constants/localization';
import SpeechRecognition, {
  useSpeechRecognition,
} from 'react-speech-recognition';
import { wsClient } from '@/apollo/Client';
import styled from 'styled-components';
import TextareaAutosize from 'react-autosize-textarea';
import Listening from './Listening';
import Badge from './Badge';

const Wrapper = styled.div`
  position: relative;
  bottom: 0;
  width: 100%;
  height: 20vh;
  background: ${(props) => props.theme.bgColor};
`;
const InputWrapper = styled.div`
  display: flex;
  height: fit-content;
  margin: 0 2rem 1.5rem 2rem;
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    flex-direction: column;
    div {
      :first-child {
        order: 3;
      }
      :nth-child(2) {
        order: 1;
      }
      :nth-child(1) {
        order: 2;
        margin: 1rem 0;
      }
    }
  }
`;
const InputContainer = styled.div`
  position: relative;
  flex: 1 0 0;
  width: 100%;
  min-width: 49%;
  min-height: 6rem;
  border-radius: ${({ theme }) => theme.borderRadius};
  overflow: hidden;
  box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    min-height: 4.5rem;
    max-height: 4.5rem;
    font-size: 12px;
  }
`;
const Input = styled(TextareaAutosize)<any>`
  width: 100%;
  min-height: 6rem;
  max-height: 6rem;
  padding: 1rem 5rem 3rem 1rem;
  background: #f7f7f7;
  border: none;
  font-size: 16px;
  resize: none;
  overflow: auto;
  &:focus {
    outline: none;
  }
  ${({ value }) =>
    value.length >= 190
      ? 'animation: vibrate 2s cubic-bezier(0.36, 0.07, 0.19, 0.97);'
      : ''}
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    min-height: 4.5rem;
    max-height: 4.5rem;
    padding: 1rem 3.5rem 1rem 1rem;
    font-size: 12px;
  }
  @keyframes vibrate {
    0%,
    2%,
    4%,
    6%,
    8%,
    10%,
    12%,
    14%,
    16%,
    18% {
      transform: translate3d(-1px, 0, 0);
    }
    1%,
    3%,
    5%,
    7%,
    9%,
    11%,
    13%,
    15%,
    17%,
    19% {
      transform: translate3d(1px, 0, 0);
    }
    20%,
    100% {
      transform: translate3d(0, 0, 0);
    }
  }
`;
const VoiceButton = styled.button`
  position: absolute;
  top: 50%;
  right: 0;
  margin-right: 1rem;
  transform: translateY(-50%);
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    width: 25px;
    height: 25px;
    transform: translate(-90%, -160%);
    svg {
      width: 20px;
      height: 20px;
    }
  }
`;
const Margin = styled.div`
  flex: 0.02 0 0;
`;
const Translation = styled(TextareaAutosize)<any>`
  flex: 1 0 0;
  width: 100%;
  min-width: 49%;
  min-height: 6rem;
  max-height: 6rem;
  padding: 1rem;
  color: ${({ theme }) => theme.darkGrayColor};
  background: #f7f7f7;
  border: none;
  border-radius: ${({ theme }) => theme.borderRadius};
  box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
  font-size: 16px;
  resize: none;
  overflow: auto;
  &:focus {
    outline: none;
  }
  &::-webkit-scrollbar-thumb {
    background-color: ${({ theme }) => theme.whiteColor};
  }
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    min-height: 3.5rem;
    max-height: 4.5rem;
    padding: 1rem;
    color: ${({ theme }) => theme.whiteColor};
    background: rgba(0, 0, 0, 0.5);
    font-size: 12px;
  }
`;

interface LocationState {
  lang: string;
}

const RoomInput: React.FC = () => {
  const [text, setText] = useState('');
  const history = useHistory();
  const location = useLocation<LocationState>();
  const { lang } = location.state;
  const {
    inputText,
    translationText,
    translationErrorText,
    tokenErrorText,
  } = getText(lang);
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
    if (!localStorage.getItem('token')) {
      alert(tokenErrorText);
      wsClient.close();
      history.push('/');
    }

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
    <Wrapper>
      <InputWrapper>
        <InputContainer>
          <Input
            placeholder={inputText}
            value={text}
            onChange={onChangeText}
            onKeyUp={onKeyUp}
            onKeyPress={onKeyPressEnter}
            maxLength={190}
          />
          <VoiceButton onClick={onClickVoiceButton}>
            <Listening
              isListening={isListening}
              setIsListening={setIsListening}
              setText={setText}
            />
          </VoiceButton>
        </InputContainer>
        <Margin />
        <Translation placeholder={translationText} value={translatedText} />
        <Badge textLength={text.length} />
      </InputWrapper>
    </Wrapper>
  );
};

export default RoomInput;
