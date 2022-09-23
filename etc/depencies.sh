#!/bin/bash

pip install --upgrade pip
pip install -U pynvim
pip install -U Send2Trash
pip install -U cpplint
pip install -U httpie

npm install -g npm@latest
npm install -g neovim
npm install -g prettier
npm install -g standard
npm install -g semistandard
npm install -g kill-port
npm install -g browser-sync
npm install -g pyright
npm install -g yarn
npm install -g tree-sitter-cli
npm install -g typescript
npm install -g pnpm
npm install -g tree-sitter-cli
npm install -g sass

go install github.com/jesseduffield/lazygit@latest
go install github.com/jesseduffield/lazydocker@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install github.com/segmentio/golines@latest
go install github.com/go-delve/delve/cmd/dlv@latest

asdf reshim nodejs
asdf reshim python
asdf reshim rust
asdf reshim golang
asdf reshim java
