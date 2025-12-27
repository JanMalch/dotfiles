FROM mcr.microsoft.com/devcontainers/base:alpine

RUN sudo apk add atuin bat carapace eza fd fzf delta dust go git-lfs neovim nodejs ripgrep ruby starship stow tmux xclip zoxide
RUN git lfs install


# Use setup_doctor for font downloading, etc.
COPY ./home/scripts/setup_doctor /setup_doctor
RUN sudo sh /setup_doctor && sudo rm /setup_doctor
