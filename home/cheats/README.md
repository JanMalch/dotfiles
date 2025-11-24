# Cheatsheets

Cheatsheets are markdown files which can be rendered with the `cheat` function,
located in the [`.zshrc`](../.config/zsh/.zshrc).
It uses `fzf` under the hood, in case you have to cheat on the name of your cheatsheets.

```bash
# opens fzf
$ cheat
# fzf auto selects if there is only one match
$ cheat jq
```
