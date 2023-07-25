#!/usr/bin/env zsh

# Asdf install plugin
asdf plugin add nodejs
asdf plugin add python
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
echo 'asdf done!'

asdf install nodejs latest:18
asdf global nodejs latest:18

asdf install python latest
asdf global python latest

asdf install golang latest
asdf global golang latest

asdf install rust latest
asdf global rust latest
