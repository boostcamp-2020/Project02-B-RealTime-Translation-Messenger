import req from '@utils/request';

interface TranslationForm {
  text: string;
  target: string;
}

export default {
  Mutation: {
    translation: async (
      _: any,
      args: TranslationForm,
      { request, isAuthenticated }: any,
    ): Promise<{ translatedText: string }> => {
      try {
        isAuthenticated(request);
        const { text, target } = args;
        const { lang: source } = request.user;
        const translatedText = await req(text, source, target);
        return { translatedText: translatedText };
      } catch (e) {
        return { translatedText: '텍스트를 입력하세요' };
      }
    },
  },
};
