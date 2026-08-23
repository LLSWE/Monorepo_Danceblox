import asyncio
import traceback
from uuid import uuid4

from TikTokLive import TikTokLiveClient
from TikTokLive.events import CommentEvent
from kafka import KafkaProducer
from tiktok_service.config import settings
from tiktok_service.model.message import KafkaMessage
from tiktok_service.service.producer import connect_kafka, send_message


async def run_ttk_msg_scanner(client: TikTokLiveClient, kafka: KafkaProducer):

    @client.on(CommentEvent)
    async def on_comment(event: CommentEvent):
        if event.user is None:
            return

        user = event.user.unique_id

        if user is None:
            return

        print(f"{user} commented {event.comment}")

        payload = KafkaMessage(
            event_id=uuid4(), user_id=user, user_nickname=event.comment
        )
        send_message(kafka, payload)

    await client.connect()


async def worker():
    try:
        print("Starting TikTok client...")

        kafka = connect_kafka(settings.kafka_url)
        client = TikTokLiveClient(unique_id=settings.tiktok_user_id)
        await run_ttk_msg_scanner(client, kafka)

        print("Ending TikTok client...")
    except Exception:
        traceback.print_exc()
        raise


def main():
    asyncio.run(worker())
