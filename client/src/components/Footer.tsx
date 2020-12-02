import React from 'react';
import styled from 'styled-components';

const FooterWrapper = styled.footer`
  position: absolute;
  left: 50%;
  transform: translate(-50%);
  bottom: 1.5rem;
  color: ${(props) => props.theme.text};
  text-align: center;
  font-size: 1.2rem;
  strong {
    font-weight: bold;
  }
`;

const Footer: React.FC = () => {
  return (
    <FooterWrapper>
      Powered by
      <strong> papago</strong>
    </FooterWrapper>
  );
};

export default Footer;
