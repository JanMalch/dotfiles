# zsh

## `zmv` - mass file renaming

```zsh
zmv '(*).jpeg' '$1.jpg'  # Rename all .jpeg files to .jpg
zmv '(**/)(*).backup' '$1$2'  # Remove .backup extensions recursively
```
