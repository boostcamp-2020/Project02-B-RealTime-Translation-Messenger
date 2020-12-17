import React, { FC } from 'react';
import styled from 'styled-components';

const Line = styled.div`
  display: inline-block;
  width: 1px;
  height: 25px;
  margin: 0 3px;
  border-radius: 10px;
  transform-origin: center center;
  animation: expand 1s ease-in-out infinite;
`;

const Container = styled.button`
  position: fixed;
  top: 45vh;
  left: 50vw;
  transform: translateX(-50%);
  div {
    :nth-child(1) {
      background: #27ae60;
    }

    :nth-child(2) {
      animation-delay: 180ms;
      background: #f1c40f;
    }

    :nth-child(3) {
      animation-delay: 360ms;
      background: #e67e22;
    }

    :nth-child(4) {
      animation-delay: 540ms;
      background: #2980b9;
    }

    @keyframes expand {
      0% {
        transform: scale(1);
      }
      25% {
        transform: scale(2);
      }
    }
  }
`;

const Loader: FC = () => (
  <Container>
    <Line />
    <Line />
    <Line />
    <Line />
  </Container>
);

export default Loader;
