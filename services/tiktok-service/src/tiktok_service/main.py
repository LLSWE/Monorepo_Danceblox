from contextlib import asynccontextmanager

from fastapi import FastAPI
from tiktok_service.config import Settings
from tiktok_service.infra.http import run_server


def main():
    settings = Settings()  # type: ignore[call-arg]

    run_server(settings)


if __name__ == "__main__":
    main()
