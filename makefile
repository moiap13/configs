CURDIR=$(shell pwd)
ZSH_CUSTOM_PLUGINS=$(HOME)/.oh-my-zsh/custom/plugins

# Replace existing files with the one from this directory
configs: zsh starship_config
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
	rm install.sh
	cd $(HOME)
	sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

install_starship:
	rm install.sh
	curl -sS https://starship.rs/install.sh | sh

resolve_broken_characters:
	sudo apt install fonts-powerline -y

zshrc:
	rm -f $(HOME)/.zshrc
	cp $(CURDIR)/zsh/.zshrc $(HOME)/.zshrc

starship_config:
	rm -f ~/.config/starship.toml
	cp -r $(CURDIR)/starship/starship.toml $(HOME)/.config/

ech:
	@echo $(CURDIR)
	@echo $(HOME)