"use client";
import { Suspense, useEffect } from "react";
import {
  useReadQuery,
  useBackgroundQuery,
  useSuspenseQuery,
} from "@apollo/experimental-nextjs-app-support/ssr";
import { useMutation } from "@apollo/client";
import { QueryReference } from "@apollo/client/react/cache/QueryReference";
import { Poll as PollInner } from "@/components/poll";

import { useState, useCallback } from "react";

import {
  VoteDocument,
  GetPollDocument,
  OnPollUpdateDocument,
} from "@/components/poll/documents.generated";

export const PollWrapper = ({ id }: { id: string }) => {
  const { data, subscribeToMore } = useSuspenseQuery(GetPollDocument, {
    variables: { id },
  });
  const [showResults, setShowResults] = useState(false);
  const [mutate, { loading: mutationLoading }] = useMutation(VoteDocument);

  useEffect(() => {
    const unsubscribe = subscribeToMore({
      document: OnPollUpdateDocument,
      variables: { id },
    });

    return () => unsubscribe();
  }, [subscribeToMore]);

  const handleClick = useCallback(
    async (answerId: string) => {
      await mutate({
        variables: { pollId: id, answerId },
      });

      setShowResults(true);
    },
    [mutate]
  );

  return (
    <PollInner
      poll={(data as any).poll}
      loading={mutationLoading}
      onClick={handleClick}
      showResults={showResults}
    />
  );
};
