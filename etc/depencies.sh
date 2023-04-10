#!/usr/bin/env zsh
pip install -U pip
pip install -U pynvim
pip install -U cpplint
pip install -U httpie
pip install -U sqlfluff
pip install -U httpie
pip install -U editorconfig-checker

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
npm install -g sass
npm install -g eslint_d

go install github.com/jesseduffield/lazydocker@latest
go install github.com/jesseduffield/lazygit@latest
go install honnef.co/go/tools/cmd/staticcheck@latest
go install github.com/segmentio/golines@latest
go install github.com/go-delve/delve/cmd/dlv@latest
go install golang.org/x/tools/cmd/goimports@latest
go install golang.org/x/tools/gopls@latest

cargo install stylua

asdf reshim nodejs
asdf reshim python
asdf reshim rust
asdf reshim golang
asdf reshim java
