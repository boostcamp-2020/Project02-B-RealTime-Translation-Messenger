import styled from 'styled-components';

export default {
  Wrapper: styled.div`
    bottom: 0;
    width: 100%;
    height: 20vh;
    background: ${(props) => props.theme.bgColor};
  `,
  InputWrapper: styled.div`
    display: flex;
    height: 6rem;
    margin: 0 2rem 1.5rem 2rem;
  `,
  InputContainer: styled.div`
    position: relative;
    flex: 1 0 0;
    width: 100%;
    height: 100%;
    background: #f7f7f7;
    border-radius: ${({ theme }) => theme.borderRadius};
    overflow: hidden;
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
  `,
  Input: styled.input`
    width: 100%;
    padding: 1rem 5rem 1rem 1rem;
    font-size: 16px;
  `,
  VoiceButton: styled.button`
    position: absolute;
    top: 50%;
    right: 0;
    margin-right: 1rem;
    transform: translateY(-50%);
  `,
  Margin: styled.div`
    flex: 0.02 0 0;
  `,
  Translation: styled.div`
    flex: 1 0 0;
    height: 100%;
    padding: 1rem;
    background: #f7f7f7;
    border-radius: ${(props) => props.theme.borderRadius};
    box-shadow: 0px 2px 8px rgba(0, 0, 0, 0.15);
    font-size: 16px;
  `,
};
