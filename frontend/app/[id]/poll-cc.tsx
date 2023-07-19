"use client";
import { Suspense } from "react";
import {
  useReadQuery,
  useBackgroundQuery,
} from "@apollo/experimental-nextjs-app-support/ssr";
import { useMutation } from "@apollo/client";
import { QueryReference } from "@apollo/client/react/cache/QueryReference";
import { Poll as PollInner } from "@/components/poll";

import { useState, useCallback } from "react";

import {
  VoteDocument,
  GetPollDocument,
  GetPollQuery,
} from "@/components/poll/documents.generated";

export const PollWrapper = ({ id }: { id: string }) => {
  const [queryRef] = useBackgroundQuery(GetPollDocument, {
    variables: { id },
  });

  return (
    <Suspense fallback={<>Loading...</>}>
      <Poll pollId={id} queryRef={queryRef} />
    </Suspense>
  );
};

const Poll = ({
  pollId,
  queryRef,
}: {
  pollId: string;
  queryRef: QueryReference<GetPollQuery>;
}) => {
  const { data } = useReadQuery(queryRef);
  const [showResults, setShowResults] = useState(false);
  const [mutate, { loading: mutationLoading }] = useMutation(VoteDocument);

  const handleClick = useCallback(
    async (answerId: string) => {
      await mutate({
        variables: { pollId, answerId },
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
