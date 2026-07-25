local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

local SPEED = 60

local flying = false
local connection

local keys = {
	W = false,
	A = false,
	S = false,
	D = false,
	Space = false,
	Ctrl = false,
}

local attachment
local linearVelocity
local alignOrientation

local function getCharacter()
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local root = character:WaitForChild("HumanoidRootPart")
	return character, humanoid, root
end

local function startFlying()
	if flying then return end
	flying = true

	local character, humanoid, root = getCharacter()

	attachment = Instance.new("Attachment")
	attachment.Parent = root

	linearVelocity = Instance.new("LinearVelocity")
	linearVelocity.Attachment0 = attachment
	linearVelocity.RelativeTo = Enum.ActuatorRelativeTo.World
	linearVelocity.MaxForce = math.huge
	linearVelocity.VectorVelocity = Vector3.zero
	linearVelocity.Parent = root

	alignOrientation = Instance.new("AlignOrientation")
	alignOrientation.Attachment0 = attachment
	alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
	alignOrientation.Responsiveness = 25
	alignOrientation.RigidityEnabled = false
	alignOrientation.Parent = root

	humanoid.PlatformStand = false

	connection = RunService.RenderStepped:Connect(function()
		if not root.Parent then
			return
		end

		local camera = workspace.CurrentCamera

		local forward = camera.CFrame.LookVector
		local right = camera.CFrame.RightVector

		local move = Vector3.zero

		if keys.W then
			move += forward
		end
		if keys.S then
			move -= forward
		end
		if keys.D then
			move += right
		end
		if keys.A then
			move -= right
		end
		if keys.Space then
			move += Vector3.yAxis
		end
		if keys.Ctrl then
			move -= Vector3.yAxis
		end

		if move.Magnitude > 0 then
			move = move.Unit * SPEED
		end

		linearVelocity.VectorVelocity = move
		alignOrientation.CFrame = CFrame.lookAt(root.Position, root.Position + camera.CFrame.LookVector)
	end)
end

local function stopFlying()
	if not flying then return end
	flying = false

	if connection then
		connection:Disconnect()
		connection = nil
	end

	if attachment then
		attachment:Destroy()
		attachment = nil
	end

	if linearVelocity then
		linearVelocity:Destroy()
		linearVelocity = nil
	end

	if alignOrientation then
		alignOrientation:Destroy()
		alignOrientation = nil
	end

	local character = player.Character
	if character then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			humanoid.PlatformStand = false
		end
	end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.W then keys.W = true end
	if input.KeyCode == Enum.KeyCode.A then keys.A = true end
	if input.KeyCode == Enum.KeyCode.S then keys.S = true end
	if input.KeyCode == Enum.KeyCode.D then keys.D = true end
	if input.KeyCode == Enum.KeyCode.Space then keys.Space = true end
	if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
		keys.Ctrl = true
	end

	if input.KeyCode == Enum.KeyCode.F then
		if flying then
			stopFlying()
		else
			startFlying()
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W then keys.W = false end
	if input.KeyCode == Enum.KeyCode.A then keys.A = false end
	if input.KeyCode == Enum.KeyCode.S then keys.S = false end
	if input.KeyCode == Enum.KeyCode.D then keys.D = false end
	if input.KeyCode == Enum.KeyCode.Space then keys.Space = false end
	if input.KeyCode == Enum.KeyCode.LeftControl or input.KeyCode == Enum.KeyCode.RightControl then
		keys.Ctrl = false
	end
end)

player.CharacterAdded:Connect(function()
	if flying then
		stopFlying()
	end
end)
