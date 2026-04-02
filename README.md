# ClaudeUI

Interface library para scripts Roblox. Dark theme com acento laranja, acrylic blur opcional, ícones Lucide e componentes prontos pra usar.

---

## Começando

Cole o conteúdo completo da `ClaudeUI` dentro de uma string e execute com `loadstring`:

```lua
local abc = [[ ...conteúdo da ClaudeUI... ]]
local UI = loadstring(abc)()
```

Depois crie uma janela:

```lua
local win = UI.new({
    Title  = "Meu Script",
    Icon   = "zap",         -- nome de ícone Lucide (opcional)
    Width  = 720,
    Height = 500,
    Acrylic = false,        -- blur de fundo (só funciona fora do Studio)
})
```

---

## Home Tab

A home tab é opcional mas vem com bastante coisa pronta: banner com avatar, relógio, chips de ping/players/jogo/executor, changelog em timeline, painel de amigos e banner do Discord.

```lua
win:CreateHomeTab({
    DiscordInvite        = "seuservidor",          -- opcional
    SupportedExecutors   = { "Synapse X", "Xeno" },
    UnsupportedExecutors = { "Krnl" },
    Changelog = {
        { Title = "v1.0", Date = "01/01/2026", Description = "Lançamento." },
    },
})
```

---

## Tabs

```lua
local tab = win:CreateTab({ Title = "Player", Icon = "user" })
```

O segundo argumento `Icon` é qualquer nome válido da biblioteca [Lucide Icons](https://lucide.dev/icons/).

---

## Componentes

### Label

Texto simples. Útil pra títulos de seção.

```lua
tab:AddLabel("Seção", {
    TextSize = 11,
    Color    = Color3.fromRGB(180, 180, 180),
    Rich     = false,   -- RichText
})
```

---

### Separator

Linha divisória horizontal.

```lua
tab:AddSeparator()
```

---

### Button

```lua
tab:AddButton("Clique aqui", function()
    print("clicado")
end, {
    Icon    = "mouse-pointer",
    Primary = false,   -- true = laranja
    Height  = 36,
})
```

---

### Toggle

```lua
local toggle = tab:AddToggle("Ativar", false, function(state)
    print(state)
end, {
    Icon  = "power",
    Style = "box",   -- "box" ou "basic" (capsule)
})

toggle.Get()        -- → true/false
toggle.Set(true)
```

---

### Slider

```lua
local slider = tab:AddSlider("Velocidade", 0, 100, 50, function(val)
    print(val)
end)

slider.Get()
slider.Set(75)
```

---

### Dropdown

```lua
local dropdown = tab:AddDropdown("Modo", {
    "Opção A",
    "Opção B",
    "Opção C",
}, function(val)
    print(val)
end, {
    Icon    = "list",
    Default = "Opção A",
})

dropdown.Get()
dropdown.Set("Opção B")
```

---

### Input

Dispara o callback ao perder foco. O segundo parâmetro `enter` é `true` quando o usuário pressionou Enter.

```lua
tab:AddInput("Digite algo...", function(text, enter)
    if enter then print(text) end
end, {
    Icon    = "edit-3",
    Default = "",
    Height  = 38,
})
```

---

## Toasts

Notificações que aparecem no canto inferior direito da tela.

```lua
win:Toast("Mensagem aqui", "success", 3)
--                          ↑ kind     ↑ duração em segundos
```

| Kind | Cor |
|---|---|
| `"success"` | Verde |
| `"warning"` | Amarelo |
| `"error"` | Vermelho |
| `"info"` | Azul |

---

## Destruir a UI

```lua
win:Destroy()
```

Remove a janela e limpa o blur se estiver ativo.

---

## Referência rápida

```
UI.new(config)                          → Window
win:CreateHomeTab(config)
win:CreateTab(config)                   → Tab
win:Toast(message, kind, duration)
win:Destroy()

tab:AddLabel(text, opts)                → TextLabel
tab:AddSeparator()                      → Frame
tab:AddButton(text, callback, opts)     → TextButton
tab:AddToggle(label, default, cb, opts) → { Get, Set }
tab:AddSlider(label, min, max, def, cb) → { Get, Set }
tab:AddDropdown(label, items, cb, opts) → { Get, Set }
tab:AddInput(placeholder, cb, opts)     → TextBox
```
