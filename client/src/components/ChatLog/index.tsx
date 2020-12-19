import React, { FC, useEffect, useRef } from 'react';
import { useLocation } from 'react-router-dom';
import styled from 'styled-components';
import ChatRow from './ChatRow';

interface User {
  id: number;
  nickname: string;
  avatar: string;
  lang: string;
}

interface Message {
  id: number;
  text: string;
  createdAt: string;
  source: string;
  user: User;
}

interface Props {
  messages: Message[];
  page: number;
  setPage: React.Dispatch<React.SetStateAction<number>>;
  onLoadMore: (variables: { roomId: number; page: number }) => void;
}

interface LocationState {
  roomId: number;
}

interface TranslatedText {
  originText: string;
  translatedText: string;
}

const Wrapper = styled.div`
  width: 100%;
  height: 65vh;
  margin: 1rem 0;
  padding: 0 2rem;
  overflow-x: hidden;
  overflow-y: scroll;
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    height: 55vh;
    padding: 0 1rem;
  }
`;

const ChatLog: FC<Props> = ({ messages, page, setPage, onLoadMore }) => {
  const location = useLocation<LocationState>();
  const { roomId } = location.state;
  const chatLogRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    chatLogRef.current!.scrollTop = chatLogRef.current!.scrollHeight;
  }, [messages]);

  const onScrollEvent = (e: React.UIEvent<HTMLDivElement, UIEvent>) => {
    if (e.currentTarget.scrollTop === 0) {
      onLoadMore({ roomId, page });
      setPage(page + 1);
    }
  };

  return (
    <Wrapper onScroll={onScrollEvent} ref={chatLogRef}>
      {messages.map((message) => {
        try {
          const obj: TranslatedText = JSON.parse(message.text);
          return (
            <ChatRow
              key={message.id}
              obj={obj}
              message={message}
              allMessages={messages}
            />
          );
        } catch {
          return (
            <ChatRow
              key={message.id}
              message={message}
              allMessages={messages}
            />
          );
        }
      })}
    </Wrapper>
  );
};

export default ChatLog;
