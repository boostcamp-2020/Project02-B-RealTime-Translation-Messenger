import React, { FC, useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import styled from 'styled-components';
import Avatar from '@components/Avatar';
import formatTime from '@utils/formatTimezone';
import comparePrevMessage from '@utils/comparePrevMessage';
import Balloon from './Balloon';
import AvatarText from './AvatarText';
import TimeText from './TimeText';

interface TranslatedMessage {
  originText: string;
  translatedText: string;
}

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
  message?: Message;
  obj?: TranslatedMessage;
  allMessages: Message[];
}

interface isOriginProps {
  isOrigin: boolean;
}


interface LocationState {
  lang: string;
  userId: number;
}

interface Props {
  isAvatarVisible?: boolean;
  isTimeVisible?: boolean;
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

const DoubleBubble = styled.div`
  display: flex;
  align-items: center;
  min-width: 400px;
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    flex-direction: column;
    min-width: 50px;
    max-width: 200px;
    div {
      :first-child {
        margin-bottom: 0.5rem;
      }
      :nth-child(2) {
        margin: 0;
      }
    }
  }
`;

const UserChangedPopup = styled.div`
  width: fit-content;
  margin: 1.5rem auto;
  padding: 0.3rem 1rem;
  color: #fff;
  background-color: #000;
  border-radius: ${(props) => props.theme.borderRadiusSmall};
  font-size: 12px;
`;

const ChatRow: FC<Props> = ({ message, obj, allMessages }) => {
  const location = useLocation<LocationState>();
  const [isVisbleAvatar, setIsVisbleAvatar] = useState(true);
  const [isVisibleTime, setIsVisibleTime] = useState(true);
  const { lang, userId } = location.state;
  const isOrigin = userId === message?.user.id;
  const author = message?.user.nickname;
  const createdAt = formatTime(message?.createdAt as string, lang);
  const avatar = message?.user.avatar;
  const source = message?.source;
  const messageId = message?.id;

  useEffect(() => {
    const { isAvatarVisible, isTimeVisible } = comparePrevMessage(
      messageId as number,
      allMessages,
    );
    setIsVisbleAvatar(isAvatarVisible);
    setIsVisibleTime(isTimeVisible);
  }, [allMessages]);

  if (source === 'in' || source === 'out') {
    return <UserChangedPopup>{message?.text}</UserChangedPopup>;
  }

  return (
    <Wrapper isOrigin={isOrigin}>
      <>
        {!isOrigin && (
          <Avatar size={50} profile={avatar} isAvatarVisible={isVisbleAvatar} />
        )}
        <Column>
          <>
            <Info isOrigin={isOrigin}>
              <AvatarText text={author} isAvatarVisible={isVisbleAvatar} />
              <TimeText text={createdAt} isTimeVisible={isVisibleTime} />
            </Info>
            <DoubleBubble>
              <Balloon isOrigin={isOrigin} originText={obj?.originText} />
              {obj?.translatedText && (
                <Balloon
                  isOrigin={isOrigin}
                  translatedText={obj?.translatedText}
                  isLeft
                />
              )}
            </DoubleBubble>
          </>
        </Column>
        {isOrigin && (
          <Avatar size={50} profile={avatar} isAvatarVisible={isVisbleAvatar} />
        )}
      </>
    </Wrapper>
  );
};

export default ChatRow;
