local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/jjsjdbdjdhdhdjjdh-bit/ClaudeUI/refs/heads/main/ClaudeLibrary.lua"))()

local win = UI.new({
	Title  = "My Script",
	Icon   = "zap",
	Width  = 720,
	Height = 500,
})

win:CreateHomeTab({
	DiscordInvite        = "myserver",
	SupportedExecutors   = { "Synapse X", "Xeno", "AWP" },
	UnsupportedExecutors = { "Krnl", "Fluxus" },
	Changelog = {
		{ Title = "v2.0", Date = "02/21/2026", Description = "Full UI rewrite with new orange theme." },
		{ Title = "v1.5", Date = "01/10/2026", Description = "Added ESP system and improved Aimbot." },
		{ Title = "v1.0", Date = "12/05/2025", Description = "Initial release." },
	},
})

local tabPlayer = win:CreateTab({ Title = "Player", Icon = "user" })

tabPlayer:AddLabel("Movement", { TextSize = 11, Color = Color3.fromRGB(180, 180, 180) })

local speedSlider = tabPlayer:AddSlider("Walk Speed", 16, 200, 16, function(val)
	local char = game.Players.LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.WalkSpeed = val
	end
end)

local jumpSlider = tabPlayer:AddSlider("Jump Height", 7, 100, 7, function(val)
	local char = game.Players.LocalPlayer.Character
	if char and char:FindFirstChild("Humanoid") then
		char.Humanoid.JumpPower = val
	end
end)

tabPlayer:AddSeparator()
tabPlayer:AddLabel("Physics", { TextSize = 11, Color = Color3.fromRGB(180, 180, 180) })

local noClipToggle = tabPlayer:AddToggle("NoClip", false, function(state)
	win:Toast(state and "NoClip enabled" or "NoClip disabled", state and "success" or "info")
end, { Icon = "ghost" })

local infJumpToggle = tabPlayer:AddToggle("Infinite Jump", false, function(state)
	win:Toast(state and "Infinite Jump ON" or "Infinite Jump OFF", state and "success" or "info")
end, { Icon = "chevrons-up" })

local flyToggle = tabPlayer:AddToggle("Fly", false, function(state)
	win:Toast(state and "Fly enabled" or "Fly disabled", state and "success" or "info")
end, { Icon = "plane" })

tabPlayer:AddSeparator()

tabPlayer:AddButton("Reset Values", function()
	speedSlider.Set(16)
	jumpSlider.Set(7)
	noClipToggle.Set(false)
	infJumpToggle.Set(false)
	flyToggle.Set(false)
	win:Toast("Values reset", "info")
end, { Icon = "rotate-ccw" })

tabPlayer:AddButton("Teleport to Spawn", function()
	local spawn = workspace:FindFirstChildWhichIsA("SpawnLocation")
	local char  = game.Players.LocalPlayer.Character
	if spawn and char and char:FindFirstChild("HumanoidRootPart") then
		char.HumanoidRootPart.CFrame = spawn.CFrame + Vector3.new(0, 5, 0)
		win:Toast("Teleported!", "success")
	else
		win:Toast("Spawn not found", "error")
	end
end, { Icon = "map-pin", Primary = true })

local tabVisual = win:CreateTab({ Title = "Visual", Icon = "eye" })

tabVisual:AddLabel("ESP", { TextSize = 11, Color = Color3.fromRGB(180, 180, 180) })

tabVisual:AddToggle("Player ESP", false, function(state)
	win:Toast("ESP " .. (state and "ON" or "OFF"), state and "success" or "info")
end, { Icon = "users" })

tabVisual:AddToggle("Show Names",  true,  function(state) end, { Icon = "tag"    })
tabVisual:AddToggle("Show Health", true,  function(state) end, { Icon = "heart"  })
tabVisual:AddToggle("Show Team",   false, function(state) end, { Icon = "shield" })

tabVisual:AddSeparator()
tabVisual:AddLabel("Camera", { TextSize = 11, Color = Color3.fromRGB(180, 180, 180) })

tabVisual:AddSlider("Field of View (FOV)", 60, 120, 70, function(val)
	workspace.CurrentCamera.FieldOfView = val
end)

tabVisual:AddSlider("Sensitivity", 1, 10, 5, function(val) end)

tabVisual:AddSeparator()

tabVisual:AddDropdown("FOV Preset", {
	"Default (70)",
	"Wide (90)",
	"Ultra-Wide (110)",
	"Competitive (60)",
}, function(val)
	local map = {
		["Default (70)"]     = 70,
		["Wide (90)"]        = 90,
		["Ultra-Wide (110)"] = 110,
		["Competitive (60)"] = 60,
	}
	if map[val] then
		workspace.CurrentCamera.FieldOfView = map[val]
		win:Toast("FOV → " .. map[val], "success")
	end
end, { Icon = "aperture" })

local tabAim = win:CreateTab({ Title = "Aimbot", Icon = "crosshair" })

tabAim:AddToggle("Aimbot", false, function(state)
	win:Toast("Aimbot " .. (state and "enabled" or "disabled"), state and "success" or "warning")
end, { Icon = "target" })

tabAim:AddToggle("Silentaim", false, function(state) end, { Icon = "wind" })

tabAim:AddSeparator()
tabAim:AddLabel("Settings", { TextSize = 11, Color = Color3.fromRGB(180, 180, 180) })

tabAim:AddSlider("Smoothness",    1,  20,  5,   function(val) end)
tabAim:AddSlider("Field of View", 10, 300, 120, function(val) end)

tabAim:AddSeparator()

tabAim:AddDropdown("Target Hitbox", {
	"Head",
	"Torso",
	"Random",
}, function(val)
	win:Toast("Hitbox → " .. val, "info")
end, { Icon = "target" })

tabAim:AddDropdown("Aim Mode", {
	"Mouse (default)",
	"Keyboard (Toggle)",
	"Always on",
}, function(val) end, { Icon = "mouse-pointer" })

local tabMisc = win:CreateTab({ Title = "Misc", Icon = "settings" })

tabMisc:AddLabel("Notifications", { TextSize = 11, Color = Color3.fromRGB(180, 180, 180) })

tabMisc:AddButton("Toast: Success", function() win:Toast("Operation completed successfully!", "success", 3) end, { Icon = "circle-check"   })
tabMisc:AddButton("Toast: Warning", function() win:Toast("Possible anticheat detected.",      "warning", 3) end, { Icon = "triangle-alert" })
tabMisc:AddButton("Toast: Error",   function() win:Toast("Failed to connect to server.",      "error",   3) end, { Icon = "circle-x"       })
tabMisc:AddButton("Toast: Info",    function() win:Toast("Script loaded successfully!",       "info",    3) end, { Icon = "info"           })

tabMisc:AddSeparator()
tabMisc:AddLabel("Input", { TextSize = 11, Color = Color3.fromRGB(180, 180, 180) })

tabMisc:AddInput("Type a command...", function(text, enter)
	if enter and text ~= "" then
		win:Toast("Command: " .. text, "info")
	end
end, { Icon = "terminal" })

tabMisc:AddSeparator()

tabMisc:AddButton("Reload Script", function()
	win:Toast("Reloading...", "warning", 2)
	task.delay(2, function()
	end)
end, { Icon = "refresh-cw" })

tabMisc:AddButton("Close UI", function()
	win:Destroy()
end, { Icon = "x" })

task.delay(0.5, function()
	win:Toast("Script loaded! Welcome.", "success", 4)
end)
