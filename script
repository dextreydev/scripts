local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

local Rayfield = loadstring(
 game:HttpGet("https://sirius.menu/rayfield")
)()

--// Helpers

local function notify(title, content)
 Rayfield:Notify({
 Title = title,
 Content = content,
 Duration = 3,
 Image = nil,
 Actions = {
 Ignore = {
 Name = "Okay",
 Callback = function()
 -- Notification dismissed
 end,
 },
 },
 })
end

local function runRemoteScript(url)
 loadstring(game:HttpGet(url))()
end

local function getCharacter()
 return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getRootPart()
 return getCharacter():WaitForChild("HumanoidRootPart")
end

local function getHumanoid()
 return getCharacter():WaitForChild("Humanoid")
end

local function findArkenstone()
 return Workspace:FindFirstChild("The Arkenstone")
end

local function teleportToArkenstoneAndBack()
 local arkenstone = findArkenstone()

 if not arkenstone then
 return false
 end

 local handle = arkenstone:FindFirstChild("Handle")

 if not handle then
 return false
 end

 local rootPart = getRootPart()
 local previousCFrame = rootPart.CFrame + Vector3.new(0,1,0)

 rootPart.CFrame = handle.CFrame
 task.wait(0.05)
 rootPart.CFrame = previousCFrame

 return true
end

--// Window

local Window = Rayfield:CreateWindow({
 Name = "dextreydev script",
 LoadingTitle = "wait a sec",
 LoadingSubtitle = "by dextreydev",

 ConfigurationSaving = {
 Enabled = false,
 FolderName = nil,
 FileName = "Big Hub",
 },

 Discord = {
 Enabled = false,
 Invite = "noinvitelink",
 RememberJoins = true,
 },

 KeySystem = false,

 KeySettings = {
 Title = "Untitled",
 Subtitle = "Key System",
 Note = "No method of obtaining the key is provided",
 FileName = "Key",
 SaveKey = true,
 GrabKeyFromSite = false,
 Key = { "Hello" },
 },
})

notify("yay!!", "the gui loaded!")

--// Main tab

local MainTab = Window:CreateTab("Player", nil)
MainTab:CreateSection("Player")

MainTab:CreateToggle({
 Name = "Click TP",
 CurrentValue = false,
 Flag = "ClickTPToggle",
 toggleTP = false,

 Callback = function(_value)
 toggleTP = not toggleTP
 runRemoteScript(
 "https://raw.githubusercontent.com/baconhair101/scripts/main/wearedevsnet%20edited%20clicktp"
 )

 if toggleTP then notify("Click TP", "Enabled (CTRL+Click)") else notify("Click TP", "Disabled") end
 end,
})

MainTab:CreateToggle({
 Name = "Infinite Jump",
 CurrentValue = false,
 Flag = "InfJumpToggle",
 toggleJump = false,

 Callback = function(_value)
 toggleJump = not toggleJump
 runRemoteScript(
 "https://raw.githubusercontent.com/baconhair101/scripts/main/wearedevsnet%20edited%20inf%20jump"
 )
 if toggleJump then notify("Infinite Jump", "Enabled") else  notify("Infinite Jump", "Disabled") end
 end,
})

local NoclipConnection
local OriginalStates = {}

MainTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "NoclipToggle",

    Callback = function(enabled)
        if enabled then
            notify("Noclip", "Enabled")
            OriginalStates = {}

            NoclipConnection = RunService.Stepped:Connect(function()
                local character = game.Players.LocalPlayer.Character
                if not character then return end

                for _, part in ipairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        if OriginalStates[part] == nil then
                            OriginalStates[part] = part.CanCollide
                        end

                        part.CanCollide = false
                    end
                end
            end)

        else
        notify("Noclip", "Disabled")
            if NoclipConnection then
                NoclipConnection:Disconnect()
                NoclipConnection = nil
            end

            for part, state in pairs(OriginalStates) do
                if part and part.Parent then
                    part.CanCollide = state
                end
            end

            table.clear(OriginalStates)
        end
    end,
})

MainTab:CreateToggle({
	Name = "Fly",
	CurrentValue = false,
	Flag = "FlyToggle",

	Callback = (function()

		local flying = false
		local connection
		local attachment
		local linearVelocity
		local alignOrientation

		local keys = {
			W = false,
			A = false,
			S = false,
			D = false,
			Space = false,
			Ctrl = false,
		}

		local UserInputService = game:GetService("UserInputService")
		local RunService = game:GetService("RunService")
		local Players = game:GetService("Players")

		UserInputService.InputBegan:Connect(function(input, processed)
			if processed then return end

			if input.KeyCode == Enum.KeyCode.W then keys.W = true end
			if input.KeyCode == Enum.KeyCode.A then keys.A = true end
			if input.KeyCode == Enum.KeyCode.S then keys.S = true end
			if input.KeyCode == Enum.KeyCode.D then keys.D = true end
			if input.KeyCode == Enum.KeyCode.Space then keys.Space = true end
			if input.KeyCode == Enum.KeyCode.LeftControl then keys.Ctrl = true end
		end)

		UserInputService.InputEnded:Connect(function(input)

			if input.KeyCode == Enum.KeyCode.W then keys.W = false end
			if input.KeyCode == Enum.KeyCode.A then keys.A = false end
			if input.KeyCode == Enum.KeyCode.S then keys.S = false end
			if input.KeyCode == Enum.KeyCode.D then keys.D = false end
			if input.KeyCode == Enum.KeyCode.Space then keys.Space = false end
			if input.KeyCode == Enum.KeyCode.LeftControl then keys.Ctrl = false end

		end)


		return function(enabled)

			local player = Players.LocalPlayer
			local SPEED = 60


			if enabled then

				if flying then return end
				flying = true


				local character = player.Character or player.CharacterAdded:Wait()
				local root = character:WaitForChild("HumanoidRootPart")


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
				alignOrientation.Responsiveness = 50
				alignOrientation.MaxTorque = math.huge
				alignOrientation.Parent = root


				connection = RunService.RenderStepped:Connect(function()

					if not flying or not root.Parent then
						return
					end


					local camera = workspace.CurrentCamera

					local move = Vector3.zero

					if keys.W then
						move += camera.CFrame.LookVector
					end

					if keys.S then
						move -= camera.CFrame.LookVector
					end

					if keys.A then
						move -= camera.CFrame.RightVector
					end

					if keys.D then
						move += camera.CFrame.RightVector
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


					local look = Vector3.new(
						camera.CFrame.LookVector.X,
						0,
						camera.CFrame.LookVector.Z
					)


					if look.Magnitude > 0 then
						alignOrientation.CFrame = CFrame.lookAt(
							root.Position,
							root.Position + look
						)
					end

				end)


				notify("Fly", "Enabled")


			else

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


				notify("Fly", "Disabled")

			end
		end

	end)(),
})

MainTab:CreateSlider({
 Name = "Walk Speed",
 Range = { 16, 500 },
 Increment = 1,
 Suffix = "",
 CurrentValue = 16,
 Flag = "WalkSpeedSlider",

 Callback = function(value)
 getHumanoid().WalkSpeed = value
 end,
})

MainTab:CreateSlider({
 Name = "Jump Power",
 Range = { 50, 500 },
 Increment = 1,
 Suffix = "",
 CurrentValue = 50,
 Flag = "JumpPowerSlider",

 Callback = function(value)
 getHumanoid().UseJumpPower = true
 getHumanoid().JumpPower = value
 end,
})

MainTab:CreateButton({
 Name = "Infinite Yield",
 Flag = "InfiniteYield",

 Callback = function(_value)
 runRemoteScript(
 "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"
 )

 notify("Infinite Yield", "Loaded")
 end,
})

MainTab:CreateButton({
 Name = "Spy chat",
 Flag = "SpyChat",

 Callback = function(_value)
  notify("Spy Chat", "Loaded")
 runRemoteScript(
 "https://raw.githubusercontent.com/dehoisted/Chat-Spy/refs/heads/main/source/main.lua"
 )

 end,
})

--// The Chosen One

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera

local TCOTab = Window:CreateTab("The Chosen One", nil)
TCOTab:CreateSection("The Chosen One")

--// Remove previously executed copies

local environment = getgenv()

if environment.DextreyEnlightenESP
 and environment.DextreyEnlightenESP.Cleanup then
 pcall(environment.DextreyEnlightenESP.Cleanup)
end

local SeenEnlightens = {}

local ESPState = {
 Enabled = false,
 Teleporting = false,
 Tracked = {},
 Connections = {},
 Overlay = nil,
}

environment.DextreyEnlightenESP = ESPState

--// Helpers

local function notifyESP(message)
 Rayfield:Notify({
 Title = "Enlighten ESP",
 Content = message,
 Duration = 3,
 Image = nil,
 Actions = {
 Ignore = {
 Name = "Okay",
 Callback = function()
 end,
 },
 },
 })
end

local function getRootPart()
 local character = LocalPlayer.Character
 or LocalPlayer.CharacterAdded:Wait()

 return character:WaitForChild("HumanoidRootPart")
end

local function getGuiParent()
 local success, hiddenGui = pcall(function()
 if gethui then
 return gethui()
 end
 end)

 if success and hiddenGui then
 return hiddenGui
 end

 return PlayerGui
end

local function removeOldObjects()
 for _, object in ipairs(Workspace:GetDescendants()) do
 if object.Name == "DextreyEnlightenHighlight"
 or object.Name == "EnlightenESP"
 or object.Name == "EnlightenClickDetector" then
 object:Destroy()
 end
 end

 local oldOverlay = getGuiParent():FindFirstChild(
 "DextreyEnlightenOverlay"
 )

 if oldOverlay then
 oldOverlay:Destroy()
 end
end

local function createOverlay()
 if ESPState.Overlay and ESPState.Overlay.Parent then
 return ESPState.Overlay
 end

 local overlay = Instance.new("ScreenGui")
 overlay.Name = "DextreyEnlightenOverlay"
 overlay.IgnoreGuiInset = true
 overlay.ResetOnSpawn = false
 overlay.DisplayOrder = 2147483647
 overlay.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

 local guiParent = getGuiParent()

 pcall(function()
 if syn and syn.protect_gui then
 syn.protect_gui(overlay)
 end
 end)

 overlay.Parent = guiParent
 ESPState.Overlay = overlay

 return overlay
end

local function removeEnlighten(enlighten)
 local data = ESPState.Tracked[enlighten]

 if not data then
 return
 end

 if data.ButtonConnection then
 data.ButtonConnection:Disconnect()
 end

 if data.Highlight then
 data.Highlight:Destroy()
 end

 if data.Button then
 data.Button:Destroy()
 end

 ESPState.Tracked[enlighten] = nil
 SeenEnlightens[enlighten] = nil
end

local function clearESP()
 local enlightens = {}

 for enlighten in pairs(ESPState.Tracked) do
 table.insert(enlightens, enlighten)
 end

 for _, enlighten in ipairs(enlightens) do
 removeEnlighten(enlighten)
 end

 if ESPState.Overlay then
 ESPState.Overlay:Destroy()
 ESPState.Overlay = nil
 end

 -- Catch any leftovers from older script executions.
 for _, object in ipairs(Workspace:GetDescendants()) do
 if object.Name == "DextreyEnlightenHighlight"
 or object.Name == "EnlightenESP" then
 object:Destroy()
 end
 end
 table.clear(SeenEnlightens)
end

local function teleportToEnlighten(handle)
 if ESPState.Teleporting
 or not ESPState.Enabled
 or not handle:IsDescendantOf(Workspace) then
 return
 end

 ESPState.Teleporting = true

 local success = pcall(function()
 local rootPart = getRootPart()
 local previousCFrame = rootPart.CFrame

 rootPart.CFrame = handle.CFrame
 task.wait(0.05)

 if rootPart.Parent then
 rootPart.CFrame = previousCFrame
 end
 end)

 ESPState.Teleporting = false

 if not success then
 notifyESP("Teleport failed")
 end
end

local function addEnlighten(enlighten)
 if ESPState.Tracked[enlighten] then
 return
 end

 local handle = enlighten:FindFirstChild("Handle", true)

 if not handle or not handle:IsA("BasePart") then
 return
 end

 --// Through-wall highlight

 local highlight = Instance.new("Highlight")
 highlight.Name = "DextreyEnlightenHighlight"
 highlight.Adornee = enlighten
 highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
 highlight.FillColor = Color3.fromRGB(40, 220, 90)
 highlight.FillTransparency = 0.6
 highlight.OutlineColor = Color3.fromRGB(100, 255, 140)
 highlight.OutlineTransparency = 0
 highlight.Parent = enlighten

 --// Screen-space button
 -- Unlike ClickDetector, walls cannot intercept this button.

 local button = Instance.new("TextButton")
 button.Name = "EnlightenMarker"
 button.AnchorPoint = Vector2.new(0.5, 0.5)
 button.Size = UDim2.fromOffset(112, 30)
 button.BackgroundColor3 = Color3.fromRGB(18, 25, 21)
 button.BackgroundTransparency = 0.08
 button.BorderSizePixel = 0
 button.Text = "ENLIGHTEN"
 button.TextColor3 = Color3.fromRGB(125, 255, 155)
 button.TextSize = 12
 button.Font = Enum.Font.GothamBold
 button.AutoButtonColor = true
 button.Active = true
 button.Selectable = true
 button.Visible = false
 button.ZIndex = 100
 button.Parent = createOverlay()

 local corner = Instance.new("UICorner")
 corner.CornerRadius = UDim.new(0, 7)
 corner.Parent = button

 local stroke = Instance.new("UIStroke")
 stroke.Color = Color3.fromRGB(55, 190, 90)
 stroke.Transparency = 0.15
 stroke.Thickness = 1
 stroke.Parent = button

 local data = {
 Handle = handle,
 Highlight = highlight,
 Button = button,
 ButtonConnection = nil,
 }

 data.ButtonConnection = button.Activated:Connect(function()
 teleportToEnlighten(handle)
 end)

 ESPState.Tracked[enlighten] = data
end

local function scanForEnlightens()
 if not ESPState.Enabled then
 return
 end

 local staleEnlightens = {}

 for enlighten, data in pairs(ESPState.Tracked) do
 if not enlighten:IsDescendantOf(Workspace)
 or enlighten.Name ~= "The Arkenstone"
 or not data.Handle:IsDescendantOf(Workspace) then
 table.insert(staleEnlightens, enlighten)
 end
 end

 for _, enlighten in ipairs(staleEnlightens) do
 removeEnlighten(enlighten)
 end

 for _, object in ipairs(Workspace:GetDescendants()) do
	if object.Name == "The Arkenstone"
		and not object.Parent:FindFirstChild("Humanoid") then

		if not ESPState.Tracked[object] then
			notifyESP("A new Arkenstone has spawned!")
		end

		addEnlighten(object)
		SeenEnlightens[object] = true
	end
end
end

local function updateMarkerPositions()
 if not ESPState.Enabled then
 return
 end

 Camera = Workspace.CurrentCamera

 if not Camera then
 return
 end

 for enlighten, data in pairs(ESPState.Tracked) do
 local handle = data.Handle
 local button = data.Button

 if handle:IsDescendantOf(Workspace) and button.Parent then
 -- Position the button three studs above the Enlighten.
 local worldPosition = handle.Position + Vector3.new(0, 3, 0)
 local screenPosition = Camera:WorldToViewportPoint(worldPosition)

 -- Only hide it when it is behind the camera.
 -- Walls do not affect its visibility or clickability.
 local inFrontOfCamera = screenPosition.Z > 0

 button.Visible = inFrontOfCamera

 if inFrontOfCamera then
 button.Position = UDim2.fromOffset(
 screenPosition.X,
 screenPosition.Y
 )

 local distance = (
 Camera.CFrame.Position - handle.Position
 ).Magnitude

 button.Text = string.format(
 "ENLIGHTEN  [%dm]",
 math.floor(distance)
 )
 end
 else
 removeEnlighten(enlighten)
 end
 end
end

--// Toggle

TCOTab:CreateToggle({
 Name = "Enlighten ESP",
 CurrentValue = false,
 Flag = "EnlightenESPToggle",

 Callback = function(value)
 ESPState.Enabled = value

 if value then
 removeOldObjects()
 createOverlay()
 scanForEnlightens()
 notifyESP("Enabled")
 else
 clearESP()
 notifyESP("Disabled")
 end
 end,
})

--// Update markers every frame

table.insert(
 ESPState.Connections,
 RunService.RenderStepped:Connect(updateMarkerPositions)
)

--// Scan periodically for newly spawned Enlightens

local scanElapsed = 0

table.insert(
 ESPState.Connections,
 RunService.Heartbeat:Connect(function(deltaTime)
 if not ESPState.Enabled then
 return
 end

 scanElapsed += deltaTime

 if scanElapsed >= 1 then
 scanElapsed = 0
 scanForEnlightens()
 end
 end)
)

--// Cleanup when script is executed again

ESPState.Cleanup = function()
 ESPState.Enabled = false
 clearESP()

 for _, connection in ipairs(ESPState.Connections) do
 connection:Disconnect()
 end

 table.clear(ESPState.Connections)
end

--// Arkenstone Holders System

local environment = getgenv()

-- Cleanup old version if script was executed again
if environment.ArkenstoneTrackerCleanup then
	pcall(environment.ArkenstoneTrackerCleanup)
end


local ArkenstoneConnections = {}
local ArkenstoneOwners = {}
local KnownHolders = {}


environment.ArkenstoneTrackerCleanup = function()

	for _, connection in ipairs(ArkenstoneConnections) do
		pcall(function()
			connection:Disconnect()
		end)
	end

	table.clear(ArkenstoneConnections)

end



local ArkenstoneSection = TCOTab:CreateSection("Arkenstone Holders")


local ArkenstoneDropdown = TCOTab:CreateDropdown({

	Name = "Current Holders",

	Options = {},
	CurrentOption = {},

	MultipleOptions = false,

	Flag = "ArkenstoneHoldersList",

	Callback = function()
		-- Display only
	end,

})



local function updateHolderList()

    local list = {}

    for playerName in pairs(ArkenstoneOwners) do
        table.insert(list, playerName)
    end

    table.sort(list)

    ArkenstoneDropdown:Refresh(list, {})

end




local function playerHasArkenstone(player)

	local backpack = player:FindFirstChild("Backpack")

	if backpack and backpack:FindFirstChild("The Arkenstone") then
		return true
	end


	local character = player.Character

	if character and character:FindFirstChild("The Arkenstone") then
		return true
	end


	return false

end




local function checkPlayer(player)

	local function update()

		local hasArkenstone = playerHasArkenstone(player)


		if hasArkenstone then


			if not KnownHolders[player] then

				KnownHolders[player] = true


				Rayfield:Notify({

					Title = "The Arkenstone",

					Content = player.Name .. " has received The Arkenstone",

					Duration = 5,

				})

			end


			ArkenstoneOwners[player.Name] = true


		else


			if KnownHolders[player] then

				KnownHolders[player] = nil
				ArkenstoneOwners[player.Name] = nil

			end

		end


		updateHolderList()

	end



	local backpack = player:WaitForChild("Backpack")


	table.insert(
		ArkenstoneConnections,
		backpack.ChildAdded:Connect(update)
	)


	table.insert(
		ArkenstoneConnections,
		backpack.ChildRemoved:Connect(update)
	)



	local function characterAdded(character)


		table.insert(
			ArkenstoneConnections,
			character.ChildAdded:Connect(update)
		)


		table.insert(
			ArkenstoneConnections,
			character.ChildRemoved:Connect(update)
		)


		task.wait(0.2)

		update()

	end



	table.insert(
		ArkenstoneConnections,
		player.CharacterAdded:Connect(characterAdded)
	)


	if player.Character then
		characterAdded(player.Character)
	end


	update()

end





for _, player in ipairs(Players:GetPlayers()) do
	checkPlayer(player)
end



table.insert(
	ArkenstoneConnections,
	Players.PlayerAdded:Connect(checkPlayer)
)



table.insert(
	ArkenstoneConnections,
	Players.PlayerRemoving:Connect(function(player)

		KnownHolders[player] = nil
		ArkenstoneOwners[player.Name] = nil

		updateHolderList()

	end)
)


updateHolderList()q
