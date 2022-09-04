-- Made by: Racist Dolphin#5199

------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------
------------------------------------------------

script.Name = "Project Bullshit V4"

local ps = game:GetService("Players")
local i = game:GetService("UserInputService")
local r = game:GetService("RunService")
local cg = game:GetService("CoreGui")
local sg = game:GetService("StarterGui")
local ts = game:GetService("TweenService")
local rs = game:GetService("ReplicatedStorage")
local http = game:GetService("HttpService")
local light = game:GetService("Lighting")
local pathservice = game:GetService("PathfindingService")
local p = ps.LocalPlayer
local c = p.Character
local mo = p:GetMouse()
local b = p:FindFirstChild("Backpack") or p:WaitForChild("Backpack")
local g = p:FindFirstChild("PlayerGui") or p:WaitForChild("PlayerGui")
local ca = workspace.CurrentCamera

--[[local getupval = debug.getupvalue or getupvalue
local getupvals = debug.getupvalues or getupvalues
local getreg = debug.getregistry or getregistry
local setupval = debug.setupvalue or setupvalue
local getlocalval = debug.getlocal or getlocal
local getlocalvals = debug.getlocals or getlocals
local setlocalval = debug.setlocal or setlocal
local getmetat = getrawmetatable or getmetatable
local setreadonly1 = make_writeable or setreadonly

if getupval == nil or getupvals == nil or getreg == nil or setupval == nil or getmetat == nil or setreadonly1 == nil then
	return p:Kick("Unfortunately the exploit you're using is not supported. :C")
end

local m = getmetat(game)
setreadonly1(m, false)

local oldindex = m.__index
local oldnamecall = m.__namecall]]

local functions = { }
local main = { }
local esp_stuff = { }
local cham_stuff = { }
local fullbright_stuff = { }
local tracer_stuff = { }
local gui = { }
local loops = { }

local colors = {
	Enemy = Color3.new(1, 0, 0),
	Ally = Color3.new(0, 1, 0),
	Neutral = Color3.new(1, 1, 1),
}

local version = "4.0.4"

do -- functions
	function functions:LoopRunning(name)
		return loops[name].Running
	end

	function functions:CreateLoop(name, func, ...)
		if loops[name] ~= nil then return end

		loops[name] = { }
		loops[name].Running = false
		loops[name].Destroy = false
		loops[name].Loop = coroutine.create(function(...)
			while true do
				if loops[name].Running then
					func(...)
				end

				if loops[name].Destroy then
					break
				end
				r.RenderStepped:wait()
			end
		end)
	end

	function functions:RunLoop(name, func, ...)
		if loops[name] == nil then
			if func ~= nil then
				self:CreateLoop(name, func, ...)
			end
		end

		loops[name].Running = true
		local succ, out = coroutine.resume(loops[name].Loop)
		if not succ then
			error(out)
		end
	end

	function functions:StopLoop(name)
		if loops[name] == nil then return end

		loops[name].Running = false
	end

	function functions:DestroyLoop(name)
		if loops[name] == nil then return end

		self:StopLoop(name)
		loops[name].Destroy = true

		loops[name] = nil
	end

	function functions:AddComma(str) -- stole from Mining Simulator :)
		local f, k = str, nil
		while true do
			f, k = string.gsub(f, "^(-?%d+)(%d%d%d)", "%1,%2")
			if k == 0 then
				break
			end
		end
		return f
	end

	function functions:deepcopy(orig) -- http://lua-users.org/wiki/CopyTable
	    local orig_type = type(orig)
	    local copy
	    if orig_type == 'table' then
	        copy = {}
	        for orig_key, orig_value in next, orig, nil do
	            copy[functions:deepcopy(orig_key)] = functions:deepcopy(orig_value)
	        end
	        setmetatable(copy, functions:deepcopy(getmetatable(orig)))
	    else -- number, string, boolean, etc
	        copy = orig
	    end
	    return copy
	end

	function functions:GetSizeOfObj(obj)
		if obj:IsA("BasePart") then
			return obj.Size
		elseif obj:IsA("Model") then
			return obj:GetExtentsSize()
		end
	end

	function functions:GetTeamColor(plr)
		local cr = Color3.new(1, 1, 1)

		if game.PlaceId == 142823291 then
			if b:FindFirstChild("Knife") or c:FindFirstChild("Knife") then
				if plr:FindFirstChild("Backpack") == nil or plr.Character == nil then return cr end

				if plr.Backpack:FindFirstChild("Gun") or plr.Backpack:FindFirstChild("Revolver") or plr.Character:FindFirstChild("Gun") or plr.Character:FindFirstChild("Revolver") then
					cr = colors.Enemy
				else
					cr = Color3.new(1, 135 / 255, 0)
				end
			elseif b:FindFirstChild("Gun") or b:FindFirstChild("Revolver") or c:FindFirstChild("Gun") or c:FindFirstChild("Revolver") then
				if plr:FindFirstChild("Backpack") == nil or plr.Character == nil then return cr end

				if plr.Backpack:FindFirstChild("Knife") or plr.Character:FindFirstChild("Knife") then
					cr = colors.Enemy
				else
					cr = colors.Ally
				end
			else
				if plr:FindFirstChild("Backpack") == nil or plr.Character == nil then return cr end

				if plr.Backpack:FindFirstChild("Knife") or plr.Character:FindFirstChild("Knife") then
					cr = colors.Enemy
				elseif plr.Backpack:FindFirstChild("Gun") or plr.Backpack:FindFirstChild("Revolver") or plr.Character:FindFirstChild("Gun") or plr.Character:FindFirstChild("Revolver") then
					cr = colors.Ally
				else
					cr = colors.Neutral
				end
			end
		else
			if plr.Team ~= p.Team then
				cr = colors.Enemy
			else
				cr = colors.Ally
			end
		end

		return cr
	end

	function functions:GetClosestPlayer()
		local players = { }
		local current_closest_player = nil
		local selected_player = nil

		for i, v in pairs(ps:GetPlayers()) do
			if v ~= p and v.Team ~= p.Team then
				local char = v.Character
				if c and char then
					local my_head, my_tor, my_hum = c:FindFirstChild("Head"), c:FindFirstChild("HumanoidRootPart"), c:FindFirstChild("Humanoid")
					local their_head, their_tor, their_hum = char:FindFirstChild("Head"), char:FindFirstChild("HumanoidRootPart"), char:FindFirstChild("Humanoid")
					if my_head and my_tor and my_hum and their_head and their_tor and their_hum then
						if my_hum.Health > 1 and their_hum.Health > 1 then
							--local ray = Ray.new(ca.CFrame.p, (their_head.Position - ca.CFrame.p).unit * 2048)
							--local part = workspace:FindPartOnRayWithIgnoreList(ray, {c, ca})
							--if part ~= nil then
								--if part:IsDescendantOf(char) then
									local dist = (my_tor.Position - their_tor.Position).magnitude
									players[v] = dist
								--end
							--end
						end
					end
				end
			end
		end

		for i, v in next, players do
			if current_closest_player ~= nil then
				if v <= current_closest_player then
					current_closest_player = v
					selected_player = i
				end
			else
				current_closest_player = v
				selected_player = i
			end
		end

		return selected_player
	end

	function functions:Console(txt)
		sg:SetCore("ChatMakeSystemMessage",
			{
				Text = "Racist Dolphin: " .. txt,
				Color = Color3.new(1, 1, 1),
				Font = Enum.Font.SourceSansBold,
				TextSize = 18
			}
		)

		local msg = g.Chat:GetDescendants()
		repeat
			for i, v in next, msg do
				if v:IsA("TextLabel") or v:IsA("TextButton") then
					if v.Text == "Racist Dolphin: " .. txt then
						msg = v
						break
					end
				end
			end
			r.RenderStepped:wait()
		until type(msg) ~= "table"

		spawn(function()
			local n = 0
			while msg.Text == "Racist Dolphin: " .. txt do
				msg.TextColor3 = Color3.fromHSV(n, 0.4, 1)
				n = (n + 0.01) % 1

				r.RenderStepped:wait()
			end

			msg.TextColor3 = Color3.new(1, 1, 1)
		end)
	end
end

do -- gui
	gui = {
		name = "Base",
		gui_objs = {
			main = nil,
			mainframes = { },
		}
	}

	function gui:AddButton(mainframe, name, text)
		self.gui_objs.mainframes[mainframe].buttons[name] = { }

		self.gui_objs.mainframes[mainframe].buttons[name].main = Instance.new("Frame")
		self.gui_objs.mainframes[mainframe].buttons[name].main.BackgroundTransparency = 1
		self.gui_objs.mainframes[mainframe].buttons[name].main.Name = name
		self.gui_objs.mainframes[mainframe].buttons[name].main.Position = UDim2.new(0, 0, 0, 5 + self.gui_objs.mainframes[mainframe].buttonsnum)
		self.gui_objs.mainframes[mainframe].buttons[name].main.Size = UDim2.new(1, 0, 0, 15)
		self.gui_objs.mainframes[mainframe].buttons[name].main.Parent = self.gui_objs.mainframes[mainframe].buttonsframe

		self.gui_objs.mainframes[mainframe].buttons[name].textbutton = Instance.new("TextButton")
		self.gui_objs.mainframes[mainframe].buttons[name].textbutton.BackgroundTransparency = 1
		self.gui_objs.mainframes[mainframe].buttons[name].textbutton.Position = UDim2.new(0, 5, 0, 0)
		self.gui_objs.mainframes[mainframe].buttons[name].textbutton.Size = UDim2.new(1, -5, 1, 0)
		self.gui_objs.mainframes[mainframe].buttons[name].textbutton.ZIndex = 2
		self.gui_objs.mainframes[mainframe].buttons[name].textbutton.Font = Enum.Font.SciFi
		self.gui_objs.mainframes[mainframe].buttons[name].textbutton.Text = text
		self.gui_objs.mainframes[mainframe].buttons[name].textbutton.TextColor3 = Color3.new(1, 1, 1)
		self.gui_objs.mainframes[mainframe].buttons[name].textbutton.TextScaled = true
		self.gui_objs.mainframes[mainframe].buttons[name].textbutton.TextXAlignment = Enum.TextXAlignment.Left
		self.gui_objs.mainframes[mainframe].buttons[name].textbutton.Parent = self.gui_objs.mainframes[mainframe].buttons[name].main

		self.gui_objs.mainframes[mainframe].buttons[name].textlabel = Instance.new("TextLabel")
		self.gui_objs.mainframes[mainframe].buttons[name].textlabel.BackgroundTransparency = 1
		self.gui_objs.mainframes[mainframe].buttons[name].textlabel.Position = UDim2.new(1, -25, 0, 0)
		self.gui_objs.mainframes[mainframe].buttons[name].textlabel.Size = UDim2.new(0, 25, 1, 0)
		self.gui_objs.mainframes[mainframe].buttons[name].textlabel.Font = Enum.Font.Code
		self.gui_objs.mainframes[mainframe].buttons[name].textlabel.Text = "OFF"
		self.gui_objs.mainframes[mainframe].buttons[name].textlabel.TextColor3 = Color3.new(1, 0, 0)
		self.gui_objs.mainframes[mainframe].buttons[name].textlabel.TextScaled = true
		self.gui_objs.mainframes[mainframe].buttons[name].textlabel.TextXAlignment = Enum.TextXAlignment.Right
		self.gui_objs.mainframes[mainframe].buttons[name].textlabel.Parent = self.gui_objs.mainframes[mainframe].buttons[name].main

		self.gui_objs.mainframes[mainframe].buttonsnum = self.gui_objs.mainframes[mainframe].buttonsnum + 20

		return self.gui_objs.mainframes[mainframe].buttons[name].textbutton, self.gui_objs.mainframes[mainframe].buttons[name].textlabel
	end

	function gui:AddMainFrame(name)
		if self.gui_objs.mainframes.numX == nil then self.gui_objs.mainframes.numX = 0 end
		if self.gui_objs.mainframes.numY == nil then self.gui_objs.mainframes.numY = 0 end

		self.gui_objs.mainframes[name] = { }
		self.gui_objs.mainframes[name].buttons = { }

		self.gui_objs.mainframes[name].main = Instance.new("Frame")
		self.gui_objs.mainframes[name].main.BackgroundColor3 = Color3.new(0, 0, 0)
		self.gui_objs.mainframes[name].main.BackgroundTransparency = 0.3
		self.gui_objs.mainframes[name].main.BorderColor3 = Color3.new(0, 0, 139 / 255)
		self.gui_objs.mainframes[name].main.BorderSizePixel = 3
		self.gui_objs.mainframes[name].main.Name = name
		self.gui_objs.mainframes[name].main.Position = UDim2.new(0, 50 + self.gui_objs.mainframes.numX, 0, 50 + self.gui_objs.mainframes.numY)
		self.gui_objs.mainframes[name].main.Size = UDim2.new(0, 200, 0, 350)
		self.gui_objs.mainframes[name].main.Active = true
		self.gui_objs.mainframes[name].main.Draggable = true

		self.gui_objs.mainframes[name].titleframe = Instance.new("Frame")
		self.gui_objs.mainframes[name].titleframe.BackgroundColor3 = Color3.new(0, 0, 0)
		self.gui_objs.mainframes[name].titleframe.BackgroundTransparency = 0.3
		self.gui_objs.mainframes[name].titleframe.BorderColor3 = Color3.new(0, 0, 139 / 255)
		self.gui_objs.mainframes[name].titleframe.BorderSizePixel = 3
		self.gui_objs.mainframes[name].titleframe.Name = "titleframe"
		self.gui_objs.mainframes[name].titleframe.Position = UDim2.new(0, 0, 0, -35)
		self.gui_objs.mainframes[name].titleframe.Size = UDim2.new(1, 0, 0, 25)
		self.gui_objs.mainframes[name].titleframe.Parent = self.gui_objs.mainframes[name].main

		self.gui_objs.mainframes[name].title = Instance.new("TextLabel")
		self.gui_objs.mainframes[name].title.BackgroundTransparency = 1
		self.gui_objs.mainframes[name].title.Name = "title"
		self.gui_objs.mainframes[name].title.Size = UDim2.new(1, 0, 1, 0)
		self.gui_objs.mainframes[name].title.Font = Enum.Font.Code
		self.gui_objs.mainframes[name].title.Text = name
		self.gui_objs.mainframes[name].title.TextColor3 = Color3.new(1, 1, 1) -- 0, 0, 1
		self.gui_objs.mainframes[name].title.TextSize = 20
		self.gui_objs.mainframes[name].title.Parent = self.gui_objs.mainframes[name].titleframe

		self.gui_objs.mainframes[name].buttonsframe = Instance.new("Frame")
		self.gui_objs.mainframes[name].buttonsframe.BackgroundTransparency = 1
		self.gui_objs.mainframes[name].buttonsframe.Name = "buttons"
		self.gui_objs.mainframes[name].buttonsframe.Size = UDim2.new(1, 0, 1, 0)
		self.gui_objs.mainframes[name].buttonsframe.Parent = self.gui_objs.mainframes[name].main

		self.gui_objs.mainframes[name].infoframe = self.gui_objs.mainframes[name].titleframe:clone()
		self.gui_objs.mainframes[name].infoframe.title:Destroy()
		self.gui_objs.mainframes[name].infoframe.Name = "infoframe"
		self.gui_objs.mainframes[name].infoframe.Position = UDim2.new(0, 0, 1, 10)
		self.gui_objs.mainframes[name].infoframe.Parent = self.gui_objs.mainframes[name].main

		self.gui_objs.mainframes[name].infotitle = self.gui_objs.mainframes[name].title:clone()
		self.gui_objs.mainframes[name].infotitle.Name = "infotitle"
		self.gui_objs.mainframes[name].infotitle.Text = "Press the \"P\" key to toggle the GUI\nMade by: @Racist Dolphin#0001"
		self.gui_objs.mainframes[name].infotitle.TextColor3 = Color3.new(1, 1, 1)
		self.gui_objs.mainframes[name].infotitle.TextScaled = true
		self.gui_objs.mainframes[name].infotitle.Parent = self.gui_objs.mainframes[name].infoframe

		self.gui_objs.mainframes[name].buttonsnum = 0
		self.gui_objs.mainframes.numX = self.gui_objs.mainframes.numX + 250

		if (50 + (self.gui_objs.mainframes.numX + 200)) >= ca.ViewportSize.X then
			self.gui_objs.mainframes.numX = 0
			self.gui_objs.mainframes.numY = self.gui_objs.mainframes.numY + 450
		end

		self.gui_objs.mainframes[name].main.Parent = self.gui_objs.main
	end

	function gui:Init()
		self.gui_objs.main = Instance.new("ScreenGui")
		self.gui_objs.main.Name = self.name
		self.gui_objs.main.Parent = cg

		do -- Visual Cheats
			self:AddMainFrame("Visual Cheats")

			local ESPBut, ESPStatus = self:AddButton("Visual Cheats", "ESP", "ESP")
			local ChamsBut, ChamsStatus = self:AddButton("Visual Cheats", "Chams", "Chams")
			local FullbrightToggle, FullbrightStatus = self:AddButton("Visual Cheats", "Fullbright", "Fullbright")

			ESPBut.MouseButton1Click:connect(function()
				esp_stuff.enabled = not esp_stuff.enabled
				if esp_stuff.enabled then
					ESPStatus.Text = "ON"
					ESPStatus.TextColor3 = Color3.new(0, 1, 0)
				else
					ESPStatus.Text = "OFF"
					ESPStatus.TextColor3 = Color3.new(1, 0, 0)
				end

				for i, v in next, esp_stuff.esp_folder:GetChildren() do
					v.Frame.Visible = esp_stuff.enabled
				end
			end)

			ChamsBut.MouseButton1Click:connect(function()
				cham_stuff.enabled = not cham_stuff.enabled
				if cham_stuff.enabled then
					ChamsStatus.Text = "ON"
					ChamsStatus.TextColor3 = Color3.new(0, 1, 0)
				else
					ChamsStatus.Text = "OFF"
					ChamsStatus.TextColor3 = Color3.new(1, 0, 0)
				end

				for i, v in next, cham_stuff.cham_folder:GetChildren() do
					for i2, v2 in next, v:GetChildren() do
						v2.Transparency = cham_stuff.enabled and 0 or 1
					end
				end
			end)

			FullbrightToggle.MouseButton1Click:connect(function()
				fullbright_stuff.enabled = not fullbright_stuff.enabled
				FullbrightStatus.Text = fullbright_stuff.enabled and "ON" or "OFF"
				FullbrightStatus.TextColor3 = fullbright_stuff.enabled and Color3.new(0, 1, 0) or Color3.new(1, 0, 0)

				if fullbright_stuff.enabled then
					fullbright_stuff:Enable()
				else
					fullbright_stuff:Disable()
				end
			end)
		end

		do -- ui toggle
			i.InputBegan:connect(function(input, ingui)
				if not ingui then
					if input.UserInputType == Enum.UserInputType.Keyboard then
						if input.KeyCode == Enum.KeyCode.P then
							self.gui_objs.main.Enabled = not self.gui_objs.main.Enabled
						end
					end
				end
			end)
		end
	end
end

do -- main
	function main:Init()
		do -- events
			p.CharacterAdded:connect(function(char)
				c = char
			end)
		end

		do -- loops
			functions:RunLoop("Version_Check", function()
				local data = loadstring(game:HttpGet("https://pastebin.com/raw/HLvUvtLv", true))()
				messages_of_the_day = data.messages_of_the_day
				data = data["Project Bullshit"]

				local current_version, reason = data.version, data.reason

				if version ~= current_version then
					p:Kick("This script has updated, please re-connect. Current Version: " .. tostring(current_version) .. " your version: " .. version .. "\nReason: " .. reason)
				end

				wait(300)
			end)

			functions:RunLoop("Messages of the Day", function()
				if messages_of_the_day == nil then return end

				for i = 1, #messages_of_the_day do
					functions:Console(tostring(messages_of_the_day[i]))
					wait(60)
				end
			end)
		end
	end
end

do -- esp_stuff
	esp_stuff = {
		enabled = false,
		esp_folder = Instance.new("Folder", cg)
	}

	function esp_stuff:CreateESP(plr)
		local char = plr.Character or plr.CharacterAdded:wait()
		local tor = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
		local head = char:FindFirstChild("Head") or char:WaitForChild("Head")
		local color = functions:GetTeamColor(plr)

		local bb = Instance.new("BillboardGui")
		bb.Adornee = head
		bb.ExtentsOffset = Vector3.new(0, 1, 0)
		bb.AlwaysOnTop = true
		bb.Size = UDim2.new(0, 5, 0, 5)
		bb.StudsOffset = Vector3.new(0, 3, 0)
		bb.Name = "ESP Crap_" .. plr.Name
		
		local frame = Instance.new("Frame", bb)
		frame.ZIndex = 10
		frame.BackgroundTransparency = 1
		frame.Size = UDim2.new(1, 0, 1, 0)
		
		local TxtName = Instance.new("TextLabel", frame)
		TxtName.Name = "Names"
		TxtName.ZIndex = 10
		TxtName.Text = plr.Name
		TxtName.BackgroundTransparency = 1
		TxtName.Position = UDim2.new(0, 0, 0, -45)
		TxtName.Size = UDim2.new(1, 0, 10, 0)
		TxtName.Font = "SourceSansBold"
		TxtName.TextSize = 12
		TxtName.TextStrokeTransparency = 0.5
		TxtName.TextColor3 = color

		local TxtDist = Instance.new("TextLabel", frame)
		TxtDist.Name = "Dist"
		TxtDist.ZIndex = 10
		TxtDist.Text = ""
		TxtDist.BackgroundTransparency = 1
		TxtDist.Position = UDim2.new(0, 0, 0, -35)
		TxtDist.Size = UDim2.new(1, 0, 10, 0)
		TxtDist.Font = "SourceSansBold"
		TxtDist.TextSize = 12
		TxtDist.TextStrokeTransparency = 0.5
		TxtDist.TextColor3 = color

		local TxtHealth = Instance.new("TextLabel", frame)
		TxtHealth.Name = "Health"
		TxtHealth.ZIndex = 10
		TxtHealth.Text = ""
		TxtHealth.BackgroundTransparency = 1
		TxtHealth.Position = UDim2.new(0, 0, 0, -25)
		TxtHealth.Size = UDim2.new(1, 0, 10, 0)
		TxtHealth.Font = "SourceSansBold"
		TxtHealth.TextSize = 12
		TxtHealth.TextStrokeTransparency = 0.5
		TxtHealth.TextColor3 = color

		bb.Parent = self.esp_folder
		frame.Visible = self.enabled
	end

	function esp_stuff:RemoveESP(plr)
		local find = self.esp_folder:FindFirstChild("ESP Crap_" .. plr.Name)
		if find then
			find:Destroy()
		end
	end

	function esp_stuff:UpdateESPColor(plr)
		local find = self.esp_folder:FindFirstChild("ESP Crap_" .. plr.Name)
		if find then
			local color = functions:GetTeamColor(plr)
			find.Frame.Names.TextColor3 = color
			find.Frame.Dist.TextColor3 = color
			find.Frame.Health.TextColor3 = color
		end
	end

	function esp_stuff:UpdateESP(plr)
		local find = self.esp_folder:FindFirstChild("ESP Crap_" .. plr.Name)
		if find then
			local char = plr.Character
			if c and char then
				local my_tor = c:FindFirstChild("HumanoidRootPart")
				local their_head = char:FindFirstChild("Head")
				local their_tor = char:FindFirstChild("HumanoidRootPart")
				local their_hum = char:FindFirstChildOfClass("Humanoid")

				if my_tor and their_tor then
					local dist = (my_tor.Position - their_tor.Position).magnitude
					find.Frame.Dist.Text = "Distance: " .. string.format("%.0f", dist)
				else
					find.Frame.Dist.Text = "Distance: nil"
				end

				if their_hum then
					find.Frame.Health.Text = "Health: " .. string.format("%.0f", their_hum.Health)
				else
					find.Frame.Health.Text = "Health: nil"
				end

				if their_head then
					if find.Adornee ~= their_head then
						find.Adornee = their_head
					end
				end
			end
		end
	end

	function esp_stuff:Init()
		functions:RunLoop("ESP_Update", function()
			if self.enabled then
				for i, v in pairs(ps:GetPlayers()) do
					self:UpdateESP(v)
				end
			end
		end)

		for i, v in pairs(ps:GetPlayers()) do
			spawn(function()
				if v ~= p then
					self:CreateESP(v)
					v.Changed:connect(function(prop)
						self:UpdateESPColor(v)
					end)

					v.CharacterAdded:connect(function(char)
						char.ChildAdded:connect(function()
							self:UpdateESPColor(v)
						end)
					end)

					v:WaitForChild("Backpack", 15)

					v.Backpack.ChildAdded:connect(function()
						self:UpdateESPColor(v)
					end)
				end
			end)
		end

		ps.PlayerAdded:connect(function(plr)
			self:CreateESP(plr)
			plr.Changed:connect(function(prop)
				self:UpdateESPColor(plr)
			end)

			plr.CharacterAdded:connect(function(char)
				char.ChildAdded:connect(function()
					self:UpdateESPColor(plr)
				end)
			end)

			plr:WaitForChild("Backpack", 15)

			plr.Backpack.ChildAdded:connect(function()
				self:UpdateESPColor(plr)
			end)
		end)

		ps.PlayerRemoving:connect(function(plr)
			self:RemoveESP(plr)
		end)
	end
end

do -- cham_stuff
	cham_stuff = {
		enabled = false,
		cham_folder = Instance.new("Folder", cg)
	}

	function cham_stuff:CreateCham(plr)
		local player_folder = Instance.new("Folder", self.cham_folder)
		player_folder.Name = plr.Name

		local char = plr.Character or plr.CharacterAdded:wait()
		local tor = char:FindFirstChild("HumanoidRootPart") or char:WaitForChild("HumanoidRootPart")
		local hum = char:FindFirstChild("Humanoid") or char:WaitForChild("Humanoid")

		for i, v in pairs(char:GetChildren()) do
			if v:IsA("PVInstance") and v.Name ~= "HumanoidRootPart" then
				local box = Instance.new("BoxHandleAdornment")
				box.Size = functions:GetSizeOfObj(v)
				box.Name = "Cham"
				box.Adornee = v
				box.AlwaysOnTop = true
				box.ZIndex = 5
				box.Transparency = self.enabled and 0 or 1
				box.Color3 = functions:GetTeamColor(plr)
				box.Parent = player_folder
			end
		end

		plr.CharacterRemoving:connect(function()
			self:RemoveCham(plr)
			plr.CharacterAdded:wait()
			self:CreateCham(plr)
		end)

		hum.Died:connect(function()
			self:RemoveCham(plr)
			plr.CharacterAdded:wait()
			self:CreateCham(plr)
		end)
	end

	function cham_stuff:RemoveCham(plr)
		local find = self.cham_folder:FindFirstChild(plr.Name)
		if find then
			find:Destroy()
		end
	end

	function cham_stuff:UpdateChamColor(plr)
		local player_folder = self.cham_folder:FindFirstChild(plr.Name)
		if player_folder then
			local color = functions:GetTeamColor(plr)

			for i, v in pairs(player_folder:GetChildren()) do
				v.Color3 = color
			end
		end
	end

	function cham_stuff:UpdateCham(plr)
		local player_folder = self.cham_folder:FindFirstChild(plr.Name)

		local function SetTrans(trans)
			for i, v in pairs(player_folder:GetChildren()) do
				v.Transparency = trans
			end
		end

		if player_folder then
			local char = plr.Character
			if c and char then
				local their_head = char:FindFirstChild("Head")
				local their_tor = char:FindFirstChild("HumanoidRootPart")
				local their_hum = char:FindFirstChild("Humanoid")
				local my_head = c:FindFirstChild("Head")
				local my_tor = c:FindFirstChild("HumanoidRootPart")

				if their_hum then
					if their_hum.Health <= 0 then
						return SetTrans(1)
					end
				end

				if their_head and their_tor and my_head and my_tor then
					if (my_tor.Position - their_tor.Position).magnitude > 2048 then
						return SetTrans(1)
					end

					local ray = Ray.new(ca.CFrame.p, (their_tor.Position - ca.CFrame.p).unit * 2048)
					local part = workspace:FindPartOnRayWithIgnoreList(ray, {c})
					if part ~= nil then
						if part:IsDescendantOf(char) then
							return SetTrans(0.9)
						end
					end
				end
			end

			return SetTrans(0)
		end
	end

	function cham_stuff:Init()
		functions:RunLoop("Cham_Update", function()
			if self.enabled then
				for i, v in pairs(ps:GetPlayers()) do
					self:UpdateCham(v)
				end
			end
		end)

		for i, v in pairs(ps:GetPlayers()) do
			spawn(function()
				if v ~= p then
					self:CreateCham(v)

					v.Changed:connect(function(prop)
						self:UpdateChamColor(v)
					end)

					v.CharacterAdded:connect(function(char)
						char.ChildAdded:connect(function()
							self:UpdateChamColor(v)
						end)
					end)

					v:WaitForChild("Backpack", 15)

					v.Backpack.ChildAdded:connect(function()
						self:UpdateChamColor(v)
					end)
				end
			end)
		end

		ps.PlayerAdded:connect(function(plr)
			self:CreateCham(plr)
			plr.Changed:connect(function(prop)
				self:UpdateChamColor(plr)
			end)

			plr.CharacterAdded:connect(function(char)
				char.ChildAdded:connect(function()
					self:UpdateChamColor(plr)
				end)
			end)

			plr:WaitForChild("Backpack", 15)

			plr.Backpack.ChildAdded:connect(function()
				self:UpdateChamColor(plr)
			end)
		end)

		ps.PlayerRemoving:connect(function(plr)
			self:RemoveCham(plr)
		end)
	end
end

do -- fullbright_stuff
	fullbright_stuff = {
		enabled = false,
		backup = { },
	}

	function fullbright_stuff:Enable()
		self.enabled = true
		light.Ambient = Color3.new(1, 1, 1)
		light.Brightness = 2
		light.ColorShift_Bottom = Color3.new(1, 1, 1)
		light.ColorShift_Top = Color3.new(1, 1, 1)
		light.OutdoorAmbient = Color3.new(1, 1, 1)
	end

	function fullbright_stuff:Disable()
		self.enabled = false
		for i, v in pairs(self.backup) do
			light[i] = v
		end
	end

	function fullbright_stuff:Init()
		self.backup["Ambient"] = light.Ambient
		self.backup["Brightness"] = light.Brightness
		self.backup["ColorShift_Bottom"] = light.ColorShift_Bottom
		self.backup["ColorShift_Top"] = light.ColorShift_Top
		self.backup["OutdoorAmbient"] = light.OutdoorAmbient

		light:GetPropertyChangedSignal("Ambient"):connect(function()
			if self.enabled then
				light.Ambient = Color3.new(1, 1, 1)
			end
		end)

		light:GetPropertyChangedSignal("Brightness"):connect(function()
			if self.enabled then
				light.Brightness = 2
			end
		end)

		light:GetPropertyChangedSignal("ColorShift_Bottom"):connect(function()
			if self.enabled then
				light.ColorShift_Bottom = Color3.new(1, 1, 1)
			end
		end)

		light:GetPropertyChangedSignal("ColorShift_Top"):connect(function()
			if self.enabled then
				light.ColorShift_Top = Color3.new(1, 1, 1)
			end
		end)

		light:GetPropertyChangedSignal("OutdoorAmbient"):connect(function()
			if self.enabled then
				light.OutdoorAmbient = Color3.new(1, 1, 1)
			end
		end)
	end
end


main:Init()
esp_stuff:Init()
cham_stuff:Init()
fullbright_stuff:Init()
gui:Init()

functions:Console("Project Bullshit V4 Loaded!")
