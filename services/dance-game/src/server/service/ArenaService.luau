local CollectionService = game:GetService("CollectionService")

local Arena = {}

local AVATAR_TAG = "DanceBloxAvatar"
local MAX_AVATARS = 30

local avatars = {}

local function removeFromList(avatar)
	for i, registered in ipairs(avatars) do
		if registered == avatar then
			table.remove(avatars, i)
			return
		end
	end
end

local function destroyAvatar(avatar)
	if avatar and avatar.Parent then
		avatar:Destroy()
	end

	removeFromList(avatar)
end

local function cleanup()
	while #avatars > MAX_AVATARS do
		local oldest = table.remove(avatars, 1)

		if oldest and oldest.Parent then
			oldest:Destroy()
		end
	end
end

function Arena.register(avatar: Model)
	CollectionService:AddTag(avatar, AVATAR_TAG)

	table.insert(avatars, avatar)

	avatar.Destroying:Connect(function()
		removeFromList(avatar)
	end)

	cleanup()
end

function Arena.count()
	return #avatars
end

function Arena.clear()
	for _, avatar in ipairs(avatars) do
		if avatar.Parent then
			avatar:Destroy()
		end
	end

	table.clear(avatars)
end

return Arena
