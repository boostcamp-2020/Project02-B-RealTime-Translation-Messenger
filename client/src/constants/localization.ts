interface TextList {
  inputNickName: string;
  nicknameError: string;
  selectLanguage: string;
  enterRoom: string;
  createRoom: string;
  enterCode: string;
  submitCode: string;
  wrongCode: string;
  userList: string;
  enterText: string;
  translationText: string;
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
    wrongCode: '잘못된 방코드입니다😅',
    userList: '대화 상대',
    enterText: '채팅을 입력해주세요',
    translationText: '번역',
  },
  en: {
    inputNickName: 'Enter Nickname',
    nicknameError: 'Nickname must be between 1 and 10 characters.',
    selectLanguage: 'Select Language',
    enterRoom: 'Enter ChatRoom',
    createRoom: 'Create ChatRoom',
    enterCode: 'Please enter 6 digits of the participating code.',
    submitCode: 'Enter',
    wrongCode: 'Invalid room code😅',
    userList: 'User List',
    enterText: 'Please enter a chat',
    translationText: 'Translation',
  },
  ja: {
    inputNickName: 'ニックネーム 入力',
    nicknameError: 'ニックネームは1~12字の間でなければなりません。',
    selectLanguage: '言語選択',
    enterRoom: '会話に参加する',
    createRoom: 'トークルーム作成',
    enterCode: '参加コード(6桁数字)を入力してください。',
    submitCode: '参加',
    wrongCode: '間違ったルームコードです😅',
    userList: 'メンバー',
    enterText: 'チャットを入力してください',
    translationText: '翻訳',
  },
  'zh-CN': {
    inputNickName: '输入昵称',
    nicknameError: '昵称必须介于1到12个字符之间。',
    selectLanguage: '语言选择',
    enterRoom: '加入聊天室',
    createRoom: '创建聊天室',
    enterCode: '请输入参加代码（6位数字）。',
    submitCode: '参与度',
    wrongCode: '是错误的房间代码😅',
    userList: '参加者名单',
    enterText: '请输入您的聊天内容',
    translationText: '翻译',
  },
};

const getText = (lang: string): TextList => {
  return textList[lang];
};

export { getText };
export type { TextList };
