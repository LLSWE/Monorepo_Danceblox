from collections import deque
from threading import Thread
from kafka import KafkaConsumer
from roblox_service.model.message import KafkaMessage
from roblox_service.service.consumer import extract_msg, pop_events
import uvicorn
from fastapi import FastAPI
from roblox_service.config import Settings


def run_server(
    settings: Settings, kafka: KafkaConsumer, event_queue: deque[KafkaMessage]
):
    app = FastAPI()

    consumer_thread = Thread(target=extract_msg, args=(kafka, event_queue))

    consumer_thread.start()

    @app.get("/")
    def health():
        return "Hello World\n"

    @app.get("/events")
    def get_messages():
        return pop_events(event_queue=event_queue)

    uvicorn.run(app, host="0.0.0.0", port=settings.api_port)
