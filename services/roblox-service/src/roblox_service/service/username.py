import httpx


async def get_user_by_name(client: httpx.AsyncClient, username: str) -> int | None:
    trimmed = username.strip()
    response = await client.post(
        "https://users.roblox.com/v1/usernames/users",
        json={
            "usernames": [trimmed],
            "excludeBannedUsers": False,
        },
    )

    response.raise_for_status()

    data = response.json()["data"]

    if not data:
        print(f"User not found: {username}")
        return None

    return data[0]["id"]
