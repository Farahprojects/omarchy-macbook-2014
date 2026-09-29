-- Run from the repository root: lua tests/trackpad-menu.lua
-- A compositor-level binding must consume clicks only in Foot's client area.
local callback, command
local window = {
  class = "foot", address = "0x123",
  at = { x = 0, y = 0 }, size = { x = 800, y = 600 },
}
local cursor = { x = 100, y = 100 }
local layers = {}

o = { bind = function(key, _, fn, opts)
  if key == "mouse:273" then
    callback = fn
    assert(opts.auto_consuming)
  end
end }
hl = {
  get_active_window = function() return window end,
  get_cursor_pos = function() return cursor end,
  get_layers = function() return layers end,
  exec_cmd = function(value) command = value end,
}

dofile("home/.config/hypr/bindings.lua")

-- No selected text or terminal mouse state is needed to launch the menu.
assert(callback().pass_event == false)
assert(command:match("foot%-context%-menu.*0x123"))

local function must_pass()
  command = nil
  assert(callback().pass_event == true)
  assert(command == nil)
end

window.class = "chromium"
must_pass()
window.class = "foot"
cursor.x = 900
must_pass()
cursor.x = 100
layers = {{ mapped = true, interactivity = 1, layer = 2,
  x = 0, y = 0, w = 400, h = 400 }}
must_pass()
layers = {}
window = nil
must_pass()
print("PASS: Foot menu and native right-click forwarding")
