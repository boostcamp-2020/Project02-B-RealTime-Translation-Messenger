import styled from 'styled-components';

export default {
  ProfileWrapper: styled.div`
    display: flex;
    flex-direction: column;
    align-items: center;
  `,
  AvatarWrapper: styled.div`
    position: relative;
    width: 16rem;
    height: 16rem;

    background: ${(props) => props.theme.whiteColor};
    box-sizing: border-box;
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

    bottom: 1rem;
    right: 1rem;
    padding: 0.5rem;

    background: ${(props) => props.theme.grayColor};
    border-radius: 50%;

    svg {
      fill: ${(props) => props.theme.whiteColor};
    }
  `,
  NicknameInput: styled.input`
    width: 12rem;
    margin: 1rem 0;
    padding: 0.5rem;

    color: ${(props) => props.theme.text};
    border-bottom: ${(props) => props.theme.boxBorder};

    font-size: 18px;
    text-align: center;
  `,
};
