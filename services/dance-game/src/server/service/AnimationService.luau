local Dance= {}

function Dance.play(humanoid: Humanoid)
	local animator = humanoid:FindFirstChildOfClass("Animator")

	if not animator then
		animator = Instance.new("Animator")
		animator.Parent = humanoid
	end

	local animation = Instance.new("Animation")
  animation.AnimationId = "rbxassetid://131086670591743"

	local track = animator:LoadAnimation(animation)
	track.Looped = true
	track:Play()

	return track
end

return Dance
