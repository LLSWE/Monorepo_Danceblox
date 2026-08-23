from collections import deque
import json
from kafka import KafkaConsumer
from roblox_service.model.message import KafkaMessage


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


def extract_msg(kafka: KafkaConsumer, event_queue: deque[KafkaMessage]):
    for msg in kafka:
        push_events(event=deserialize_msg(msg.value), event_queue=event_queue)
