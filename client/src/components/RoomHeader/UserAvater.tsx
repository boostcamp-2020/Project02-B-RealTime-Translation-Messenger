import React from 'react';
import { AvatarStack, Avatar } from '@primer/components';
import { User } from '@generated/types';

interface Props {
  users: User[];
}

const RoomHeader: React.FC<Props> = ({ users }) => {
  return (
    <AvatarStack alignRight>
      {users.map((user) => (
        <Avatar
          key={user.id}
          style={{
            width: '24px',
            height: '24px',
            backgroundColor: `${(props: any) => props.theme.whiteColor}`,
          }}
          alt={user.nickname}
          src={user.avatar}
        />
      ))}
    </AvatarStack>
  );
};

export default RoomHeader;
