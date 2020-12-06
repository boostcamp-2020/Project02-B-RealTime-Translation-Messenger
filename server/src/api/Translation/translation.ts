import req from '@utils/request';

interface TranslationForm {
  text: string;
  source: string;
  target: string;
}

export default {
  Mutation: {
    translation: async (_: any, args: TranslationForm): Promise<string> => {
      try {
        const { text, source, target } = args;
        const translatedText = await req(text, source, target);
        return translatedText;
      } catch (e) {
        return e;
      }
    },
  },
};
