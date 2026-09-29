---
name: omarchy-macbook-updates
description: Preserve and publish Peter's 2014 MacBook Omarchy customizations to Farahprojects/omarchy-macbook-2014. Use when changing this MacBook's desktop, trackpad, terminal copy/paste, hardware configuration, or this overlay and its Codex workflow. Do not use for unrelated application projects or general Linux questions.
---

# Save the MacBook customizations

## Destination and intent

- Repository: https://github.com/Farahprojects/omarchy-macbook-2014
- Peter's checkout: `$HOME/Projects/omarchy-macbook-2014` (`/home/peter/Projects/omarchy-macbook-2014` on `omac`).
- Publish branch: `main`; remote: `origin`. HTTPS and SSH URLs for this exact repository are equivalent.
- Peter's standing preference: when he requests an implemented Omarchy/MacBook customization, also preserve the relevant changes here, commit, and push after verification. A later request to keep work local overrides this preference. Questions, diagnosis, and reviews alone do not authorize changes or pushes.
- This is a user-configuration overlay, not an Omarchy distribution fork. Keep normal `omarchy-update` working; don't modify packaged defaults in `/usr/share/omarchy` to implement personal settings.
- On somebody else's installation or fork, do not silently change their remote or try to publish to Peter's repository. Establish their intended destination first.

## Preserve the requested change

Read the checkout's `AGENTS.md` and `UPDATING.md`. Confirm the checkout, remote, branch, and existing dirty files before editing. Fetch `origin`; fast-forward a clean `main` if necessary. Preserve unrelated work. Stop for conflicts or divergent history; do not reset, force-push, or blindly stash someone's changes.

Live files are under `$HOME/.config` and `$HOME/.local`; their portable copies belong under `home/` in the repository. Selected `/etc` hardware settings belong under `system/etc/`. The skill itself is `home/.codex/skills/omarchy-macbook-updates/SKILL.md`.

For a small fix, copy only its changed files into their matching overlay paths. `scripts/capture-current.sh` is available for a requested broader snapshot, but review its whole diff: it can pick up unrelated live changes and does not capture deletions or new paths automatically. Add new portable files to its allowlist when appropriate. Keep the live setting and its repository copy consistent; back up an existing live file before replacing it. Do not run the full overlay installer merely to apply one small fix.

This repository is public. Never publish credentials, SSH keys, Codex authentication/configuration/history, network addresses, browser or OBS profiles, or device serials. In particular, preserve the portable camera lookup in `.local/bin/obs-dji-prewarm`; a raw copy of the live helper may contain a camera-specific identifier. Global Codex instructions may contain unrelated private preferences: maintain only this workflow's template in `docs/codex-global-instructions.md`, not a snapshot of the whole global file.

## Verify and publish

Run `git diff --check` and checks relevant to the actual changes. For terminal/trackpad work, run `lua tests/trackpad-menu.lua`, shell syntax checks for the helper, and Foot/Hyprland checks available on the target Mac. An actual two-finger gesture still needs physical confirmation; don't claim a human interaction was tested from syntax or mocks alone.

Review `git diff`, including untracked files, for correctness and private data. Stage only the task's paths, inspect `git diff --cached`, and commit a clear description. Use `git push origin main` from the intended `main` checkout. Never push unrelated commits without reviewing their scope.

On Peter's Mac the checkout can use a repository-specific SSH deploy key through its local `core.sshCommand`. Git can push even when `gh auth status` says GitHub CLI is not logged in. Keep that private key outside the repository; do not publish it or replace working access with a broad personal token.

Verify the pushed commit against `git ls-remote origin refs/heads/main` (and fetch/reconcile if someone pushed concurrently). Report the repository and commit only after GitHub confirms the update. If authentication, network, tests, or conflicts prevent publishing, retain the work and state precisely what remains unsaved on GitHub. Do not call a local-only change "backed up".
