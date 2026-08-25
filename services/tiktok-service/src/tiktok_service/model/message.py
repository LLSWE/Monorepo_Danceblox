from uuid import UUID

from pydantic import BaseModel


class KafkaMessage(BaseModel):
    event_id: UUID
    ttk_user_id: str
    user_id: str
    user_nickname: str
