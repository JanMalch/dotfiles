# devcontainer

You can use these [Development Containere](https://containers.dev/) to test my setup.

## Ready

The [ready](./ready) container installs and sources all necessary tools, when creating the container.
Use it if you aren't concerned with installation of tooling.

## Bare

The [bare](./bare) container only brings `stow` but nothing else.

After entering the container, run `./setup.sh`.
Then, run `.devcontainer/tooling.sh` to install all the essential tools. 
Please note that the tooling script is designed purely for this Alpine devcontainer.

If you know what you are doing:

```bash
./setup.sh && .devcontainer/bare/tooling.sh && source ~/.zshenv && source ~/.config/zsh/.zshrc
```
