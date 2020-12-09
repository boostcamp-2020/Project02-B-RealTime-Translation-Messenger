interface User {
  id: number;
  avatar: string;
  nickname: string;
  lang: string;
}

interface CountObject {
  [key: string]: number;
}

export default (users: User[], lang: string): string => {
  const countObj: CountObject = {};

  for (let i = 0; i < users.length; i++) {
    const userLang = users[i].lang;
    if (userLang !== lang) {
      if (!countObj[userLang]) {
        countObj[userLang] = 1;
      } else {
        countObj[userLang] = ++countObj[userLang];
      }
    }
  }
  if (Object.keys(countObj).length) {
    const key = Object.keys(countObj).reduce((key1, key2) =>
      countObj[key1] > countObj[key2] ? key1 : key2,
    );
    return key;
  } else {
    if (lang === 'en') {
      return 'ko';
    }
    return 'en';
  }
};
