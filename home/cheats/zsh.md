# zsh

`Ctrl+Z` to put the current process (like Neovim) in the background.
Enter `fg` to return to the process.

## `zmv` - mass file renaming

```zsh
zmv '(*).jpeg' '$1.jpg'  # Rename all .jpeg files to .jpg
zmv '(**/)(*).backup' '$1$2'  # Remove .backup extensions recursively
```
