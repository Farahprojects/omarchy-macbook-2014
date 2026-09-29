# Omarchy on a 2014 MacBook Pro

This repository preserves Peter's working Omarchy configuration for a
`MacBookPro11,1` (13-inch, mid-2014) while keeping Omarchy itself updateable
through the normal `omarchy-update` command.

It is an **overlay**, not a replacement distribution. Omarchy remains installed
and updated from its official packages; this repository contains only the
MacBook-specific hardware settings and user customizations.

## What is included

- Movable, overlapping windows by default for all normal applications, including
  Terminal, Chromium, Files, LocalSend, and OBS. Clicking an exposed window
  brings it above other ordinary windows instead of leaving it underneath a
  floating app. Explicit fullscreen and special desktop panels remain separate.
- Dialog sizing and centering that fit the scaled 13-inch display.
- Trackpad-friendly border resizing and three-finger drag.
- A two-finger/right-click Copy/Paste menu in Foot, available without selecting
  text first and inside terminal applications that capture mouse clicks.
- Mac-style screenshot shortcuts (`Ctrl+Shift+3/4/5`).
- A `1.6` internal-display scale for the 2560×1600 Retina panel.
- Custom Omarchy Shell display and notification plugins.
- A dismiss button on notification toasts and timed Stay Awake controls.
- LocalSend and Voxtype user services.
- FaceTime HD, Apple keyboard, fan-control, Wi-Fi, and optional Thunderbolt
  notes/configuration.
- An optional OBS launcher that warms up a DJI Pocket 3 UVC stream before OBS
  starts.
- A Codex skill that preserves requested MacBook customizations in this
  repository, validates them, and verifies the GitHub push.

The snapshot was captured from Omarchy `4.0.4` on 29 September 2026.

The global stacking policy lives in `home/.config/hypr/floating.lua` and loads
last. It overrides Omarchy's tag-based browser tiling rule as well as ordinary
class rules. It sets the default when a window opens; deliberate manual tiling
remains available. Existing tiled windows need to be floated once or reopened
after first installing this policy; a config reload alone does not reapply
static window rules.

## Install

On an existing Omarchy installation:

```bash
git clone https://github.com/Farahprojects/omarchy-macbook-2014.git
cd omarchy-macbook-2014
./install.sh
```

The installer backs up every replaced user file under
`~/.local/state/omarchy-macbook-2014/backups/` before applying the overlay.

Hardware configuration is deliberately separate because it requires root and
may not suit every MacBook:

```bash
./install.sh --system
```

Thunderbolt networking is optional and is not enabled by default:

```bash
./install.sh --system --thunderbolt
```

## Staying current with Omarchy

Continue updating Omarchy normally:

```bash
omarchy-update
```

The package update and this overlay are independent. After a major Omarchy
release, see [UPDATING.md](UPDATING.md) before refreshing any customized config
from `/usr/share/omarchy/config`.

## Codex on the MacBook

The overlay installs `omarchy-macbook-updates` under
`~/.codex/skills/`. The repository's `AGENTS.md` routes Codex to the same
workflow. Peter's Mac also has the scoped
[global instruction fragment](docs/codex-global-instructions.md) in
`~/.codex/AGENTS.md`, so the destination is known even when Codex starts outside
the checkout. Merge that fragment with existing instructions when setting up
Peter's workflow again; do not replace unrelated global instructions.

Restart an already-open Codex CLI session once after adding global instructions.
The skill can also be requested explicitly as `$omarchy-macbook-updates`.
Other users should select their own fork and credentials before publishing.
Authentication is local to each machine and is never included in this overlay.

## Privacy

This repository intentionally excludes browser profiles, histories, SSH keys,
OBS profiles and service credentials, network addresses, disk identifiers,
device serials, and other machine state. Review changes before publishing a new
snapshot.

## Upstream

Omarchy is maintained by Basecamp at
[basecamp/omarchy](https://github.com/basecamp/omarchy). This project is an
unofficial hardware/configuration overlay and is not affiliated with Basecamp.

## License

MIT. See [LICENSE](LICENSE).
