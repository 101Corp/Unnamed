local RunS = game:GetService("RunService")
local plr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera

getgenv().Onetap = false

function notBehindWall(target)
    local ray = Ray.new(plr.Character.Head.Position, (target.Position - plr.Character.Head.Position).Unit * 300)
    local part, position = game:GetService("Workspace"):FindPartOnRayWithIgnoreList(ray, {plr.Character}, false, true)
    if part then
		print("p")
        local humanoid = part.Parent:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            humanoid = part.Parent.Parent:FindFirstChildOfClass("Humanoid")
        end
        if humanoid and target and humanoid.Parent == target.Parent then
			print("y")
          --  local pos, visible = camera:WorldToScreenPoint(target.Position)
            --if visible then
             --   return true
            --end
			return true
        end
    end
end

local tap = {}

RunS.RenderStepped:Connect(function()
	if game.Players.LocalPlayer.Character then
		for _,i in pairs(game.Players:GetChildren()) do
			if i.Character and i.Character.Humanoid and i.Character.Humanoid.Health > 0 and not i.Character:FindFirstChild("Forcefield") then
				local nbw = notBehindWall(i.Character.Head)
				if nbw and not table.find(table, i) and getgenv().Onetap then
					local ohInstance1 = i.Character.Head
					local ohVector32 = ohInstance1.Position
					local ohString3 = game.Players.LocalPlayer.Character.EquippedTool.Value
					local ohNumber4 = 4096
					local ohInstance5 = game.Players.LocalPlayer.Character.Gun
					local ohNil6 = nil
					local ohNil7 = nil
					local ohNumber8 = 10
					local ohNil9 = nil
					local ohBoolean10 = true
					local ohVector311 = ohVector32
					local ohNumber12 = 11913
					local ohVector313 = Vector3.new(0, 0, -1)
					game:GetService("ReplicatedStorage").Events.Hit:FireServer(ohInstance1, ohVector32, ohString3, ohNumber4, ohInstance5, ohNil6, ohNil7, ohNumber8, ohNil9, ohBoolean10, ohVector311, ohNumber12, ohVector313)
					tap[#tap+1] = i
					local nTp = #tap
					spawn(function()
						wait(0.15)
						tap[ntp] = nil
					end)
				end
			end
		end
	end
end)
