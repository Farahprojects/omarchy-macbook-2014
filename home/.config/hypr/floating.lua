-- Peter's desktop is a stacking desktop: every normal app floats by default.
-- Load this AFTER upstream and personal app rules. Keep shell layers, modal
-- behaviour, explicit fullscreen, and deliberate manual layout changes intact.
--
-- Hyprland 0.56 rechecks tag-dependent static rules after ordinary class rules.
-- Omarchy's chromium-based-browser tag forces tiling in that second pass, so a
-- plain class=".*", float=true rule is insufficient. Give every window our
-- own tag and put the floating policy last in BOTH passes.
hl.window_rule({
  name = "macbook-stacking-tag",
  match = { class = ".*" },
  tag = "+macbook-stacking",
})

hl.window_rule({
  name = "macbook-stacking-default",
  match = { tag = "macbook-stacking" },
  tile = false,
  float = true,
})
