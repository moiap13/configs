CURDIR=$(shell pwd)
HOME=~
ZSH_CUSTOM_PLUGINS=$(HOME)/zsh/.oh-my-zsh/plugins

# Replace existing files with the one from this directory
# and create symlinks for the rest
all: zsh starship

download_plugins:
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM_PLUGINS}/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM_PLUGINS}/zsh-syntax-highlighting
	git clone https://github.com/marlonrichert/zsh-autocomplete.git ${ZSH_CUSTOM_PLUGINS}/zsh-autocomplete
	git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM_PLUGINS}/fast-syntax-highlighting

zsh: #$(CURDIR)/zsh/.zshrc
	ln -sf $(CURDIR)/zsh/.zshrc $(HOME)/.zshrc

starship: #$(CURDIR)/starship/starship.toml
	ln -sf $(CURDIR)/starship/starship.toml $(HOME)/.config/starship.toml

ech:
	@echo $(CURDIR)
	@echo $(HOME)