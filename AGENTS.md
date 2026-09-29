# MacBook overlay workflow

This repository is Peter's public Omarchy customization backup:
`Farahprojects/omarchy-macbook-2014`, branch `main`.
The normal checkout on the old Mac is `~/Projects/omarchy-macbook-2014`.

For changes here, read
`home/.codex/skills/omarchy-macbook-updates/SKILL.md` and follow its scoped
save, verify, commit, and push workflow. Peter wants requested implemented
MacBook customizations preserved on GitHub unless he says to keep them local.
Read-only questions do not request a change. Fork users choose their own
destination; do not redirect their repositories to Peter's.

Keep user overrides separate from upstream Omarchy packages. Preserve unrelated
working-tree changes and exclude private machine state. After publishing,
verify the remote commit and report it; do not stop at changing live dotfiles.

Peter wants a globally floating/overlapping desktop, not a few floating apps
above a tiled background. Keep `hypr.floating` loaded last in `hyprland.lua`.
Its tag-based rule is intentional: Hyprland rechecks tag-dependent static
rules after class rules, which otherwise lets Omarchy force Chromium back into
tiling. Preserve this preference unless Peter asks to change it. Test both
existing and newly opened windows; reloading alone does not reapply static
floating rules. Include `lua tests/floating-default.lua` in window-rule checks.
