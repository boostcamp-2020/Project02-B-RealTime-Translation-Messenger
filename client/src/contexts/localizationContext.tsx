import React, { createContext, useContext, useState } from 'react';
import { TextList, getText } from '@constants/localization';

const LocalizationStateContext = createContext<TextList | undefined>(undefined);
const LocalizationDispatchContext = createContext<
  React.Dispatch<React.SetStateAction<TextList>> | undefined
>(undefined);

const initialState = getText('ko');

const LocalizationContextProvider: React.FC<React.ReactNode> = ({
  children,
}) => {
  const [localization, setLocalization] = useState(initialState);
  return (
    <LocalizationDispatchContext.Provider value={setLocalization}>
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

const useLocalizationDispatch = (): React.Dispatch<
  React.SetStateAction<TextList>
> => {
  const setState = useContext(LocalizationDispatchContext);
  if (!setState) throw new Error('useLocalizationDispatch Provider not found');
  return setState;
};

export {
  LocalizationContextProvider,
  useLocalizationState,
  useLocalizationDispatch,
};
