# Kergoth's Dotfiles and Setup Scripts

## Usage

### Initial dotfiles setup

This setup will apply the dotfiles, and will also install packages with home-manager, if nix is installed.

If the repository has not yet been cloned:

```console
chezmoi init --apply kergoth/dotfiles-chezmoi
```

If the repository is already cloned and you've changed directory to it:

```console
./script/setup
```

### User Setup

This setup will apply the dotfiles, but will also apply other changes to the current user configuration.

After cloning the repository, and changing directory to it, run:

```console
./script/setup-user
```

On windows (in powershell, not WSL), run this instead:

```console
./script/setup-user.ps1
```

### System Setup

This setup will apply changes to the system as a whole. This may include installing packages through the package manager, installing nix, et cetera. Ideally this should be run prior to setting up the user, and should be run as a user with sudo access.

After cloning the repository, and changing directory to it, run:

```console
./script/setup-system
```

On windows (in powershell, not WSL), run this instead:

```console
./script/setup-system.ps1
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

## Supported Platforms

- Linux. Tested on Arch, Ubuntu, and Debian.
- MacOS.
- FreeBSD.
- Windows.

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
