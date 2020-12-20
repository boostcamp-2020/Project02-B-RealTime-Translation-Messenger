import formatTime from './formatTimezone';

interface User {
  id: number;
  avatar: string;
  lang: string;
}

interface Message {
  id: number;
  user: User;
  source: string;
  createdAt: string;
}

interface ReturnObj {
  isAvatarVisible: boolean;
  isTimeVisible: boolean;
}

export default (messageId: number, messages: Message[]): ReturnObj => {
  const getIndex = (element: Message) => element.id === messageId;
  const idx = messages.findIndex(getIndex);

  if (
    idx === 0 ||
    messages[idx - 1].source === 'in' ||
    messages[idx - 1].source === 'out'
  ) {
    return {
      isAvatarVisible: true,
      isTimeVisible: true,
    };
  }

  const origin = formatTime(messages[idx].createdAt, messages[idx].user.lang);
  const before = formatTime(
    messages[idx - 1].createdAt,
    messages[idx - 1].user.lang,
  );
  const isSameTime = origin === before;

  if (messages[idx - 1].user.id === messages[idx].user.id) {
    return {
      isAvatarVisible: false,
      isTimeVisible: !isSameTime,
    };
  }
  return {
    isAvatarVisible: true,
    isTimeVisible: !isSameTime,
  };
};
