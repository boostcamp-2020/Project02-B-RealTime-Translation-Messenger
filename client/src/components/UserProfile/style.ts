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
    background: ${(props) => props.theme.bgColor};
    box-sizing: border-box;
    border: ${(props) => props.theme.boxBorder};
    border-radius: 50%;
  `,
  Avatar: styled.img`
    background: none;
    width: inherit;
    height: inherit;
  `,
  RefreshButton: styled.button`
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    padding: 0.5rem;
    bottom: 1rem;
    right: 1rem;
    position: absolute;
    background: ${(props) => props.theme.grayColor};
    svg {
      fill: ${(props) => props.theme.whiteColor};
    }
  `,
  NicknameInput: styled.input`
    width: 12rem;
    text-align: center;
    padding: 0.5rem;
    margin: 1rem 0;
    border-bottom: ${(props) => props.theme.boxBorder};
    font-size: 18px;
    color: ${(props) => props.theme.text};
  `,
};
