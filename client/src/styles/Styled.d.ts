import 'styled-components';

declare module 'styled-components' {
  export interface DefaultTheme {
    bgColor: string;
    text: string;
    whiteColor: string;
    blackColor: string;
    blueColor: string;
    greenColor: string;
    lightGrayColor: string;
    darkGrayColor: string;
    borderRadius: string;
    boxBorder: string;
  }
}
