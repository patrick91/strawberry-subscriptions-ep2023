from typing import TypedDict
import edgedb


class Context(TypedDict):
    edgedb: edgedb.AsyncIOClient


def get_context() -> Context:
    edgedb_client = edgedb.create_async_client()

    return {
        "edgedb": edgedb_client,
    }
