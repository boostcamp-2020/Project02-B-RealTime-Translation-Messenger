import 'styled-components';

declare module 'styled-components' {
  export interface DefaultTheme {
    isLight: boolean;
    bgColor: string;
    text: string;
    lightGrayColor: string;
    grayColor: string;
    darkGrayColor: string;
    whiteColor: string;
    blackColor: string;
    blueColor: string;
    greenColor: string;
    reverseColor: string;
    borderRadius: string;
    borderRadiusSmall: string;
    boxBorder: string;
    Overlay: string;
    mediaSize: string;
  }
}
