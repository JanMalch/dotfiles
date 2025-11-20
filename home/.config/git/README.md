# Git

Since the global `git` config might vary by machine,
there's only a `base.gitconfig` which is included in the global git config.

The [`setup_doctor`](../../scripts/setup_doctor) does so automatically by running

```bash
git config --global include.path "\$XDG_CONFIG_HOME/git/base.gitconfig"
```
