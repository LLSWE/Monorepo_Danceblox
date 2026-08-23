local HttpService = game:GetService("HttpService")

local RobloxApi = {}

function RobloxApi.getEvents()
    local response = HttpService:GetAsync(
        "http://localhost:7102/events"
    )

    return HttpService:JSONDecode(response)
end

return RobloxApi
