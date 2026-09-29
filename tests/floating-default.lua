-- Run from the repository root: lua tests/floating-default.lua
-- Model the two static-rule passes in Hyprland 0.56's WindowRuleApplicator.
-- In particular, tag-dependent rules are rechecked after ordinary class rules.
local baseline = {
  { match = { class = "chromium" }, tag = "+chromium-based-browser" },
  { match = { tag = "chromium-based-browser" }, tile = true },
  { match = { class = "chromium" }, float = true },
}
local policy = {}
hl = { window_rule = function(rule) policy[#policy + 1] = rule end }
dofile("home/.config/hypr/floating.lua")

local function evaluate(class, custom)
  local rules = {}
  for _, rule in ipairs(baseline) do rules[#rules + 1] = rule end
  for _, rule in ipairs(custom) do rules[#rules + 1] = rule end
  local floating, tags = false, {}
  local function matches(rule)
    local match = rule.match
    return (not match.class or match.class == ".*" or match.class == class)
      and (not match.tag or tags[match.tag])
  end
  local function apply_static(rule)
    if rule.float ~= nil then floating = rule.float end
    if rule.tile ~= nil then floating = not rule.tile end
  end
  for _, rule in ipairs(rules) do
    if matches(rule) then
      apply_static(rule)
      if rule.tag then
        assert(rule.tag:sub(1, 1) == "+", "Test only models additive tags")
        tags[rule.tag:sub(2)] = true
      end
    end
  end
  for _, rule in ipairs(rules) do
    if rule.match.tag and matches(rule) then apply_static(rule) end
  end
  return floating
end

-- Reproduce the regression: even a last class-only float rule loses.
assert(not evaluate("chromium", {}))
assert(not evaluate("chromium", {{ match = { class = ".*" }, float = true }}))

for _, class in ipairs({
  "chromium", "com.obsproject.Studio", "org.localsend.localsend_app",
  "foot", "footclient", "org.gnome.Nautilus", "a-new-app", "",
}) do
  assert(evaluate(class, policy), "Expected global floating default: " .. class)
end
print("PASS: global floating wins after tag recheck for browsers and other apps")
