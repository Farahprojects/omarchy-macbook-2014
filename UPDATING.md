# Updating safely

The installed Omarchy package lives in `/usr/share/omarchy`. The customized
files in this repository live under `~/.config` and `~/.local`, so a normal
system update does not require replacing this repository or switching to a
custom Omarchy package.

## Routine update

```bash
omarchy-update
cd ~/Projects/omarchy-macbook-2014   # adjust if cloned elsewhere
git pull --ff-only
./install.sh
```

## When an upstream config changes

Omarchy's `omarchy-refresh-config` command replaces a user config with the new
packaged default and saves a timestamped backup. For one of the files maintained
here, first capture or commit the current overlay, then refresh and compare:

```bash
./scripts/capture-current.sh
git diff
omarchy-refresh-config hypr/hyprland.lua
diff -u ~/.config/hypr/hyprland.lua.bak.* ~/.config/hypr/hyprland.lua
```

Merge the relevant upstream changes into `home/.config/...`, test them, commit,
and run `./install.sh` again. Do not blindly delete the `.bak.*` file until the
new configuration has been tested.

## Capture future changes

After changing one of the tracked files on the MacBook:

```bash
./scripts/capture-current.sh
git diff --check
git diff
git add .
git commit -m "Describe the MacBook change"
git push
```

The capture script has an explicit allowlist. It does not copy whole browser,
OBS, SSH, cache, history, or state directories.
