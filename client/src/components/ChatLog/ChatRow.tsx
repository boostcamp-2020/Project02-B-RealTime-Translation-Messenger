import React, { FC, useState, useEffect } from 'react';
import { useLocation } from 'react-router-dom';
import styled from 'styled-components';
import Avatar from '@components/Common/Avatar';
import { getText } from '@constants/localization';
import formatTime from '@utils/formatTimezone';
import comparePrevMessage from '@utils/comparePrevMessage';
import Balloon from './Balloon';
import AvatarText from './AvatarText';
import TimeText from './TimeText';

interface StyleProps {
  isOrigin: boolean;
}

const Wrapper = styled.div<StyleProps>`
  display: flex;
  justify-content: ${(props) => (props.isOrigin ? 'flex-end' : null)};
  width: 100%;
  margin-bottom: 1rem;
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    margin-bottom: 0.5rem;
  }
`;
const Column = styled.div`
  margin: 0 0.5rem;
`;
const Info = styled.div<StyleProps>`
  display: flex;
  justify-content: ${(props) => (props.isOrigin ? 'flex-end' : null)};
  margin: 0 0 0.4rem 0.2rem;
`;
const DoubleBubble = styled.div<StyleProps>`
  display: flex;
  align-items: ${(props) => (props.isOrigin ? 'flex-end' : 'flex-start')};
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    flex-direction: column;
    max-width: 11rem;
    div {
      font-size: 10px;
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
  border-radius: ${({ theme }) => theme.borderRadiusSmall};
  font-size: 12px;
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    margin: 1rem auto;
    font-size: 8px;
  }
`;
const UserChangedPopupMessage = styled.span`
  color: ${({ theme }) => theme.grayColor};
`;

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

interface TranslatedMessage {
  originText: string;
  translatedText: string;
}
interface Props {
  message: Message;
  obj?: TranslatedMessage;
  allMessages: Message[];
  isAvatarVisible?: boolean;
  isTimeVisible?: boolean;
}

interface LocationState {
  lang: string;
  userId: number;
}

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
  const { enterText, leaveText } = getText(lang);

  useEffect(() => {
    const { isAvatarVisible, isTimeVisible } = comparePrevMessage(
      messageId as number,
      allMessages,
    );
    setIsVisbleAvatar(isAvatarVisible);
    setIsVisibleTime(isTimeVisible);
  }, [allMessages]);

  if (source === 'in' || source === 'out') {
    return (
      <UserChangedPopup>
        {message?.text}
        <UserChangedPopupMessage>
          {message.source === 'in' ? enterText : leaveText}
        </UserChangedPopupMessage>
      </UserChangedPopup>
    );
  }

  return (
    <Wrapper isOrigin={isOrigin}>
      <>
        {!isOrigin && (
          <Avatar size={50} profile={avatar} isAvatarVisible={isVisbleAvatar} />
        )}
        <Column>
          <Info isOrigin={isOrigin}>
            <AvatarText text={author} isAvatarVisible={isVisbleAvatar} />
            <TimeText text={createdAt} isTimeVisible={isVisibleTime} />
          </Info>
          <DoubleBubble isOrigin={isOrigin}>
            <Balloon isOrigin={isOrigin} text={obj?.originText} />
            {obj?.translatedText && (
              <Balloon isOrigin={isOrigin} text={obj?.translatedText} isLeft />
            )}
          </DoubleBubble>
        </Column>
        {isOrigin && (
          <Avatar size={50} profile={avatar} isAvatarVisible={isVisbleAvatar} />
        )}
      </>
    </Wrapper>
  );
};

export default ChatRow;
