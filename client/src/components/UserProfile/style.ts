import styled from 'styled-components';

export default {
  ProfileWrapper: styled.div`
    display: flex;
    flex-direction: column;
    align-items: center;
  `,
  AvatarWrapper: styled.div`
    position: relative;
    width: 14.5rem;
    height: 14.5rem;

    background: ${(props) => props.theme.whiteColor};
    border: ${(props) => props.theme.boxBorder};
    border-radius: 50%;
  `,
  Avatar: styled.img`
    width: inherit;
    height: inherit;
    background: none;
  `,
  RefreshButton: styled.button`
    position: absolute;
    display: flex;
    align-items: center;
    justify-content: center;

    bottom: 0.8rem;
    right: 0.8rem;
    padding: 0.5rem;

    background: ${(props) => props.theme.grayColor};
    border-radius: 50%;

    svg {
      fill: ${(props) => props.theme.whiteColor};
    }
  `,
  NicknameInput: styled.input`
    width: 10rem;
    margin: 1rem 0;
    padding: 0.5rem;

    color: ${(props) => props.theme.text};
    border-bottom: ${(props) => props.theme.boxBorder};

    font-size: 18px;
    text-align: center;
  `,
  LanguageTitle: styled.div`
    color: ${(props) => props.theme.darkGrayColor};
    font-size: 18px;
    margin: 0 0 1rem 0;
  `,

  LanguageWrapper: styled.div`
    text-align: center;
    margin: 1rem 0;
  `,

  LanguageButton: styled.input<{ selected: boolean }>`
    width: 50px;
    height: 50px;
    margin: 0 0.3rem;
    color: ${(props) =>
      props.selected ? props.theme.blackColor : props.theme.whiteColor};
    background-color: ${(props) =>
      props.selected ? props.theme.lightGrayColor : props.theme.darkGrayColor};
    border-radius: ${(props) => props.theme.borderRadius};
    font-size: 1.2rem;
    font-weight: ${(props) => (props.selected ? 'bold' : '')};

    &:hover {
      color: ${(props) => props.theme.blackColor};
      background-color: ${(props) => props.theme.lightGrayColor};
    }
  `,
};
