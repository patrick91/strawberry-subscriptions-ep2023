from fastapi import FastAPI
from strawberry.fastapi import GraphQLRouter
from fastapi.middleware.cors import CORSMiddleware

from app.api.schema import schema

from app.api.context import Context, get_context


graphql_app = GraphQLRouter[Context, None](schema, context_getter=get_context)


app = FastAPI()
app.include_router(graphql_app, prefix="/graphql")

origins = [
    "http://localhost",
    "http://localhost:3000",
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


if __name__ == "__main__":
    import uvicorn

    uvicorn.run("main:app", reload=True)
