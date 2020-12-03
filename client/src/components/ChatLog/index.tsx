import React, { FC } from 'react';
import { Message } from '@generated/types';
import ChatRow from './ChatRow';

interface Props {
  messages: Message[];
}

interface TranslatedText {
  originText: string;
  translatedText: string;
}

const ChatLog: FC<Props> = ({ messages }) => {
  return (
    <div>
      <div>New massages</div>
      <div>
        {messages.map((message) => {
          try {
            const obj: TranslatedText = JSON.parse(message.text);
            return (
              <ChatRow
                key={message.id}
                obj={obj}
                author={message.user.nickname}
                createdAt={message.createdAt as string}
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
      </div>
    </div>
  );
};

export default ChatLog;
