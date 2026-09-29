# Updating safely

The installed Omarchy package lives in `/usr/share/omarchy`. The customized
files in this repository live under `~/.config`, `~/.local`, and the selected
Codex skill directory, so a normal
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
# Stage only the reviewed paths belonging to your change:
git add -- home/path/to/changed-file
git commit -m "Describe the MacBook change"
git push origin main
git ls-remote origin refs/heads/main
```

The capture script has an explicit allowlist. It does not copy whole browser,
OBS, SSH, cache, history, or state directories.

Confirm the remote hash matches your intended commit before calling a change
saved on GitHub. Codex follows the repository's `AGENTS.md` and the bundled
`omarchy-macbook-updates` skill for this workflow. The skill is allowlisted;
Codex credentials, conversations, and unrelated global preferences are not.
