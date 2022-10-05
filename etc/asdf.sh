#!/bin/bash

# Asdf install plugin
asdf plugin add nodejs
asdf plugin add python
asdf plugin add java
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
echo 'asdf done!'

java_version=openjdk-17.0.2

asdf install nodejs lts
asdf global nodejs lts

asdf install python latest
asdf global python latest

asdf install ruby latest
asdf global ruby latest

asdf install java $java_version
asdf global java $java_version

asdf install golang latest
asdf global golang latest

asdf install rust latest
asdf global rust latest
