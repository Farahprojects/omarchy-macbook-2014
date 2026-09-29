-- Keep only your personal keybinding overrides here. Add new bindings or
-- unbind defaults before replacing them.

-- See current bindings and descriptions:
--   omarchy menu keybindings --print

-- To disable every Omarchy default binding, set this in
-- ~/.config/hypr/hyprland.lua before require("default.hypr.omarchy"), then add
-- only the bindings you want below:
--   omarchy_default_bindings = false

-- To disable all preinstalled app/webapp bindings, set:
--   omarchy_preinstalled_bindings = false

-- Add a new binding.
-- o.bind("SUPER + SHIFT + R", "SSH", "alacritty -e ssh your-server")

-- Change an existing binding by unbinding it first, then binding the key again.
-- This example changes SUPER+SPACE from the launcher to the Omarchy root menu.
-- hl.unbind("SUPER + SPACE")
-- o.bind("SUPER + SPACE", "Omarchy menu", "omarchy-menu toggle root")

-- Disable a default binding without replacing it.
-- hl.unbind("SUPER + SHIFT + B")

-- Logitech MX Keys examples:
-- o.bind("SUPER + SHIFT + S", nil, "omarchy-capture-screenshot")
-- o.bind("SUPER + H", nil, "voxtype record toggle")
-- o.bind("SUPER + PERIOD", nil, "omarchy-shell shell toggle omarchy.emojis")

-- Mac-style screenshot shortcuts. Ctrl is used instead of Command/Super here
-- because Super + Shift + 3/4/5 move windows to those workspaces in Omarchy.
o.bind("CTRL + SHIFT + 3", "Screenshot full screen", "omarchy capture screenshot fullscreen")
o.bind("CTRL + SHIFT + 4", "Screenshot selected area", "omarchy capture screenshot region")
o.bind("CTRL + SHIFT + 5", "Capture menu", "omarchy-menu toggle capture")

-- Handle Foot's two-finger/right click before terminal applications can grab
-- it. Foot's pipe-selected action never runs without highlighted text.
-- Return the event unchanged outside Foot, including interactive shell panels.
o.bind("mouse:273", "Terminal copy/paste menu", function()
  local window = hl.get_active_window()
  local cursor = hl.get_cursor_pos()
  if not window or not cursor or
      (window.class ~= "foot" and window.class ~= "footclient") then
    return { ok = true, pass_event = true }
  end

  local at, size = window.at, window.size
  if cursor.x < at.x or cursor.y < at.y or
      cursor.x >= at.x + size.x or cursor.y >= at.y + size.y then
    return { ok = true, pass_event = true }
  end

  for _, layer in ipairs(hl.get_layers()) do
    if layer.mapped and layer.interactivity > 0 and layer.layer >= 2 and
        cursor.x >= layer.x and cursor.y >= layer.y and
        cursor.x < layer.x + layer.w and cursor.y < layer.y + layer.h then
      return { ok = true, pass_event = true }
    end
  end

  local helper = (os.getenv("HOME") or "") .. "/.local/bin/foot-context-menu"
  local quoted_helper = "'" .. helper:gsub("'", "'\\''") .. "'"
  hl.exec_cmd(quoted_helper .. " " .. window.address .. " </dev/null")
  return { ok = true, pass_event = false }
end, { auto_consuming = true })
