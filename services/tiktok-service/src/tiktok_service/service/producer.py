from kafka import KafkaProducer, producer
from tiktok_service.model.message import KafkaMessage


def serialize_msg(msg: KafkaMessage) -> bytes:
    return msg.model_dump_json().encode("utf-8")


def connect_kafka(kafka_url) -> KafkaProducer:
    producer = KafkaProducer(bootstrap_servers=kafka_url)
    return producer


def send_message(producer: KafkaProducer, msg_payload: KafkaMessage):
    producer.send("tiktok-comments", value=serialize_msg(msg_payload))
