from fastapi import FastAPI
from strawberry.fastapi import GraphQLRouter

from app.api.schema import schema

from app.api.context import Context, get_context


graphql_app = GraphQLRouter[Context, None](schema, context_getter=get_context)


app = FastAPI()
app.include_router(graphql_app, prefix="/graphql")


if __name__ == "__main__":
    import uvicorn

    uvicorn.run("main:app", reload=True)
