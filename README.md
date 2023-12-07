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
