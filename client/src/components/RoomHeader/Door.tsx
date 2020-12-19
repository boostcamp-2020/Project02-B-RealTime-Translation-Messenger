import React from 'react';
import { useHistory } from 'react-router-dom';
import { Door } from '@components/Common/Icons';
import { useMutation } from '@apollo/client';
import { DELETE_USER } from '@queries/user.queries';
import { CREATE_SYSTEM_MESSAGE } from '@queries/messege.queries';
import client, { wsClient } from '@/apollo/Client';
import styled from 'styled-components';

const DoorButton = styled.button`
  display: flex;
  align-items: center;
  width: 24px;
  height: 24px;
  margin-left: 1rem;
  svg {
    fill: ${({ theme }) => (theme.isLight ? theme.blackColor : '#545759')};
  }
  @media (max-width: ${({ theme }) => theme.mediaSize}) {
    margin-top: 3px;
    margin-left: 0.5rem;
    svg {
      width: 15px;
      height: 15px;
    }
  }
`;

const RoomHeader: React.FC = () => {
  const history = useHistory();
  const [deleteUser] = useMutation(DELETE_USER);

  const [createSystemMessageMutation] = useMutation(CREATE_SYSTEM_MESSAGE, {
    variables: { source: 'out' },
  });

  const leaveRoom = async () => {
    createSystemMessageMutation();
    history.push('/');
    await deleteUser();
    localStorage.removeItem('token');
    client.resetStore();
    wsClient.close();
  };

  return (
    <DoorButton onClick={leaveRoom}>
      <Door size={24} />
    </DoorButton>
  );
};

export default RoomHeader;
