# Dotfiles

All the configurations for all my (dev) tooling.

The [`setup_doctor`](./home/scripts/setup_doctor#L116) has a comprehensive list of tools to install.
Note that my [`.zshrc`](./home/.config/zsh/.zshrc) and [`scripts` folder](./home/scripts/) also contains a number of utilities.

## Disclaimer

If following these instructions breaks your system you get to keep all the pieces.

## Usage

`git clone` the [repository](https://github.com/JanMalch/dotfiles) to anywhere.
If you want to use [tmux](https://github.com/tmux/tmux/wiki), you should `git clone --recurse-submodules`.
Make sure that the [catppuccin submodule](./home/.config/tmux/plugins) is loaded.
If not, try running `git submodule update --init --recursive`.

Afterwards, run the `setup.sh` script and follow the instructions.

> The `updates.sh` is intended for updating contents in this git repository.

See the [`setup_doctor`](./home/scripts/setup_doctor) to get an idea of which tools are being used.

## Theming

I generally try to use [Catppucino theme](https://catppuccin.com/) with the **Macchiato** flavor.
Also, the [JetBrainsMono Nerd Font](https://www.nerdfonts.com/font-downloads#:~:text=JetBrainsMono) is used wherever possible.

## Beyond

The following tools are not checked or setup, but are handy to have:

- [Obsidian](https://obsidian.md/)
- [LocalSend](https://localsend.org/)
- [LibreOffice](https://www.libreoffice.org/)

## Considerations

The following tools are not used, but maybe I want to use them in the future:

- [direnv](https://direnv.net/)
- [oh my zsh](https://ohmyz.sh/)
- Neovim
  - [minharp.nvim](https://github.com/vieitesss/miniharp.nvim)

## Try it yourself

Want to try this setup yourself?
Clone the repository and checkout the [devcontainer](./.devcontainer/README.md).

## Credit

- [How I manage my dotfiles using GNU Stow - Tamerlan](https://tamerlan.dev/how-i-manage-my-dotfiles-using-gnu-stow/)
- [github.com/omerxx/dotfiles](https://github.com/omerxx/dotfiles/)
- [github.com/MariaSolOs/dotfiles](https://github.com/MariaSolOs/dotfiles)
- [Omarchy Shell Tools](https://learn.omacom.io/2/the-omarchy-manual/57/shell-tools)
- [Oh my tmux!](https://github.com/gpakosz/.tmux)
- [github.com/ibraheemdev/modern-unix](https://github.com/ibraheemdev/modern-unix?tab=readme-ov-file)
