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
    background: ${({ theme }) => theme.whiteColor};
    border: ${({ theme }) => theme.boxBorder};
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
    background: ${({ theme }) => theme.grayColor};
    border-radius: 50%;
    svg {
      fill: ${({ theme }) => theme.whiteColor};
    }
  `,
  NicknameWrapper: styled.div`
    width: 80%;
    margin-top: 0.5rem;
    margin-bottom: 0.2rem;
  `,
  NicknameInput: styled.input`
    width: 100%;
    margin: 0 auto;
    padding: 0.5rem;
    color: ${({ theme }) => theme.text};
    border-bottom: ${({ theme }) => theme.boxBorder};
    font-size: 18px;
    text-align: center;
  `,
  NicknameValidator: styled.div`
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    margin-top: 0.3rem;

    span {
      &:first-child {
        color: red;
      }
      color: ${(props) => props.theme.text};
    }
  `,
  LanguageTitle: styled.div`
    margin: 0 0 1rem 0;
    color: ${({ theme }) => theme.darkGrayColor};
    font-size: 18px;
  `,
  LanguageWrapper: styled.div`
    margin: 1rem 0;
    text-align: center;
  `,
  LanguageButtonWrapper: styled.div`
    display: flex;
    align-items: center;
    justify-content: center;
  `,
  LanguageButton: styled.div`
    display: flex;
    align-items: center;
    justify-content: center;
    width: 50px;
    height: 50px;
    margin: 0 0.3rem;
    background-color: ${({ theme }) => theme.lightGrayColor};
    border-radius: ${({ theme }) => theme.borderRadius};
    font-size: 1.2rem;
  `,
  LanguageRefreshButton: styled.button`
    display: flex;
    justify-content: center;
    align-items: center;
    width: 50px;
    height: 50px;
    margin: 0 0.3rem;
    background-color: ${({ theme }) => theme.darkGrayColor};
    border-radius: ${({ theme }) => theme.borderRadius};
    &:hover {
      filter: brightness(85%);
    }
    svg {
      fill: ${({ theme }) => theme.whiteColor};
    }
  `,
};
