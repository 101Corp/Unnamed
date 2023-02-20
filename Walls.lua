--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88 
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER
]=]

getgenv().WallsOn = false
getgenv().Walls = false
getgenv().Tracers = false
getgenv().Names = false
getgenv().HPBars = false
getgenv().Icons = false

-- Instances: 5 | Scripts: 1 | Modules: 2
local G2L = {};

-- StarterGui.hax2
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Name"] = [[hax2]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

-- StarterGui.hax2.Modules
G2L["2"] = Instance.new("Folder", G2L["1"]);
G2L["2"]["Name"] = [[Modules]];

-- StarterGui.hax2.Modules.ToUDim2
G2L["3"] = Instance.new("ModuleScript", G2L["2"]);
G2L["3"]["Name"] = [[ToUDim2]];

-- StarterGui.hax2.Modules.Drawing
G2L["4"] = Instance.new("ModuleScript", G2L["2"]);
G2L["4"]["Name"] = [[Drawing]];

-- StarterGui.hax2.walls
G2L["5"] = Instance.new("LocalScript", G2L["1"]);
G2L["5"]["Name"] = [[walls]];

-- Require G2L wrapper
local G2L_REQUIRE = require;
local G2L_MODULES = {};
local function require(Module:ModuleScript)
    local ModuleState = G2L_MODULES[Module];
    if ModuleState then
        if not ModuleState.Required then
            ModuleState.Required = true;
            ModuleState.Value = ModuleState.Closure();
        end
        return ModuleState.Value;
    end;
    return G2L_REQUIRE(Module);
end

G2L_MODULES[G2L["3"]] = {
Closure = function()
    local script = G2L["3"];
local module = {}
function module.newfromVector2(vector2,sizex,sizey)
	return UDim2.new(0,vector2.X,0,vector2.Y)
end

function module.new(sx,ox,sy,oy)
    return UDim2.new(sx,ox,sy,oy)
end
return module

end;
};
G2L_MODULES[G2L["4"]] = {
Closure = function()
    local script = G2L["4"];
local Drawing = {}

local gui

function Drawing.Start()
    game["Run Service"].RenderStepped:Connect(function()
        if gui then
			for _, i in pairs(gui:GetChildren()) do
				i.BorderSizePixel = 0
                for o,val in pairs(i:GetAttributes()) do
                    if o == "Filled" then
                        if val == true then
                            i.BackgroundTransparency = 0
                        end
                        if val == false then
                            i.BackgroundTransparency = 1
                        end
                    end
					if o == "Thickness" then
                        i.UIStroke.Thickness = val
                    end
					if o == "Radius" and not i:GetAttributes()["NotCircle"] then
						i.Size = UDim2.new(0,val,0,val)
						i.UICorner.CornerRadius = UDim.new(0,val)
					end
					if i:GetAttributes()["Line"] then
						--print("Line!!!")
						local apos = i:GetAttributes()["From"]
						local bpos = i:GetAttributes()["To"]
						--print(i:GetAttributes()["From"],i:GetAttributes()["To"])
						local centerPosV2 = apos:Lerp(bpos, 0.5)
						local centerPos = UDim2.new(0, centerPosV2.X,0, centerPosV2.Y)
						local lineHeight = i:GetAttributes()["LineThickness"]
						local lineSize = UDim2.new(0, ((apos - bpos).Magnitude),0, lineHeight)
						local vertDist = apos.Y - bpos.Y
						local horizDist = apos.X - bpos.X
						local rot = math.deg(math.atan2(vertDist, horizDist))
						i.Position = centerPos
						i.Size = lineSize
						i.Rotation = rot
						i.BackgroundColor3 = i:GetAttributes()["Color"]
						i.BorderSizePixel = 0
						i.AnchorPoint = Vector2.new(0.5, 0.5)
					end
                end
            end
        end
    end)
end

function Drawing.new(typ)
    if game.Players.LocalPlayer.PlayerGui:FindFirstChild("GUI_DrawingLIB") then
        gui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("GUI_DrawingLIB")
    else
        local drawing = Instance.new("ScreenGui",game.Players.LocalPlayer.PlayerGui)
        drawing.Name = "GUI_DrawingLIB"
		gui = drawing
		drawing.IgnoreGuiInset = true
	end

	if typ == "Rectangle" then
		local frame = Instance.new("Frame",gui)
		local stroke = Instance.new("UIStroke",frame)
		stroke.Color = Color3.new(1,1,1)
		frame.Transparency = 0
		frame.Size = UDim2.new(0,180,0,70)
		frame.ZIndex = 10000000
		frame.BackgroundTransparency = 1
		frame:SetAttribute("Radius",nil)
		frame:SetAttribute("Filled",true)
		frame:SetAttribute("Thickness",1)
		frame:SetAttribute("NotCircle",true)
		return frame
	end
	if typ == "Line" then
		local frame = Instance.new("Frame",gui)
		frame.Transparency = 0
		frame.Size = UDim2.new(0,1,0,1)
		frame.ZIndex = 10000000
		frame.BackgroundTransparency = 0
		frame:SetAttribute("Line",true)
		frame:SetAttribute("From",Vector2.new(0,0))
		frame:SetAttribute("To",Vector2.new(0,0))
		frame:SetAttribute("LineThickness",1)
		frame:SetAttribute("Color",Color3.fromRGB(255, 255, 255))
		return frame
	end
	if typ == "Square" then
		local frame = Instance.new("Frame",gui)
		local stroke = Instance.new("UIStroke",frame)
		stroke.Color = Color3.new(1,1,1)
		frame.Transparency = 0
		frame.Size = UDim2.new(0,180,0,70)
		frame.ZIndex = 10000000
		frame.BackgroundTransparency = 1
		frame:SetAttribute("Radius",nil)
		frame:SetAttribute("Filled",true)
		frame:SetAttribute("Thickness",1)
		frame:SetAttribute("NotCircle",true)
		return frame
	end
	if typ == "Circle" then
		local frame = Instance.new("Frame",gui)
		frame.Transparency = 0
		frame.Size = UDim2.new(0,180,0,180)
		frame.BackgroundTransparency = 1
		local stroke = Instance.new("UIStroke",frame)
		stroke.Color = Color3.new(1,1,1)
		local cornering = Instance.new("UICorner",frame)
		cornering.CornerRadius = UDim.new(0,180)
		frame.ZIndex = 10000000
		frame:SetAttribute("Radius",180)
		frame:SetAttribute("Filled",true)
		frame:SetAttribute("Thickness",1)
		return frame
	end
	if typ == "Text" then
		local frame = Instance.new("TextLabel",gui)
		frame.Transparency = 0
		frame.Size = UDim2.new(0,180,0,180)
		frame.BackgroundTransparency = 1
		frame.ZIndex = 10000000
		return frame
	end
end
return Drawing

end;
};
-- StarterGui.hax2.walls
local function C_5()
local script = G2L["5"];
	local Drawing = require(script.Parent.Modules.Drawing)
	local UDim2 = require(script.Parent.Modules.ToUDim2)
	local GetIcon = require(game.ReplicatedStorage.GetIcon)
	
	Drawing.Start()
	
	local boxes = {}
	local texts = {}
	local lines = {}
	local barrs = {}
	local obars = {}
	local icons = {}
	
	local wtvp = function(...) 
		local a, b = workspace.Camera.WorldToViewportPoint(workspace.Camera, ...) 
		return Vector2.new(a.X, a.Y), b, a.Z 
	end;
	
	function makeDrawings()
		local x = 0
		for _,i in pairs(game.Players:GetChildren()) do
			if i ~= game.Players.LocalPlayer then
				boxes[_] = Drawing.new("Square")
				boxes[_]:SetAttribute("Thickness",1)
				boxes[_]:SetAttribute("Filled",false)
				boxes[_].UIStroke.Color = Color3.new(1,1,1)
				boxes[_].Visible = true;
				boxes[_].ZIndex = 2
				texts[_] = Drawing.new("Text")
				texts[_].Text = i.Name
				lines[_] = Drawing.new("Line")
				barrs[_] = Drawing.new("Square")
				barrs[_]:SetAttribute("Filled",true)
				barrs[_]:SetAttribute("Thickness",0)
				obars[_] = Drawing.new("Square")
				obars[_]:SetAttribute("Filled",true)
				obars[_]:SetAttribute("Thickness",0)
				icons[_] = Instance.new("ImageLabel",game.Players.LocalPlayer.PlayerGui:WaitForChild("GUI"))
				icons[_].BackgroundTransparency = 1
			end
		end
	end
	
	function updateDrawings()
		for _,i in pairs(boxes) do
			local char = game.Players:WaitForChild(texts[_].Text).Character
			if char then
				local cframe = char:GetModelCFrame()
				local position, visible, depth = wtvp(cframe.Position);
				local scaleFactor = 1 / (depth * math.tan(math.rad(workspace.Camera.FieldOfView / 2)) * 2) * 1000;
				local width, height = math.round(4/1.5 * scaleFactor), math.round(5/1.5 * scaleFactor)
				local x, y = math.round(position.X), math.round(position.Y)
				
				boxes[_].Visible = visible and getgenv().Walls and getgenv().WallsOn
				texts[_].Visible = visible and getgenv().Names and getgenv().WallsOn
				lines[_].Visible = visible and getgenv().Tracers and getgenv().WallsOn
				barrs[_].Visible = visible and getgenv().HPBars and getgenv().WallsOn
				obars[_].Visible = visible and getgenv().HPBars and getgenv().WallsOn
				icons[_].Visible = visible and getgenv().Icons and getgenv().WallsOn
				
				boxes[_].Size = UDim2.newfromVector2(Vector2.new(width, height))
				boxes[_].Position = UDim2.newfromVector2(Vector2.new(x - width / 2, y - height / 2))
	
				texts[_].Size = UDim2.newfromVector2(Vector2.new(width, height))
				texts[_].Position = UDim2.newfromVector2(Vector2.new(x - width / 2, y - height-10))
				texts[_].TextColor3 = Color3.new(1,1,1)
				texts[_].Font = Enum.Font.Code
				texts[_].TextStrokeTransparency = 0
				texts[_].TextSize = 17
				
				lines[_]:SetAttribute("From",Vector2.new(script.Parent.AbsoluteSize.X/2,script.Parent.AbsoluteSize.Y+50))
				lines[_]:SetAttribute("To",Vector2.new(x,y))
				
				barrs[_].Size = UDim2.newfromVector2(Vector2.new(1, height))
				barrs[_].Position = UDim2.newfromVector2(Vector2.new(x - ((width+8) / 2), y - height / 2))
				barrs[_].BackgroundColor3 = Color3.new(0, 0, 0)
				
				obars[_].Size = UDim2.newfromVector2(Vector2.new(1, height*char.Humanoid.Health/100))
				obars[_].Position = UDim2.newfromVector2(Vector2.new(x - ((width+8) / 2), (y - height / 2)))
				obars[_].BackgroundColor3 = Color3.new(0, 1, 0)
				
				icons[_].Position = UDim2.newfromVector2(Vector2.new(x - (width / 2)*0.9, y - (height / 2)*-1))
				icons[_].Size = UDim2.newfromVector2(Vector2.new(width*0.9, height*0.25))
				icons[_].Image = GetIcon.getWeaponOfKiller(char.EquippedTool.Value)
			else
				boxes[_].Visible = false
				texts[_].Visible = false
				lines[_].Visible = false
				barrs[_].Visible = false
				obars[_].Visible = false
				icons[_].Visible = false
			end
		end
	end
	
	function removeDrawings()
		for _,i in pairs(boxes) do
	
			i:Destroy()
	
		end
		for _,i in pairs(texts) do
	
			i:Destroy()
	
		end
		for _,i in pairs(lines) do
	
			i:Destroy()
	
		end
		for _,i in pairs(barrs) do
	
			i:Destroy()
	
		end
		for _,i in pairs(obars) do
	
			i:Destroy()
	
		end
		for _,i in pairs(icons) do
	
			i:Destroy()
	
		end
	end
	
	game["Run Service"].RenderStepped:Connect(function()
		makeDrawings()
		updateDrawings()
	end)
	
	game["Run Service"].Stepped:Connect(function()
		removeDrawings()
	end)
end;
task.spawn(C_5);

return G2L["1"], require;
