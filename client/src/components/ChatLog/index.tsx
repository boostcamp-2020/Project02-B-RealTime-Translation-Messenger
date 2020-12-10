import React, { FC, useEffect, useRef } from 'react';
import { useLocation } from 'react-router-dom';
import styled from 'styled-components';
import { Message, User } from '@generated/types';
import ChatRow from './ChatRow';

interface Props {
  messages: Message[];
  page: number;
  setPage: any;
  onLoadMore: any;
}

interface ChangeUserType {
  type: string;
  user: User;
}

interface TranslatedText {
  originText: string;
  translatedText: string;
}

const Wrapper = styled.div`
  width: 100%;
  height: 70vh;
  margin: 1rem 0;
  padding: 0 2rem;
  overflow-x: hidden;
  overflow-y: scroll;
`;

const ChatLog: FC<Props> = ({ messages, page, setPage, onLoadMore }) => {
  const location = useLocation<{ roomId: number }>();
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
          return <ChatRow key={message.id} obj={obj} message={message} />;
        } catch {
          // TODO: Logic 수정 필요 return
        }
        return <ChatRow key={message.id} message={message} />;
      })}
    </Wrapper>
  );
};

export default ChatLog;
