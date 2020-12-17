interface OffsetTable {
  [key: string]: number;
}

const timeOffsetTable: OffsetTable = {
  ko: 9,
  en: -5,
  'zh-CN': 8,
  ja: 9,
  fr: 1,
};

const formatTime = (timestamp: string, langCode: string): string => {
  const time = +timestamp;
  const date = new Date(time);
  const tz =
    date.getTime() +
    date.getTimezoneOffset() * 60000 +
    timeOffsetTable[langCode] * 3600000;

  const now = new Date(tz);
  const Hour = now.getHours();
  const minute = now.getMinutes();

  const amPMTime =
    Hour > 12
      ? `오후 ${Hour - 12}:${minute >= 10 ? minute : `0${minute}`}`
      : `오전 ${Hour}:${minute >= 10 ? minute : `0${minute}`}`;

  return amPMTime;
};

export default formatTime;
