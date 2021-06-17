for i,v in pairs(getgc(true)) do
if type(v) == "table" then
if rawget(v, "getammo") then
--table.foreach(v, warn)
v.getammo = function() return 999 end
v.getsecondaryammo = function() return 999 end
while wait() do
v.recoil = 0
v.currentspread = 0
v.reloadtime = 0
v.mode = "automatic" -- Makes it so you can just hold your click down and it'd shoot
end
end
end
end
