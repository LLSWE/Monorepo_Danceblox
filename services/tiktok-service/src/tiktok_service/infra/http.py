import uvicorn
from fastapi import FastAPI
from tiktok_service.config import Settings


def run_server(settings: Settings):
    app = FastAPI()

    @app.get("/")
    def hello_handler():
        return {"Hello": "World"}

    uvicorn.run(app, port=settings.api_port)
