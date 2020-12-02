import { DefaultTheme } from 'styled-components';

export const Theme = {
  blueColor: '#0F4C81',
  greenColor: '#22C263',
  lightGrayColor: '#E5E5E5',
  grayColor: '#C4C4C4',
  darkGrayColor: '#707070',
  blackColor: '#262626',
  whiteColor: '#FAFAFA',
  boxBorder: '1px solid #C4C4C4',
  borderRadius: '20px',
  borderRadiusSmall: '10px',
  Overlay: 'rgba(0, 0, 0, 0.6)',
};

export const lightTheme: DefaultTheme = {
  bgColor: Theme.whiteColor,
  text: Theme.darkGrayColor,
  lightGrayColor: Theme.lightGrayColor,
  grayColor: Theme.grayColor,
  darkGrayColor: Theme.darkGrayColor,
  whiteColor: Theme.whiteColor,
  blackColor: Theme.blackColor,
  blueColor: Theme.blueColor,
  greenColor: Theme.greenColor,
  lightGrayColor: Theme.lightGrayColor,
  darkGrayColor: Theme.darkGrayColor,
  borderRadius: Theme.borderRadius,
  borderRadiusSmall: Theme.borderRadiusSmall,
  boxBorder: Theme.boxBorder,
  Overlay: Theme.Overlay,
};

export const darkTheme: DefaultTheme = {
  bgColor: Theme.blackColor,
  text: Theme.lightGrayColor,
  lightGrayColor: Theme.lightGrayColor,
  grayColor: Theme.grayColor,
  darkGrayColor: Theme.darkGrayColor,
  whiteColor: Theme.whiteColor,
  blackColor: Theme.blackColor,
  blueColor: Theme.blueColor,
  greenColor: Theme.greenColor,
  lightGrayColor: Theme.lightGrayColor,
  darkGrayColor: Theme.darkGrayColor,
  borderRadius: Theme.borderRadius,
  borderRadiusSmall: Theme.borderRadiusSmall,
  boxBorder: Theme.boxBorder,
  Overlay: Theme.Overlay,
};
