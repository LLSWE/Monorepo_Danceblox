local CollectionService = game:GetService("CollectionService")
local Workspace = game:GetService("Workspace")

local Camera = {}

local AVATAR_TAG = "DanceBloxAvatar"

local function follow(avatar: Model)
	if not avatar or not avatar.Parent then
		return
	end

	local humanoid = avatar:FindFirstChildOfClass("Humanoid")

	if not humanoid then
		warn("Avatar não possui Humanoid:", avatar.Name)
		return
	end

	local camera = Workspace.CurrentCamera

	if not camera then
		return
	end

	camera.CameraType = Enum.CameraType.Custom
	camera.CameraSubject = humanoid

	print("Camera seguindo:", avatar.Name)
end

function Camera.init()
	-- Caso já existam avatares quando o client iniciar
	for _, avatar in CollectionService:GetTagged(AVATAR_TAG) do
		follow(avatar)
	end

	-- Qualquer avatar novo
	CollectionService:GetInstanceAddedSignal(AVATAR_TAG):Connect(function(avatar)
		follow(avatar)
	end)
end

return Camera
