FROM mcr.microsoft.com/devcontainers/base:alpine

RUN sudo apk add bat carapace eza fastfetch fd ffmpeg fzf delta dust dysk go git-lfs imagemagick lazygit neovim nodejs npm ripgrep starship stow xclip zoxide
RUN git lfs install


# Use setup_doctor for font downloading, etc.
COPY ./home/scripts/setup_doctor /setup_doctor
RUN sudo sh /setup_doctor && sudo rm /setup_doctor
