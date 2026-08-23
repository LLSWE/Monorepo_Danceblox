local Workspace = game:GetService("Workspace")

print("Creating DanceBlox world...")

local floor = Instance.new("Part")

floor.Name = "DanceFloor"
floor.Size = Vector3.new(200, 1, 200)
floor.Position = Vector3.new(0, 0, 0)

floor.Anchored = true
floor.Parent = Workspace

local spawn = Instance.new("SpawnLocation")

spawn.Name = "PlayerSpawn"
spawn.Size = Vector3.new(6, 1, 6)
spawn.Position = Vector3.new(0, 3, 0)

spawn.Anchored = true
spawn.Parent = Workspace
