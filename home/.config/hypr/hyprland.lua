-- Learn how to configure Hyprland: https://wiki.hypr.land/Configuring/Start/

-- Omarchy's bootstrap keeps path setup out of this user config.
dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

-- Disable all Omarchy default bindings. Add your own in hypr/bindings.lua.
-- omarchy_default_bindings = false
--
-- Or disable only bindings for Omarchy's preinstalled apps/web apps while
-- keeping core window-manager bindings:
-- omarchy_preinstalled_bindings = false

-- Load Omarchy defaults.
require("default.hypr.omarchy")

-- Put your personal overrides in these files. They're loaded after Omarchy's
-- defaults so package updates can improve the defaults without rewriting your
-- ~/.config/hypr files.
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")

-- Toggle config flags dynamically.
require("default.hypr.toggles")

-- Add any other personal Hyprland configuration below.
-- o.window("qemu", { workspace = "5" })

-- Keep option/property dialogs inside the usable area of the scaled laptop display.
o.window({ modal = true }, {
  float = true,
  center = true,
  max_size = { 1200, 720 },
})

-- Keep production apps as movable, overlapping windows instead of
-- shrinking them into the tiled layout. Other apps keep Omarchy's tiling.
o.window({ class = "^foot$" }, {
  float = true,
  center = true,
  size = { 1050, 680 },
})

o.window({ class = "^chromium$" }, {
  float = true,
  center = true,
  size = { 1200, 820 },
})

o.window({ class = "^org[.]gnome[.]Nautilus$" }, {
  float = true,
  center = true,
  size = { 1200, 820 },
})

o.window({ class = "^org[.]localsend[.]localsend_app$" }, {
  float = true,
  center = true,
  size = { 1200, 820 },
})

-- Match the stable class only: OBS sets its final title after the static float
-- rule has already been evaluated.
o.window({ class = "^com[.]obsproject[.]Studio$" }, {
  float = true,
  center = true,
  size = { 1200, 720 },
  no_max_size = true,
})

-- Qt does not mark every OBS properties window as modal, so constrain its
-- common non-modal settings windows without limiting the main OBS window.
o.window({
  class = "^com[.]obsproject[.]Studio$",
  title = "^(Properties for .+|Filters for .+|Settings|Auto-Configuration Wizard)$",
  float = true,
}, {
  center = true,
  max_size = { 1200, 720 },
})
