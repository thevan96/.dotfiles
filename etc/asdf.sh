#!/bin/bash

# Asdf install plugin
asdf plugin add nodejs
asdf plugin add python
asdf plugin add java
asdf plugin-add golang https://github.com/kennyp/asdf-golang.git
asdf plugin-add rust https://github.com/code-lever/asdf-rust.git
echo 'asdf done!'

node_version=16.16.0
python_version=3.10.6
java_version=openjdk-17.0.2
golang_version=1.19
rust_version=1.63.0

asdf install nodejs $node_version
asdf global nodejs $node_version

asdf install python $python_version
asdf global python $python_version

asdf install java $java_version
asdf global java $java_version

asdf install golang $golang_version
asdf global golang $golang_version

asdf install rust $rust_version
asdf global rust $rust_version
