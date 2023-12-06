# TODO

- [ ] Figure out how to cleanly handle duplicate files with a single source using chezmoi. I could symlink some or all as one alternative, but I'm unclear on the behavior on Windows.
- [x] Correct the system in flake.nix on darwin. This can be done via chezmoi template, or in nix, perhaps using one of the 'for each system' wrappers to generate all the variants needed.
- [.] Merge in the zsh topics into the main zsh config
- [ ] Update vim paths to use XDG_STATE_HOME
- [ ] Update all paths to use XDG_STATE_HOME and drop any unnecessary XDG bits
- [ ] Go through the full zsh config
- [ ] Merge system-setup into the new dotfiles
- [ ] Consider putting my git config into a file which is included by ~/.config/git/config, but not tracking that file directly, other than to create it if it doesn't exist, and make it include mine. Then git config --global commands wouldn't alter my tracked configuration, only the file which includes it. This would avoid annoyances with safe.directory/credential.helper/etc, especially with vscode.
- [ ] Migrate existing data/state files (e.g. .fasd) in old paths to their new paths in a script

```zsh
if [[ -e dir_colors ]]; then
    if [[ $OSTYPE = WSL ]]; then
        cp -f dir_colors "$XDG_CONFIG_HOME/dir_colors"
        sed -i -e '/^OTHER_WRITABLE/s/04\;/00\;/' "$XDG_CONFIG_HOME/dir_colors"
    else
        link dir_colors "$XDG_CONFIG_HOME/dir_colors"
    fi
fi
```

```zsh
if [ "$OSTYPE" = WSL ] && [ "$INSTALL_DEST" = "$USERPROFILE" ]; then
    WIN_TERM_DIR="$INSTALL_DEST/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe"
    link settings.json "$WIN_TERM_DIR/LocalState/settings.json"
    link files "$WIN_TERM_DIR/RoamingState"
fi
```
