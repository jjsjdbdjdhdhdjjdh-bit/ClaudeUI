# ClaudeUI

A clean, dark-themed UI library for Roblox executor scripts. Orange accent, optional acrylic blur, Lucide icons, and a set of components that are straightforward to use.

---

## Setup

Paste the full ClaudeUI source inside a string and run it through `loadstring`:

```lua
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/jjsjdbdjdhdhdjjdh-bit/ClaudeUI/refs/heads/main/ClaudeLibrary.lua"))()
```

Then spin up a window:

```lua
local win = UI.new({
    Title   = "My Script",
    Icon    = "zap",      -- any Lucide icon name, optional
    Width   = 720,
    Height  = 500,
    Acrylic = false,      -- glass blur (won't show inside Studio)
})
```

---

## Home Tab

Completely optional, but it comes with a lot out of the box — an avatar banner with a live clock, chips showing ping / player count / game name / executor, a changelog timeline, a friends panel, and a Discord invite banner.

```lua
win:CreateHomeTab({
    DiscordInvite        = "yourserver",
    SupportedExecutors   = { "Synapse X", "Xeno" },
    UnsupportedExecutors = { "Krnl" },
    Changelog = {
        { Title = "v1.0", Date = "01/01/2026", Description = "Initial release." },
        { Title = "v1.1", Date = "02/10/2026", Description = "Fixed a few things." },
    },
})
```

---

## Tabs

```lua
local tab = win:CreateTab({ Title = "Player", Icon = "user" })
```

`Icon` takes any name from [lucide.dev/icons](https://lucide.dev/icons). If the icon fails to load it just won't show — nothing explodes.

---

## Components

### Label

Plain text. Works well for section headers or short notes.

```lua
tab:AddLabel("Movement", {
    TextSize = 11,
    Color    = Color3.fromRGB(180, 180, 180),
    Rich     = false,  -- set true if you want RichText tags
})
```

---

### Separator

A thin horizontal line to break up a busy tab.

```lua
tab:AddSeparator()
```

---

### Button

```lua
tab:AddButton("Do Something", function()
    -- your logic here
end, {
    Icon    = "mouse-pointer",
    Primary = false,  -- true gives you the filled orange style
    Height  = 36,
})
```

---

### Toggle

```lua
local toggle = tab:AddToggle("Enable Feature", false, function(state)
    print(state)
end, {
    Icon  = "power",
    Style = "box",   -- "box" for checkbox, "basic" for pill/capsule
})

toggle.Get()       -- returns true or false
toggle.Set(true)   -- set it from outside the callback
```

---

### Slider

```lua
local slider = tab:AddSlider("Walk Speed", 16, 200, 16, function(val)
    local char = game.Players.LocalPlayer.Character
    if char then char.Humanoid.WalkSpeed = val end
end)

slider.Get()
slider.Set(100)
```

---

### Dropdown

```lua
local dropdown = tab:AddDropdown("Target Part", {
    "Head",
    "Torso",
    "Random",
}, function(val)
    print("picked:", val)
end, {
    Icon    = "list",
    Default = "Head",
})

dropdown.Get()
dropdown.Set("Torso")
```

---

### Input

Fires the callback when the box loses focus. The `enter` param is `true` if the user hit Enter to confirm.

```lua
tab:AddInput("Type a command...", function(text, enter)
    if enter and text ~= "" then
        print(text)
    end
end, {
    Icon    = "terminal",
    Default = "",
    Height  = 38,
})
```

---

## Toasts

Small notifications that stack in the bottom-right corner.

```lua
win:Toast("Operation completed!", "success", 3)
--                                 ↑ kind     ↑ how long in seconds
```

| Kind | Color |
|---|---|
| `"success"` | Green |
| `"warning"` | Yellow |
| `"error"` | Red |
| `"info"` | Blue |

---

## Destroying

```lua
win:Destroy()
```

Removes the window and cleans up the acrylic blur part if it was active.

---

## Quick Reference

```
UI.new(config)                               → Window
win:CreateHomeTab(config)
win:CreateTab(config)                        → Tab
win:Toast(message, kind, duration)
win:Destroy()

tab:AddLabel(text, opts)                     → TextLabel
tab:AddSeparator()                           → Frame
tab:AddButton(text, callback, opts)          → TextButton
tab:AddToggle(label, default, cb, opts)      → { Get, Set }
tab:AddSlider(label, min, max, default, cb)  → { Get, Set }
tab:AddDropdown(label, items, cb, opts)      → { Get, Set }
tab:AddInput(placeholder, cb, opts)          → TextBox
```
