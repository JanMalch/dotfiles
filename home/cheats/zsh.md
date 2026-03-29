# zsh

`Ctrl+Z` to put the current process (like Neovim) in the background.
Enter `fg` to return to the process.

## [Tricks](https://blog.hofstede.it/shell-tricks-that-actually-make-life-easier-and-save-your-sanity/)

- `$_` expands to last argument of the previous command
- `!!` expands to the entirety of your previous command, so `sudo !!`
- `fc` opens your previous command in your `$EDITOR` and then runs it
- `ESC + .` (or `ALT + .`) inserts the last argument of the previous command right at your cursor (repeatable)
- Brace Expansion
   - Backup Expansion: `cp pf.conf{,.bak}` == `cp pf.conf pf.conf.bak`
   - Rename Trick: `mv filename.{txt,md}` == `mv filename.txt filename.md`
- Process Substitution: `<(command)` treats the output of a command as if it were a file, so `diff <(sort file1.txt) <(sort file2.txt)`
- The Everything Logger: `command |& tee file.log`. `|&` pipes both stdout and stderr (it's a helpful shorthand for `2>&1 |`). 

## `zmv` - mass file renaming

```zsh
zmv '(*).jpeg' '$1.jpg'  # Rename all .jpeg files to .jpg
zmv '(**/)(*).backup' '$1$2'  # Remove .backup extensions recursively
```
