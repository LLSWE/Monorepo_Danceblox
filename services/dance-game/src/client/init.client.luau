local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Camera = require(
	ReplicatedStorage.Shared.CameraService
)

print("CAMERA INICIADA")

Camera.init()