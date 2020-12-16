interface TextList {
  inputNickName: string;
  nicknameError: string;
  selectLanguage: string;
  enterRoom: string;
  createRoom: string;
  enterCode: string;
  submitCode: string;
  userList: string;
  inputText: string;
  translationText: string;
  enterText: string;
  leaveText: string;
}

interface TextObj {
  [key: string]: TextList;
}

const textList: TextObj = {
  ko: {
    inputNickName: '닉네임 입력',
    nicknameError: '닉네임은 1~12자 사이여야 합니다.',
    selectLanguage: '언어 선택',
    enterRoom: '대화 참여하기',
    createRoom: '방 만들기',
    enterCode: '참여 코드(6자리의 숫자)를 입력해주세요.',
    submitCode: '입장',
    userList: '대화 상대',
    inputText: '채팅을 입력해주세요',
    translationText: '번역',
    enterText: '님이 들어왔습니다',
    leaveText: '님이 나갔습니다',
  },
  en: {
    inputNickName: 'Enter Nickname',
    nicknameError: 'Nickname must be between 1 and 10 characters.',
    selectLanguage: 'Select Language',
    enterRoom: 'Enter ChatRoom',
    createRoom: 'Create ChatRoom',
    enterCode: 'Please enter 6 digits of the participating code.',
    submitCode: 'Enter',
    userList: 'User List',
    inputText: 'Please enter a chat',
    translationText: 'Translation',
    enterText: ' is here',
    leaveText: ' left the chat room',
  },
  ja: {
    inputNickName: 'ニックネーム 入力',
    nicknameError: 'ニックネームは1~12字の間でなければなりません。',
    selectLanguage: '言語選択',
    enterRoom: '会話に参加する',
    createRoom: 'トークルーム作成',
    enterCode: '参加コード(6桁数字)を入力してください。',
    submitCode: '参加',
    userList: 'メンバー',
    inputText: 'チャットを入力してください',
    translationText: '翻訳',
    enterText: 'さんがチャットルームに入ってきました',
    leaveText: 'さんがチャットルームを出ました',
  },
  'zh-CN': {
    inputNickName: '输入昵称',
    nicknameError: '昵称必须介于1到12个字符之间。',
    selectLanguage: '语言选择',
    enterRoom: '加入聊天室',
    createRoom: '创建聊天室',
    enterCode: '请输入参加代码（6位数字）。',
    submitCode: '参与度',
    userList: '参加者名单',
    inputText: '请输入您的聊天内容',
    translationText: '翻译',
    enterText: '这位朋友进了聊天室',
    leaveText: '这位朋友从聊天室出去了',
  },
};

const getText = (lang: string): TextList => {
  return textList[lang];
};

export { getText };
export type { TextList };
