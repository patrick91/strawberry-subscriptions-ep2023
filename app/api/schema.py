import strawberry
import json
from uuid import UUID
from strawberry.types import Info
from .context import Context
from app.polls.insert_poll_async_edgeql import insert_poll, InsertPollResult
from app.polls.get_poll_async_edgeql import get_poll, GetPollResult
from app.polls.vote_async_edgeql import vote


@strawberry.type
class Answer:
    id: strawberry.ID
    text: str
    votes: int


@strawberry.type
class Poll:
    id: strawberry.ID
    question: str
    description: str | None = None
    answers: list[Answer]
    total_votes: int

    @classmethod
    def from_db(cls, poll: GetPollResult | InsertPollResult):
        answers = [
            Answer(
                id=strawberry.ID(str(answer.id)),
                text=answer.text,
                votes=answer.votes,
            )
            for answer in poll.answers
        ]

        return cls(
            id=strawberry.ID(str(poll.id)),
            question=poll.question,
            description=poll.description,
            answers=answers,
            total_votes=sum(answer.votes for answer in poll.answers),
        )


@strawberry.type
class Query:
    @strawberry.field
    async def poll(self, info: Info[Context, None], id: strawberry.ID) -> Poll | None:
        poll = await get_poll(info.context["edgedb"], id=UUID(id))

        if not poll:
            return None

        return Poll.from_db(poll)


@strawberry.input
class CreatePollInput:
    question: str
    description: str | None = None
    answers: list[str]


@strawberry.type
class Mutation:
    @strawberry.mutation
    async def create_poll(
        self,
        info: Info[Context, None],
        input: CreatePollInput,
    ) -> Poll:
        client = info.context["edgedb"]

        poll = await insert_poll(
            client,
            question=input.question,
            description=input.description,
            answers=json.dumps(input.answers),
        )

        return Poll.from_db(poll)

    @strawberry.mutation
    async def vote(
        self,
        info: Info[Context, None],
        poll_id: strawberry.ID,
        answer_id: strawberry.ID,
    ) -> Poll | None:
        client = info.context["edgedb"]

        if await vote(client, id=UUID(answer_id)) is None:
            return None

        if poll := await get_poll(client, id=UUID(poll_id)):
            return Poll.from_db(poll)


schema = strawberry.Schema(query=Query, mutation=Mutation)
