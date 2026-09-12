local CollectionService = game:GetService("CollectionService")

local Arena = {}


local AVATAR_TAG = "DanceBloxAvatar"
local MAX_AVATARS = 30

local MIN_DISTANCE = 8

local MIN_X = -80
local MAX_X = 80

local MIN_Z = -80
local MAX_Z = 80


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

local function isPositionAvailable(position: Vector3)
	for _, avatar in ipairs(avatars) do
		if avatar.Parent then
			local avatarPosition = avatar:GetPivot().Position

			local dx = avatarPosition.X - position.X
			local dz = avatarPosition.Z - position.Z

			local distance = math.sqrt(dx * dx + dz * dz)

			if distance < MIN_DISTANCE then
				return false
			end
		end
	end

	return true
end

function Arena.getSpawnPosition()
	for _ = 1, 30 do
		local position = Vector3.new(
			math.random(MIN_X, MAX_X),
			3,
			math.random(MIN_Z, MAX_Z)
		)

		if isPositionAvailable(position) then
			return position
		end
	end

	return Vector3.new(
		math.random(MIN_X, MAX_X),
		3,
		math.random(MIN_Z, MAX_Z)
	)
end

return Arena
