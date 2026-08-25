local HttpService = game:GetService("HttpService")

local Avatar = require(script.Parent.services.AvatarService)
local Dance = require(script.Parent.services.AnimationService)

print("EVENTO DEVERIA RODAR AGORA ...")

while true do
	local ok, response = pcall(function()
		return HttpService:GetAsync(
			"http://10.0.2.2:7102/events"
		)
	end)

	if ok then
		local events = HttpService:JSONDecode(response)

		for _, event in events do
			print("TikTok:", event.user_id)
			print("Roblox UserId:", event.user_nickname)

			local userId = tonumber(event.user_nickname)

			if not userId then
				warn("UserId inválido:", event.user_nickname)
				continue
			end

			local avatar = Avatar.create(userId)

			if not avatar then
				continue
			end

			local humanoid = avatar:FindFirstChildOfClass("Humanoid")

			if not humanoid then
				warn("Avatar não possui Humanoid:", userId)
				avatar:Destroy()
				continue
			end

			Dance.play(humanoid)
		end
	else
		warn("Erro buscando eventos:", response)
	end

	task.wait(1)
end
