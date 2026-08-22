import asyncio
import traceback

from TikTokLive import TikTokLiveClient
from TikTokLive.events import CommentEvent
from tiktok_service.config import settings


async def create_ttk_client(user_id: str):
    client = TikTokLiveClient(unique_id=user_id)

    @client.on(CommentEvent)
    async def on_comment(event: CommentEvent):
        if event.user is None:
            return

        user = event.user.unique_id

        if user is None:
            return

        print(f"{user} commented {event.comment}")

    await client.connect()


async def worker():
    try:
        print("Starting TikTok client...")
        await create_ttk_client(settings.tiktok_user_id)
        print("Ending TikTok client...")
    except Exception:
        traceback.print_exc()
        raise


def main():
    asyncio.run(worker())
