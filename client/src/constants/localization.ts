interface TextList {
  inputNickName: string;
  nicknameError: string;
  selectLanguage: string;
  enterRoom: string;
  createRoom: string;
  enterCode: string;
  submitCode: string;
  userList: string;
}

const textList = {
  ko: {
    inputNickName: '닉네임 입력',
    nicknameError: '닉네임은 1~12자 사이여야 합니다.',
    selectLanguage: '언어 선택',
    enterRoom: '대화 참여하기',
    createRoom: '방 만들기',
    enterCode: '참여 코드(6자리의 숫자)를 입력해주세요.',
    submitCode: '입장',
    userList: '대화 상대',
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
  },
};

const getText = (lang: 'ko' | 'en'): TextList => {
  return textList[lang];
};

export { getText };
export type { TextList };
