import React, { FC } from 'react';
import styled from 'styled-components';
import { Message } from '@generated/types';
import ChatRow from './ChatRow';

interface Props {
  messages: Message[];
}

interface TranslatedText {
  originText: string;
  translatedText: string;
}

const Wrapper = styled.div`
  /* position: absolute;
  bottom: 0; */
  width: 100%;
  padding: 6rem 2rem 8rem 2rem;
`;

const ChatLog: FC<Props> = ({ messages }) => {
  return (
    <Wrapper>
      {messages.map((message) => {
        try {
          const obj: TranslatedText = JSON.parse(message.text);
          return (
            <ChatRow
              key={message.id}
              obj={obj}
              author={message.user.nickname}
              createdAt={message.createdAt as string}
              message={message}
            />
          );
        } catch {
          // TODO: Logic 수정 필요 return
        }
        return (
          <ChatRow
            key={message.id}
            message={message}
            author={message.user.nickname}
          />
        );
      })}
    </Wrapper>
  );
};

export default ChatLog;
