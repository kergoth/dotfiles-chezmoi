# README

## Implementation Notes

- Chezmoi is used to apply my dotfiles changes.
- A script is run by chezmoi which applies my nix home-manager configuration, if nix is installed.
- .config/git/config is not my main configuration, but is instead a small file
  which includes my main configuration. This allows for automatic git
  configuration changes such as vscode's change to credential.manager to be
  obeyed without it altering my stored git configuration. The downside to this
  is that these changes will not be highly visible. I may change this back, or
  keep the including file but track it so the changes are visible.

## Reminders

- .chezmoitemplates can be used for creating similar but not identical files
- Remember to do a `chmod 0600 "$HOME/.config/chezmoi/chezmoi.toml"` after `chezmoi init`, once I start adding secrets to the chezmoi.toml.

## TODO

- [ ] Add scripts from system-setup, with adjustment
  - [ ] Add an update script which does a chezmoi apply, cd's into ~/.config/home-manager, runs nix flake update, then chezmoi re-add flake.lock, then home-manager switch.

### Chezmoi Setup

- [ ] Determine if it's possible to provide default values for the promptStringOnce entries, but still allow the user to override them without altering files in the dotfiles repo.
