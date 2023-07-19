# AUTOGENERATED FROM 'app/polls/insert_poll.edgeql' WITH:
#     $ edgedb-py


from __future__ import annotations
import dataclasses
import edgedb
import uuid


class NoPydanticValidation:
    @classmethod
    def __get_validators__(cls):
        from pydantic.dataclasses import dataclass as pydantic_dataclass

        pydantic_dataclass(cls)
        cls.__pydantic_model__.__get_validators__ = lambda: []
        return []


@dataclasses.dataclass
class InsertPollResult(NoPydanticValidation):
    id: uuid.UUID
    question: str
    description: str | None
    answers: list[InsertPollResultAnswersItem]


@dataclasses.dataclass
class InsertPollResultAnswersItem(NoPydanticValidation):
    id: uuid.UUID
    text: str
    votes: int


async def insert_poll(
    executor: edgedb.AsyncIOExecutor,
    *,
    question: str,
    description: str | None,
    answers: str,
) -> InsertPollResult:
    return await executor.query_single(
        """\
        with new_poll := (
            insert Poll {
                question := <str>$question,
                description := <optional str>$description,
                answers := (
                    for answer in json_array_unpack(<json>$answers)
                    union (
                        insert Answer {
                            text := <str>answer,
                        }
                    )
                )
            }
        )

        select new_poll {id, question, description, answers: {id, text, votes}}\
        """,
        question=question,
        description=description,
        answers=answers,
    )
