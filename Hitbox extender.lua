function getplrsname()
for i,v in pairs(game:GetChildren()) do
if v.ClassName == "Players" then
return v.Name
end
end
end
hitboxsizevar = Vector3.new(1.5,1.5,1.5)
local players = getplrsname()
local plr = game[players].LocalPlayer
coroutine.resume(coroutine.create(function()
while  wait(1) do
coroutine.resume(coroutine.create(function()
for _,v in pairs(game[players]:GetPlayers()) do
if v.Name ~= plr.Name and v.Character then
v.Character.RightUpperLeg.CanCollide = false
v.Character.RightUpperLeg.Transparency = 10
v.Character.RightUpperLeg.Size = hitboxsizevar
v.Character.LeftUpperLeg.CanCollide = false
v.Character.LeftUpperLeg.Transparency = 10
v.Character.LeftUpperLeg.Size = hitboxsizevar
v.Character.HeadHB.CanCollide = false
v.Character.HeadHB.Transparency = 10
v.Character.HeadHB.Size = hitboxsizevar

v.Character.HumanoidRootPart.CanCollide = false
v.Character.HumanoidRootPart.Transparency = 10
v.Character.HumanoidRootPart.Size = hitboxsizevar

end
end
end))
end
end))
