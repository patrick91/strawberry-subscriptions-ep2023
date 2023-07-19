export type Maybe<T> = T | null;
export type InputMaybe<T> = Maybe<T>;
export type Exact<T extends { [key: string]: unknown }> = { [K in keyof T]: T[K] };
export type MakeOptional<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]?: Maybe<T[SubKey]> };
export type MakeMaybe<T, K extends keyof T> = Omit<T, K> & { [SubKey in K]: Maybe<T[SubKey]> };
/** All built-in and custom scalars, mapped to their actual values */
export type Scalars = {
  ID: string;
  String: string;
  Boolean: boolean;
  Int: number;
  Float: number;
};

export type Answer = {
  __typename?: 'Answer';
  id: Scalars['ID'];
  percentage: Scalars['Int'];
  text: Scalars['String'];
  votes: Scalars['Int'];
};

export type CreatePollInput = {
  answers: Array<Scalars['String']>;
  description?: InputMaybe<Scalars['String']>;
  question: Scalars['String'];
};

export type Mutation = {
  __typename?: 'Mutation';
  createPoll: Poll;
  vote?: Maybe<Poll>;
};


export type MutationCreatePollArgs = {
  input: CreatePollInput;
};


export type MutationVoteArgs = {
  answerId: Scalars['ID'];
  pollId: Scalars['ID'];
};

export type Poll = {
  __typename?: 'Poll';
  answers: Array<Answer>;
  description?: Maybe<Scalars['String']>;
  id: Scalars['ID'];
  question: Scalars['String'];
  totalVotes: Scalars['Int'];
};

export type Query = {
  __typename?: 'Query';
  poll?: Maybe<Poll>;
};


export type QueryPollArgs = {
  id: Scalars['ID'];
};

export type Subscription = {
  __typename?: 'Subscription';
  onPollUpdate: Poll;
};


export type SubscriptionOnPollUpdateArgs = {
  id: Scalars['ID'];
};
