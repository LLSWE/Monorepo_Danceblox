from collections import deque

from httpx import AsyncClient
from roblox_service.config import Settings
from roblox_service.infra.http import run_server
from roblox_service.model.message import KafkaMessage
from roblox_service.service.consumer import connect_kafka


def main():
    settings = Settings()  # type: ignore[call-arg]
    kafka = connect_kafka(settings.kafka_url)
    event_queue: deque[KafkaMessage] = deque()
    client = AsyncClient()
    run_server(settings=settings, client=client, kafka=kafka, event_queue=event_queue)


if __name__ == "__main__":
    main()
