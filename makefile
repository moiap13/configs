CURDIR=$(shell pwd)
ZSH_CUSTOM_PLUGINS=$(HOME)/.oh-my-zsh/custom/plugins
UNAME = $(shell uname)
UNAMEM = $(shell uname -m)

# Replace existing files with the one from this directory
configs: zshrc starship_config
osx: install_omz download_plugins install_starship configs
ubuntu: install_zsh_ubuntu install_omz install_starship resolve_broken_characters download_plugins configs


download_plugins:
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM_PLUGINS}/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM_PLUGINS}/zsh-syntax-highlighting
	git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM_PLUGINS}/zsh-autocomplete
	git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM_PLUGINS}/fast-syntax-highlighting

install_zsh_ubuntu:
	sudo apt update -y
	sudo apt install zsh -y
	@echo ZSH VERSION: $(zsh --version)
	chsh -s $(which zsh)

install_omz:
	cd $(HOME)
	curl -sS https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | sh

install_starship:
	curl -sS https://starship.rs/install.sh | sh

resolve_broken_characters:
	sudo apt install fonts-powerline -y

zshrc:
	rm -f $(HOME)/.zshrc
	cp $(CURDIR)/zsh/.zshrc $(HOME)/.zshrc

starship_config:
	rm -f ~/.config/starship.toml
	cp -r $(CURDIR)/starship/starship.toml $(HOME)/.config/

iterm2:
	cd $CURDIR/iterm2
	defaults read com.googlecode.iterm2

homebrew:
	/bin/bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

thefuck:
	brew install thefuck

asahi_linux:
	curl https://fedora-asahi-remix.org/install | sh

mamba:
	curl -SL# https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(UNAME)-$(UNAMEM).sh -o Miniforge3.sh
	sh Miniforge3.sh
	rm Miniforge3.sh

ech:
	@echo $(CURDIR)
	@echo $(HOME)