# TODO

- [ ] Merge in the zsh topics into the main zsh config
- [ ] Update vim paths to use XDG_STATE_HOME
- [ ] Update all paths to use XDG_STATE_HOME and drop any unnecessary XDG bits
- [ ] Go through the full zsh config

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
