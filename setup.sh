#!/bin/bash

install_build_essential() {
	sudo apt install -y build-essential
}

install_zsh() {
	# install zsh
	sudo apt install -y zsh

	# install ohmyzsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

install_nvm() {
	# install nvm
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

	# setup access to NVM
	export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

	# install latest LTS NodeJS + NPM
	nvm install --lts
}

install_docker_debian() {
	# Add Docker's official GPG key:
	sudo apt-get update
	sudo apt-get install ca-certificates curl
	sudo install -m 0755 -d /etc/apt/keyrings
	sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
	sudo chmod a+r /etc/apt/keyrings/docker.asc

	# Add the repository to Apt sources:
	echo \
	  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
	  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
	  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
	sudo apt-get update

	sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

	whoami | xargs sudo usermod -aG docker
}

install_ripgrep() {
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
  sudo dpkg -i ripgrep_14.1.0-1_amd64.deb
  rm ripgrep_14.1.0-1_amd64.deb
}

install_nvim() {
  install_build_essential
  curl -LO https://github.com/neovim/neovim-releases/releases/download/stable/nvim-linux64.deb
  sudo dpkg -i nvim-linux64.deb
  rm nvim-linux64.deb
}

install_unzip() {
  sudo apt install -y unzip
}

install_nvchad() {
  install_nvim
  install_ripgrep
  install_unzip
  git clone https://github.com/NvChad/starter ~/.config/nvim
  rm -rf ~/.config/nvim/.git
  echo "Run :MasonInstallAll after lazy.nvim finishes downloading plugins. Press Enter when ready."
  read
  nvim
}

uninstall_nvchad() {
  rm -rf ~/.config/nvim
  rm -rf ~/.local/state/nvim
  rm -rf ~/.local/share/nvim
}

install_dotnet8() {
  wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  sudo dpkg -i packages-microsoft-prod.deb
  rm packages-microsoft-prod.deb

  sudo apt-get update && \
  sudo apt-get install -y dotnet-sdk-8.0 aspnetcore-runtime-8.0
}

install_tmux() {
    sudo apt install -y tmux

    # install catppuccin
    mkdir -p ~/.config/tmux/plugins/catppuccin
    git clone -b v2.1.0 https://github.com/catppuccin/tmux.git ~/.config/tmux/plugins/catppuccin/tmux
    echo "run ~/.config/tmux/plugins/catpuccin/tmux/catppuccin.tmux" >>~/.tmux.conf

    # install TPM (tmux plugin manager)
    mkdir -p ~/.tmux/plugins
    git clone https://github.com/tmux-plugins/tmp ~/.tmux/plugins/tpm
    cat <<EOF >>~/.tmux.conf
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'

# Initialize TMUX plugin manager *keep this line at the very bottom)
run '~/.tmux/plugins/tpm/tpm'
EOF
}

case "$1" in
  zsh)
    install_zsh
    ;;
  nvm)
    install_nvm
    ;;
  docker)
    install_docker
    ;;
  nvim)
    install_nvim
    ;;
  nvchad)
    install_nvchad
    ;;
  -nvchad)
    uninstall_nvchad
    ;;
  dotnet)
    install_dotnet8
    ;;
  tmux)
    install_tmux
    ;;
  *)
    echo "options: $0 zsh | nvm | docker | dotnet | tmux | nvim | [-]nvchad"
    ;;
esac	
