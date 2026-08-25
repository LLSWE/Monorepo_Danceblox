from collections import deque
import json
from httpx import AsyncClient
from kafka import KafkaConsumer
from roblox_service.model.message import KafkaMessage
from roblox_service.service.username import get_user_by_name


def push_events(event: KafkaMessage, event_queue: deque[KafkaMessage]):
    event_queue.append(event)


def pop_events(event_queue: deque[KafkaMessage], limit: int = 20) -> list[KafkaMessage]:
    events = []

    for _ in range(min(limit, len(event_queue))):
        events.append(event_queue.popleft())

    return events


def deserialize_msg(bytes_msg: bytes) -> KafkaMessage:
    msg = json.loads(bytes_msg.decode("utf-8"))
    return KafkaMessage(**msg)


def connect_kafka(kafka_url: str) -> KafkaConsumer:
    producer = KafkaConsumer("tiktok-comments", bootstrap_servers=kafka_url)
    return producer


async def extract_msg(
    client: AsyncClient, kafka: KafkaConsumer, event_queue: deque[KafkaMessage]
):
    for msg in kafka:
        kafka_json = deserialize_msg(msg.value)
        user_roblox_id = await get_user_by_name(
            client=client, username=kafka_json.user_nickname
        )
        if user_roblox_id is None:
            continue

        tranformed_msg = KafkaMessage(
            event_id=kafka_json.event_id,
            ttk_user_id=kafka_json.ttk_user_id,
            user_id=str(user_roblox_id),
            user_nickname=kafka_json.user_nickname,
        )

        push_events(event=tranformed_msg, event_queue=event_queue)
