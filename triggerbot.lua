getgenv().settings = {
   TeamCheck = true;
   Delay = 0;
   Keybind = Enum.KeyCode.E;
   Enabled = true;
}

local Holding = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:connect(function(key)
   if key.KeyCode == getgenv().settings.Keybind and getgenv().settings.Enabled then
       Holding = true
       while Holding do wait()
           if Mouse.Target and Players:FindFirstChild(Mouse.Target.Parent.Name) then
               local HitPlayer = Players:FindFirstChild(Mouse.Target.Parent.Name)
               if HitPlayer.Team ~= LocalPlayer.Team or not getgenv().settings.TeamCheck then
                   if getgenv().settings.Delay > 0 then wait(getgenv().settings.Delay) end
                   mouse1press(); wait(); mouse1release()
               end
           end
           if not getgenv().settings.Enabled then break end
       end
   end
end)

UserInputService.InputEnded:connect(function(key)
   if key.KeyCode == getgenv().settings.Keybind and getgenv().settings.Enabled then
       Holding = false
   end
end)
