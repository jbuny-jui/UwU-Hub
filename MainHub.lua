-- init
local library = loadstring(game:HttpGet("hhttps://raw.githubusercontent.com/jbuny-jui/UwU-Hub/main/VenyxUiLib.lua"))()
local venyx = library.new("UwU Hub", 5013109572)

-- themes
local themes = {
	Background = Color3.fromRGB(24, 24, 24),
	Glow = Color3.fromRGB(0, 0, 0),
	Accent = Color3.fromRGB(10, 10, 10),
	LightContrast = Color3.fromRGB(20, 20, 20),
	DarkContrast = Color3.fromRGB(14, 14, 14),  
	TextColor = Color3.fromRGB(255, 255, 255)
}

-- first page
local page = venyx:addPage("Stuff", 5012544693)
local section1 = page:addSection("Stuff")
local section2 = page:addSection("WARING: Wallcheck so dont work in some parts off map and scoping doesnt work")

section1:addButton("Triggerbot", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/jbuny-jui/UwU-Hub/main/triggerbot.lua"))()
end)

section1:addButton("Owl Hub (esp-aimbot-silentaim-tracer)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/ZinityDrops/OwlHubLink/master/OwlHubBack.lua"))()
end)
	
section1:addButton("Alternative Aimbot (may glitch) (headonly)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/jbuny-jui/UwU-Hub/main/Alternative_Aimbot.lua"))()
end)

section2:addButton("Project Bullshit(esp-chams-aimlock-fullbright)", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/jbuny-jui/UwU-Hub/main/Project_Bullshit.lua"))()
end)

-- second page
local theme = venyx:addPage("Theme", 5012544693)
local colors = theme:addSection("Colors")
local keybindre = theme:addSection("Key Bind")

for theme, color in pairs(themes) do -- all in one theme changer, i know, im cool
	colors:addColorPicker(theme, color, function(color3)
		venyx:setTheme(theme, color3)
	end)
end

keybindre:addKeybind("Toggle Gui Keybind", Enum.KeyCode.RightShift, function()
	print("Activated Keybind")
	venyx:toggle()
end, function()
	print("Changed Keybind")
end)

-- load
venyx:SelectPage(venyx.pages[1], true)
