import React, { FC } from 'react';
import styled from 'styled-components';
import { useUserState } from '@contexts/UserContext';
import Avatar from '@components/Avatar';
import { Message } from '@generated/types';
import Balloon from './Balloon';

interface TranslatedMessage {
  originText: string;
  translatedText: string;
}

interface Props {
  author?: string;
  message?: Message;
  obj?: TranslatedMessage;
  createdAt?: string;
}

interface isOriginProps {
  isOrigin: boolean;
}

const Wrapper = styled.div<isOriginProps>`
  display: flex;
  justify-content: ${(props) => (props.isOrigin ? 'flex-end' : null)};
  width: 100%;
`;

const Column = styled.div``;

const Text = styled.span`
  margin-right: 5px;
  font-size: 14px;
`;

const DoubleBubble = styled.div`
  display: flex;
  align-items: center;
  div {
    margin-right: 20px;
  }
`;

const Info = styled.div<isOriginProps>`
  display: flex;
  justify-content: ${(props) => (props.isOrigin ? 'flex-end' : null)};
`;

const ChatRow: FC<Props> = ({ author, message, obj, createdAt }) => {
  const { nickname, avatar } = useUserState();
  const isOrigin = nickname === author;
  return (
    <Wrapper isOrigin={isOrigin}>
      {isOrigin ? (
        <>
          <Column>
            <Info isOrigin={isOrigin}>
              <Text>{message?.user.nickname}</Text>
              <Text>{message?.createdAt}</Text>
            </Info>
            <Balloon author={author} originText={obj?.originText} />
          </Column>
          <Avatar size={50} profile={avatar} />
        </>
      ) : (
        <>
          <Avatar size={50} profile={message?.user.avatar} />
          <Column>
            {obj ? (
              <>
                <Info isOrigin={isOrigin}>
                  <Text>{author}</Text>
                  <Text>{createdAt}</Text>
                </Info>
                <DoubleBubble>
                  <Balloon
                    author={author}
                    translatedText={obj?.translatedText}
                  />
                  <Balloon author={author} originText={obj?.originText} />
                </DoubleBubble>
              </>
            ) : (
              <>
                <Info isOrigin={isOrigin}>
                  <Text>{message?.user.nickname}</Text>
                  <Text>{message?.createdAt}</Text>
                </Info>
                <Balloon author={author} text={message?.text} />
              </>
            )}
          </Column>
        </>
      )}
    </Wrapper>
  );
};

export default ChatRow;
