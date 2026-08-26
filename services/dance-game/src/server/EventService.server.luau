local HttpService = game:GetService("HttpService")

local Avatar = require(script.Parent.service.AvatarService)
local Dance = require(script.Parent.service.AnimationService)

print("EVENTO DEVERIA RODAR AGORA ...")

while true do
	print("CHAMANDDO HTTP ....")
	local ok, response = pcall(function()
    print("ANTES DO GET")
		local result = HttpService:GetAsync(
			"http://10.0.2.2:7102/events"
		)
    print("DEPOIS DO GET")
    return result
	end)

  print("PCALL TERMINOU")

	if ok then
    print("RESPONSE: ", response)
		local events = HttpService:JSONDecode(response)

		for _, event in events do
			print("TikTok:", event.ttk_user_id)
			print("Roblox UserId:", event.user_nickname)

			local userId = tonumber(event.user_id)
			local userName = tostring(event.user_nickname)

			if not userId then
				warn("UserId inválido:", event.user_id)
				continue
			end

			local avatar = Avatar.create(userId,userName)

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
		print(response)
	end

	task.wait(3)
end
