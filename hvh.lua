local PlayerMode = false

local plr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera

local Client = getsenv(game.Players.LocalPlayer.PlayerGui:WaitForChild("Client"))


function notBehindWall(target)
	local ray = Ray.new(plr.Character.Head.Position, (target.Position - plr.Character.Head.Position).Unit * 300)
	local part, position = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(ray, {plr.Character}, false, true)
	if part then
		local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
		if not humanoid then
			humanoid = part.Parent.Parent:FindFirstChildOfClass("Humanoid")
		end
		if humanoid and target and humanoid.Parent == target.Parent then
			local pos, visible = camera:WorldToScreenPoint(target.Position)
			if visible then
			   return true
			end
			--return true
		end
	end
end

function findClosestNotObstructed()
	local closest = 999999
	local obj = nil
	for _,i in pairs(game.Workspace:GetChildren()) do
		if PlayerMode then
			
		else
			if i:FindFirstChild("Humanoid") and i.Humanoid.Health > 0 and i:FindFirstChild("HumanoidRootPart") then
				local char = i
				if (i.HumanoidRootPart.Position-plr.Character.PrimaryPart.Position).Magnitude < closest then
					if notBehindWall(i.HumanoidRootPart) then
						closest = (i.HumanoidRootPart.Position-plr.Character.PrimaryPart.Position).Magnitude
						obj = i	
					end
				end
			end
		end
	end
	return obj
end

game["Run Service"].RenderStepped:Connect(function()
	local Closest = findClosestNotObstructed()
	if Closest then
		workspace.Camera.CFrame = CFrame.new(workspace.Camera.CFrame.Position,Closest.Head.Position)
                Client.firebullet()
	end
end)
