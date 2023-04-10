#!/usr/bin/env zsh

# Asdf install plugin
asdf plugin add nodejs
asdf plugin add python
asdf plugin add java
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
echo 'asdf done!'

java_version=openjdk-17.0.2

asdf install nodejs lts
asdf global nodejs lts

asdf install python latest
asdf global python latest

asdf install java $java_version
asdf global java $java_version

asdf install golang latest
asdf global golang latest

asdf install rust latest
asdf global rust latest
