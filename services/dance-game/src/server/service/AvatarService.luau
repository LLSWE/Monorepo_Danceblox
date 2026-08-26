local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local Avatar = {}

function Avatar.create(userId: number,userName: string)
	local ok, description = pcall(function()
		return Players:GetHumanoidDescriptionFromUserIdAsync(userId)
	end)

	if not ok then
		warn("Não consegui obter avatar:", userId, description)
		return nil
	end

	local okModel, model = pcall(function()
		return Players:CreateHumanoidModelFromDescriptionAsync(
			description,
			Enum.HumanoidRigType.R15
		)
	end)

	if not okModel then
		warn("Não consegui criar avatar:", userId, model)
		return nil
	end

	model.Name = tostring(userName)
	model.Parent = Workspace

	return model
end


return Avatar
