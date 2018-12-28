# Will's Dotfiles

## Introduction
My dotfiles are managed by [homesick](https://github.com/technicalpickles/homesick).

## Special instructions
### Sublime symlinks
```
rm ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
ln -s ~/.sublime_user_settings ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/User
```
### VSCode symlinks
```
rm ~/Library/Application\ Support/Code/User/settings.json
rm ~/Library/Application\ Support/Code/User/keybindings.json
rm ~/Library/Application\ Support/Code/User/snippets

ln -s ~/.vscode_user_settings/settings.json ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/.vscode_user_settings/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/.vscode_user_settings/snippets ~/Library/Application\ Support/Code/User/snippets
```
