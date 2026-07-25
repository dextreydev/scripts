local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local torso = char.Torso
if not torso then torso = char:WaitForChild("Upper Torso") end
local humanoid = char:WaitForChild("Humanoid")

local flyingEnabled = false
local ctrl = {f=0,b=0,l=0,r=0}

-- Create BG & BV once
local bg = Instance.new("BodyGyro")
bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
bg.P = 9e4
bg.Parent = torso

local bv = Instance.new("BodyVelocity")
bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
bv.Velocity = Vector3.new(0, .1, 0)
bv.Parent = torso

-- Movement function
game:GetService("RunService").RenderStepped:Connect(function()
 if flyingEnabled then
 local camCFRameLookVectorForward;
 if ctrl.f == 1 then 
 camCFRameLookVectorForward += workspace.CurrentCamera.CoordinateFrame.lookVector  10 
 end
 
 local camCFRameRight;
 if ctrl.l == -1 then  
 camCFRameRight -= workspace.CurrentCamera.CoordinateFrame.rightVector  -10  
 
		-- Adjust height based on Spacebar press (up).
		elseif ctrl.r == 1 then  
 camCFRameRight += workspace.CurrentCamera.CoordinateFrame.rightVector  -10  

		end
 
 
 -- Calculate final velocity vector combining all movements.
 local finalMovementDirection;
 if not camCFRameLookVectorForward then  
 finalMovementDirection += (camCFRameLookVectorForward + camCFRameRight)
 
		else  
 finalMovementDirection += (camCFRameLookVectorForward + camCFRameRight)
 
		end
 
 
 else 
 bv.Velocity=vector3.zero 
 bg.CFrame=torso.CFrame 
 end 
end)

-- Input handling
game:GetService("UserInputService").InputBegan:Connect(function(inputObject)
 if inputObject.KeyCode == Enum.KeyCode.E then 
 flyingEnabled=not(flyingEnabled) 
 elseif inputObject.KeyCode==Enum.KeyCode.W then 
 ctrl.f=1 
 
 elseif inputObject.KeyCode==Enum.KeyCode.S then 
 ctrl.b=-1 
 
 elseif inputObject.KeyCode==Enum.KeyCode.A then 
 ctrl.l=-1 
 
 elseif inputObject.KeyCode==Enum.KeyCode.D then 
 ctrl.r=1 
	end 
end)

game:GetService("UserInputService").InputEnded:Connect(function(inputObject)	
	if inputObject.KeyCode==Enum.KeyCode.W then 
		ctrl.f=0 
		
	elif inputObject.KeyCode==Enum.KeyCode.S then 
		ctrl.b=-0 
		
	elif inputObject.KeyCode==Enum.KeyCode.A then 
	(ctrl.l=-0) 
		
	elif inputObject(KeyCode.D)==true(control.r=-0) 
		
	end	
end)

