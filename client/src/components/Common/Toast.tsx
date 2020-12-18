import React, { FC } from 'react';
import styled from 'styled-components';

interface StyleProps {
  isTop?: boolean;
}

const ToastWrapper = styled.div`
  .reveal {
    opacity: 1;
    visibility: visible;
    transform: translate(-50%, 0);
  }
`;
const ToastMsg = styled.div<StyleProps>`
  position: fixed;
  top: ${({ isTop }) => (isTop ? '5.5rem' : 'auto')};
  bottom: ${({ isTop }) => (isTop ? 'auto' : '5.5rem')};
  left: 50%;
  padding: 1rem 1.5rem;
  color: #fff;
  background: rgba(0, 0, 0, 0.5);
  border-radius: 30px;
  font-size: 0.8rem;
  transform: translate(-50%, 10px);
  transition: opacity 0.5s, visibility 0.5s, transform 0.5s;
  opacity: 0;
  visibility: hidden;
  z-index: 10000;
`;

interface Props {
  className: string;
  text: string;
}

const Toast: FC<Props> = ({ className, text }) => {
  return (
    <ToastWrapper>
      <ToastMsg className={className} isTop>
        {text}
      </ToastMsg>
    </ToastWrapper>
  );
};

export default Toast;
