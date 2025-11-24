# devcontainer

You can use this [Development Container](https://containers.dev/) to test my setup.

After entering the container, run `./setup.sh`.
Then, run `.devcontainer/tooling.sh` to install all the essential tools. 
Please note that the tooling script is designed purely for this Alpine devcontainer.

If you know what you are doing:

```bash
./setup.sh && .devcontainer/tooling.sh && source ~/.zshenv && source ~/.config/zsh/.zshrc
```
