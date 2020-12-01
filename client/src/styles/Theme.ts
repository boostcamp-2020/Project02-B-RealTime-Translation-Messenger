import { DefaultTheme } from 'styled-components';

const Theme = {
  blueColor: '#0F4C81',
  greenColor: '#22C263',
  lightGrayColor: '#E5E5E5',
  grayColor: '#C4C4C4',
  darkGrayColor: '#707070',
  blackColor: '#262626',
  whiteColor: '#FAFAFA',
  boxBorder: '1px solid #C4C4C4',
  borderRadius: '20px',
};

export const lightTheme: DefaultTheme = {
  bgColor: Theme.whiteColor,
  text: Theme.darkGrayColor,
  whiteColor: Theme.whiteColor,
  blackColor: Theme.blackColor,
  blueColor: Theme.blueColor,
  greenColor: Theme.greenColor,
  borderRadius: Theme.borderRadius,
  boxBorder: Theme.boxBorder,
};

export const darkTheme: DefaultTheme = {
  bgColor: Theme.blackColor,
  text: Theme.lightGrayColor,
  whiteColor: Theme.whiteColor,
  blackColor: Theme.blackColor,
  blueColor: Theme.blueColor,
  greenColor: Theme.greenColor,
  borderRadius: Theme.borderRadius,
  boxBorder: Theme.boxBorder,
};
