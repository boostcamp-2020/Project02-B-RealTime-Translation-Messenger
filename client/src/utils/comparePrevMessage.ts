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
  if (idx === 0) {
    return {
      isAvatarVisible: true,
      isTimeVisible: true,
    };
  }
  if (messages[idx - 1].source === 'in' || messages[idx - 1].source === 'out') {
    return {
      isAvatarVisible: true,
      isTimeVisible: true,
    };
  }
  if (messages[idx - 1].user.id === messages[idx].user.id) {
    const origin = formatTime(messages[idx].createdAt, messages[idx].user.lang);
    const before = formatTime(
      messages[idx - 1].createdAt,
      messages[idx - 1].user.lang,
    );
    if (origin === before) {
      return {
        isAvatarVisible: false,
        isTimeVisible: false,
      };
    }
    return {
      isAvatarVisible: false,
      isTimeVisible: true,
    };
  }
  const origin = formatTime(messages[idx].createdAt, messages[idx].user.lang);
  const before = formatTime(
    messages[idx - 1].createdAt,
    messages[idx - 1].user.lang,
  );
  if (origin === before) {
    return {
      isAvatarVisible: true,
      isTimeVisible: false,
    };
  }
  return {
    isAvatarVisible: true,
    isTimeVisible: true,
  };
};
