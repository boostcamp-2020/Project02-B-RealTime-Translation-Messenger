import React, { createContext, useContext, useReducer } from 'react';
import { TextList, getText } from '@constants/localization';

const LocalizationStateContext = createContext<TextList | undefined>(undefined);
const LocalizationDispatchContext = createContext<
  React.Dispatch<Action> | undefined
>(undefined);

type Action = { type: 'SET_LOCAL'; lang: 'ko' | 'en' | 'ja' | 'zh-CN' };

const initialState = getText('ko');

const reducer = (state: TextList, action: Action) => {
  switch (action.type) {
    case 'SET_LOCAL':
      return getText(action.lang);
    default:
      throw new Error('unhandled action');
  }
};

const LocalizationContextProvider: React.FC<React.ReactNode> = ({
  children,
}) => {
  const [localization, dispatch] = useReducer(reducer, initialState);
  return (
    <LocalizationDispatchContext.Provider value={dispatch}>
      <LocalizationStateContext.Provider value={localization}>
        {children}
      </LocalizationStateContext.Provider>
    </LocalizationDispatchContext.Provider>
  );
};

const useLocalizationState = (): TextList => {
  const state = useContext(LocalizationStateContext);
  if (!state) throw new Error('useLocalizationState Provider not found');
  return state;
};

const useLocalizationDispatch = (): React.Dispatch<Action> => {
  const dispatch = useContext(LocalizationDispatchContext);
  if (!dispatch) throw new Error('useLocalizationDispatch Provider not found');
  return dispatch;
};

export {
  LocalizationContextProvider,
  useLocalizationState,
  useLocalizationDispatch,
};
