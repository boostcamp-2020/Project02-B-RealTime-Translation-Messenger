export type Maybe<T> = T | null;
export type Exact<T extends { [key: string]: unknown }> = {
  [K in keyof T]: T[K];
};
export type MakeOptional<T, K extends keyof T> = Omit<T, K> &
  { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> &
  { [SubKey in K]: Maybe<T[SubKey]> };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
};

export type Query = {
  __typename?: 'Query';
  allMessagesById?: Maybe<Array<Maybe<Message>>>;
  allRooms?: Maybe<Array<Maybe<Room>>>;
  roomById?: Maybe<Room>;
  allUsers?: Maybe<Array<Maybe<User>>>;
};

export type QueryAllMessagesByIdArgs = {
  id: Scalars['Int'];
};

export type QueryRoomByIdArgs = {
  id: Scalars['Int'];
};

export type Message = {
  __typename?: 'Message';
  id: Scalars['Int'];
  text: Scalars['String'];
  source: Scalars['String'];
  room: Room;
  user: User;
  createdAt?: Maybe<Scalars['String']>;
  updatedAt?: Maybe<Scalars['String']>;
};

export type Room = {
  __typename?: 'Room';
  id: Scalars['Int'];
  avatar: Scalars['String'];
  code: Scalars['String'];
  users: Array<User>;
  messages: Array<Message>;
  createdAt?: Maybe<Scalars['String']>;
  updatedAt?: Maybe<Scalars['String']>;
};

export type User = {
  __typename?: 'User';
  id: Scalars['Int'];
  nickname: Scalars['String'];
  avatar: Scalars['String'];
  password?: Maybe<Scalars['String']>;
  lang: Scalars['String'];
  rooms: Array<Room>;
  messages: Array<Maybe<Message>>;
};

export type Mutation = {
  __typename?: 'Mutation';
  translation: TranslationResponse;
  createMessage: Scalars['Boolean'];
  createRoom: CreateRoomResponse;
  enterRoom: EnterRoomResponse;
  deleteUser: Scalars['Boolean'];
};

export type MutationTranslationArgs = {
  text: Scalars['String'];
  source: Scalars['String'];
  target: Scalars['String'];
};

export type MutationCreateMessageArgs = {
  text: Scalars['String'];
  source: Scalars['String'];
  userId: Scalars['Int'];
  roomId: Scalars['Int'];
};

export type MutationCreateRoomArgs = {
  nickname: Scalars['String'];
  avatar: Scalars['String'];
  lang: Scalars['String'];
};

export type MutationEnterRoomArgs = {
  nickname: Scalars['String'];
  avatar: Scalars['String'];
  lang: Scalars['String'];
  code: Scalars['String'];
};

export type MutationDeleteUserArgs = {
  userId: Scalars['Int'];
  roomId: Scalars['Int'];
};

export type TranslationResponse = {
  __typename?: 'translationResponse';
  translatedText: Scalars['String'];
};

export type CreateRoomResponse = {
  __typename?: 'createRoomResponse';
  userId: Scalars['Int'];
  roomId: Scalars['Int'];
  code: Scalars['String'];
};

export type EnterRoomResponse = {
  __typename?: 'enterRoomResponse';
  userId: Scalars['Int'];
  roomId: Scalars['Int'];
};

export type Subscription = {
  __typename?: 'Subscription';
  newMessage?: Maybe<Message>;
};

export type SubscriptionNewMessageArgs = {
  roomId: Scalars['Int'];
  lang: Scalars['String'];
};
