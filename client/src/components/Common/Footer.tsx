import React from 'react';
import styled from 'styled-components';

interface StyleProps {
  color: string;
}

const FooterContainer = styled.footer<StyleProps>`
  color: ${({ color }) => color};
  text-align: center;
  font-size: 1.2rem;
  strong {
    font-weight: bold;
  }
`;

interface Props {
  color: string;
}

const Footer: React.FC<Props> = ({ color }) => {
  return (
    <FooterContainer color={color}>
      Powered by
      <strong> papago</strong>
    </FooterContainer>
  );
};

export default Footer;
