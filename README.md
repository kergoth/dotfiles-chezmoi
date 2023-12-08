# README

## Usage

### Initial setup

If the repository has not yet been cloned:

```console
chezmoi init --apply kergoth/dotfiles-chezmoi
```

If the repository is already cloned:

```console
./script/bootstrap
```

### Edit dotfiles

```console
chezmoi edit --watch ~/.config/zsh/.zshrc
```

### Apply dotfiles changes to the home directory

This step is implicitly done by the boostrap script. To run it manually, for example, after editing files inside the repository checkout, run this:

```console
chezmoi apply
```

### Update the dotfiles, including external files

```console
chezmoi update -R
```

### Update the dotfiles, external files, and home directory packages

```console
./script/update
```

## Implementation Notes

- Chezmoi is used to apply my dotfiles changes.
- A script is run by chezmoi which applies my nix home-manager configuration, if nix is installed.
- .config/git/config is not my main configuration, but is instead a small file
  which includes my main configuration. This allows for automatic git
  configuration changes such as vscode's change to credential.manager to be
  obeyed without it altering my stored git configuration. The downside to this
  is that these changes will not be highly visible. I may change this back, or
  keep the including file but track it so the changes are visible.

## Reference

### Chezmoi Usage

- [Handle different file locations on different systems with the same contents](https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/#handle-different-file-locations-on-different-systems-with-the-same-contents)
- [Use completely different dotfiles on different machines](https://www.chezmoi.io/user-guide/manage-machine-to-machine-differences/#use-completely-different-dotfiles-on-different-machines)

## Reminders

- .chezmoitemplates can be used for creating similar but not identical files
- Remember to do a `chmod 0600 "$HOME/.config/chezmoi/chezmoi.toml"` after `chezmoi init`, once I start adding secrets to the chezmoi.toml.
