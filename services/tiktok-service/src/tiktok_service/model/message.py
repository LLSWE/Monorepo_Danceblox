from pydantic import BaseModel


class KafkaMessage(BaseModel):
    user_id: str
    user_nickname: str
