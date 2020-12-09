import React, { FC } from 'react';
import { useLocation } from 'react-router-dom';
import styled from 'styled-components';
import Avatar from '@components/Avatar';
import { Message } from '@generated/types';
import formatTime from '@utils/formatTimezone';
import Balloon from './Balloon';

interface TranslatedMessage {
  originText: string;
  translatedText: string;
}

interface Props {
  message?: Message;
  obj?: TranslatedMessage;
}

interface isOriginProps {
  isOrigin: boolean;
}

const Wrapper = styled.div<isOriginProps>`
  display: flex;
  justify-content: ${(props) => (props.isOrigin ? 'flex-end' : null)};
  width: 100%;
  margin-bottom: 1rem;
`;

const Column = styled.div`
  margin: 0 0.5rem;
`;

const Info = styled.div<isOriginProps>`
  display: flex;
  justify-content: ${(props) => (props.isOrigin ? 'flex-end' : null)};
  margin: 0 0 0.4rem 0.2rem;
`;

const Text = styled.span`
  margin-right: 0.3rem;
`;

const DoubleBubble = styled.div`
  display: flex;
  align-items: center;
`;

const ChatRow: FC<Props> = ({ message, obj }) => {
  const location = useLocation<{ userId: number; lang: string }>();
  const { lang, userId } = location.state;

  const isOrigin = userId === message?.user.id;
  const author = message?.user.nickname;
  const createdAt = formatTime(message?.createdAt as string, lang);
  const avatar = message?.user.avatar;

  return (
    <Wrapper isOrigin={isOrigin}>
      <>
        {!isOrigin && <Avatar size={50} profile={avatar} />}
        <Column>
          {obj ? (
            <>
              <Info isOrigin={isOrigin}>
                <Text>{author}</Text>
                <Text>{createdAt}</Text>
              </Info>
              <DoubleBubble>
                <Balloon isOrigin={isOrigin} originText={obj?.originText} />
                {obj?.originText === obj?.translatedText ? null : (
                  <Balloon
                    isOrigin={isOrigin}
                    translatedText={obj?.translatedText}
                    isLeft
                  />
                )}
              </DoubleBubble>
            </>
          ) : (
            <>
              <Info isOrigin={isOrigin}>
                <Text>{author}</Text>
                <Text>{createdAt}</Text>
              </Info>
              <Balloon isOrigin={isOrigin} text={message?.text} />
            </>
          )}
        </Column>
        {isOrigin && <Avatar size={50} profile={avatar} />}
      </>
    </Wrapper>
  );
};

export default ChatRow;
