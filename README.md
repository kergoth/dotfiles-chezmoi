# Kergoth's Dotfiles and Setup Scripts

This repository includes scripts for setting up systems per my personal
preferences.

## Prerequisites

- (On macOS) Command-Line Tools or XCode must be installed (See scripts/extras/ for scripts to install these).

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

## Help

Questions and comments are always welcome, please open an issue.

## Contributing

Contributions of all kinds, including feedback, are always welcome!

See [CONTRIBUTING.md](CONTRIBUTING.md) for ways to get started.

Please adhere to this project's [Code of Conduct](CODE_OF_CONDUCT.md) and follow [The Ethical Source Principles](https://ethicalsource.dev/principles/).

## See Also

### Superseded Projects

- [system-setup](https://github.com/kergoth/system-setup)
- [mac-setup](https://github.com/kergoth/mac-setup)
- [win-setup](https://github.com/kergoth/win-setup)
- [dotfiles/system-setup](https://github.com/kergoth/dotfiles/tree/d9bdcb2187ea66847a21ebd6591c0f1ec1a3f0a5/system-setup)

### Partially Superseded Projects

- [arch-setup](https://github.com/kergoth/arch-setup)
