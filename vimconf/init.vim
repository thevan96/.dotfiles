"--- General setting ---
set nocompatible
set nobackup
set noswapfile
set encoding=utf-8

set autoread
set autowrite

set hlsearch
set incsearch
set ignorecase
set smartcase

set list
set listchars=tab:>\ ,trail:-
set fillchars=vert:\|

set number
set norelativenumber

set laststatus=2
set signcolumn=yes

set wildmenu
set wildmode=longest,list

set textwidth=80
set colorcolumn=+1

set cursorline
set cursorlineopt=number

set backspace=indent,eol,start
set completeopt=menu,menuone,noselect

" Status line
set statusline=
set statusline+=%<%f\ %h%m%r
set statusline+=%{FugitiveStatusline()}
set statusline+=%=
set statusline+=%-14.(%l,%c%V%)\ %P

" Other
set mouse=a
set showmatch
set autoindent
set matchtime=0
set nofoldenable
set diffopt=vertical

" Netrw
let g:netrw_banner = 1
let g:netrw_cursor = 0
let g:netrw_keepdir= 0
let g:netrw_localcopydircmd = 'cp -r'

" Disable
let html_no_rendering = 1
nnoremap S <nop>

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab | retab

" Set keymap
let mapleader = ' '
let g:root_cwd = getcwd()

" Customizer mapping
nnoremap Y y$
nnoremap gp `[v`]
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
command! BufCurOnly execute '%bdelete|edit#|bdelete#'

nnoremap <silent><leader>D :bd!<cr>
nnoremap <silent><C-l> :nohl<cr>:redraw!<cr>
nnoremap <silent><leader>m m`:set relativenumber!<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
nnoremap <silent><leader>so :source $MYVIMRC<cr>:echo 'Reload vim done!'<cr>
inoremap <C-d> <esc>:call setline('.',substitute(getline(line('.')),'^\s*',
      \ matchstr(getline(line('.')-1),'^\s*'),''))<cr>I

" File manager netrw
command! Ex execute 'JumpFile'
command! Ve execute 'vsp+JumpFile'
command! Se execute 'sp+JumpFile'
command! Root execute 'cd ' fnameescape(g:root_cwd)

" Mapping copy clipboard and past
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>
nnoremap <leader>p o<esc>"+p
nnoremap <leader>P O<esc>"+p
vnoremap <leader>p "+p

" Better indent
xnoremap < <gv
xnoremap > >gv

" Navigate quickfix, buffers
nnoremap <tab>o :copen<cr>
nnoremap <tab>x :cclose<cr>
nnoremap <tab>k :cprev<cr>
nnoremap <tab>j :cnext<cr>
nnoremap <tab>K :cfirst<cr>
nnoremap <tab>J :clast<cr>

" Open in tab terminal
nnoremap <leader>"
      \ :silent exe(':!tmux split-window -v -p 40 -c '.expand('%:p:h'))<cr>
nnoremap <leader>%
      \ :silent exe(':!tmux split-window -h -p 50 -c '.expand('%:p:h'))<cr>
nnoremap <leader>c
      \ :silent exe(':!tmux new-window -c '. expand('%:p:h').' -a')<cr>

call plug#begin()

"--- Core plugins ---

" Lsp
Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'andersevenrud/cmp-tmux'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
inoremap <C-n> <Cmd>lua require('cmp').complete()<cr>

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" Linter and format
Plug 'jose-elias-alvarez/null-ls.nvim'

" Fuzzy search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
nnoremap <leader>i :Root<cr><cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>N :Root<cr><cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>n :Root<cr><cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>I :Root<cr><cmd>lua require('telescope.builtin').find_files({
      \ prompt_title = 'Find directory',
      \ find_command = { 'fdfind', '--type', 'd' },
      \ cwd = vim.fn.getcwd(),
      \ })<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>l
      \ :Root<cr><cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>L
      \ :Root<cr><cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>

" Itegrated git
Plug 'tpope/vim-fugitive'
nnoremap <leader>< :diffget //2<cr>:diffupdate<cr>
nnoremap <leader>> :diffget //3<cr>:diffupdate<cr>

" Test
Plug 'vim-test/vim-test'
let test#strategy = 'basic'
nmap <leader>tf :TestFile<cr>
nmap <leader>tn :TestNearest<cr>
nmap <leader>tl :TestLast<cr>
nmap <leader>ts :TestSuite<cr>

" Generate document comment
Plug 'kkoomen/vim-doge'
let g:doge_enable_mappings= 1
let g:doge_mapping = '<leader>d'

"--- Other plugins ---
" Plug 'mattn/emmet-vim'
Plug 'j-hui/fidget.nvim'
Plug 'AndrewRadev/tagalong.vim'
" Plug 'stefandtw/quickfix-reflector.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'
let g:plantuml_previewer#debug_mode = 1
let g:plantuml_previewer#plantuml_jar_path =
      \ expand('$HOME/.config/plantuml/plantuml-1.2022.6.jar')

Plug 'vimwiki/vimwiki'
let g:vimwiki_auto_header = 1
let g:vimwiki_list = [{
      \   'path': '~/Workspace/Personal/notes/',
      \   'template_path': '~/.dotfiles/templates/',
      \   'template_default': 'template',
      \   'template_ext': '.html'
      \ }]

Plug 'preservim/vimux'
let g:VimuxHeight = '50'
let g:VimuxOrientation = 'h'
nnoremap <silent><leader>ro :VimuxOpenRunner<cr>
nnoremap <silent><leader>rc :VimuxPromptCommand<cr>
nnoremap <silent><leader>rx :VimuxCloseRunner<cr>
nnoremap <silent><leader>rl :VimuxRunLastCommand<cr>
nnoremap <silent><leader>rL :VimuxClearTerminalScreen<cr>
vnoremap <silent><leader>rr "vy :call VimuxRunCommand(@v, 1)<cr>gv
nnoremap <silent><leader>rr :call VimuxRunCommand(getline('.') . "\n", 1)<cr>
autocmd FileType sql nnoremap <silent><leader>ri
      \ :call VimuxRunCommand('\i '.expand('%'))<cr>

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"--- Config Provider ---
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
call plug#end()

"--- Customize theme ---
syntax off
set background=dark
filetype plugin indent on

hi clear Error
hi clear SignColumn
hi clear VertSplit

hi NonText                        ctermfg=none     ctermbg=none     cterm=none
hi Normal                         ctermfg=none     ctermbg=none     cterm=none
hi Pmenu                          ctermfg=white    ctermbg=black    cterm=none
hi PmenuSel                       ctermfg=black    ctermbg=blue     cterm=none

hi LineNr                         ctermfg=darkgray ctermbg=none     cterm=none
hi LineNrAbove                    ctermfg=darkgray ctermbg=none     cterm=none
hi LineNrBelow                    ctermfg=darkgray ctermbg=none     cterm=none
hi CursorLineNr                   ctermfg=none     ctermbg=none     cterm=none

hi ColorColumn                    ctermfg=none     ctermbg=black
hi SpecialKey                     ctermfg=darkgray ctermbg=none     cterm=none
hi Whitespace                     ctermfg=darkgray ctermbg=none     cterm=none

hi DiagnosticError                ctermfg=red      ctermbg=none     cterm=none
hi DiagnosticWarn                 ctermfg=yellow   ctermbg=none     cterm=none
hi DiagnosticInfo                 ctermfg=blue     ctermbg=none     cterm=none
hi DiagnosticHint                 ctermfg=green    ctermbg=none     cterm=none

hi DiagnosticSignError            ctermfg=red      ctermbg=none     cterm=none
hi DiagnosticSignWarn             ctermfg=yellow   ctermbg=none     cterm=none
hi DiagnosticSignInfo             ctermfg=blue     ctermbg=none     cterm=none
hi DiagnosticSignHint             ctermfg=green    ctermbg=none     cterm=none

hi DiagnosticFloatingError        ctermfg=red      ctermbg=none     cterm=none
hi DiagnosticFloatingWarning      ctermfg=yellow   ctermbg=none     cterm=none
hi DiagnosticFloatingInformation  ctermfg=blue     ctermbg=none     cterm=none
hi DiagnosticFloatingHint         ctermfg=green    ctermbg=none     cterm=none

"--- Etc ---
function! Mkdir()
  let dir = expand('%:p:h')
  if dir =~ '://'
    return
  endif

  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction

function! JumpFile()
  let file_name = expand('%:t')
  e %:p:h
  call search(file_name)
endfunction
command! JumpFile call JumpFile()

function! NetrwSetting()
  autocmd BufLeave <buffer> cd `=g:root_cwd`
  nnoremap <silent><buffer> u <nop>
  nnoremap <silent><buffer> U <nop>
  nnoremap <silent><buffer> s <nop>
  nnoremap <silent><buffer> <C-l> :nohl<cr>:e .<cr>
  nnoremap <silent><buffer> g? :h netrw-quickhelp<cr>
  nnoremap <silent><buffer> mL :echo join(
        \ netrw#Expose('netrwmarkfilelist'), "\n")<cr>
endfunction

augroup ChangeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup SettingTabSpace
  autocmd!
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 expandtab | retab
  autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab | retab
  autocmd FileType snippets setlocal tabstop=2 shiftwidth=2 expandtab | retab
augroup end

augroup RunFile
  autocmd!
  autocmd FileType vimwiki nnoremap <leader>va :VimwikiAll2HTML<cr>
  autocmd FileType vimwiki nnoremap <leader>vf :Vimwiki2HTML<cr>
  autocmd FileType vimwiki nnoremap <leader>vb :Vimwiki2HTMLBrowse<cr>
  autocmd FileType vimwiki nnoremap <leader>R :!node %<cr>
  autocmd FileType javascript vnoremap <leader>R :w !node<cr>
  autocmd FileType javascript nnoremap <leader>R :!node %<cr>
  autocmd FileType python vnoremap <leader>R :w !python<cr>
  autocmd FileType python nnoremap <leader>R :!python %<cr>
  autocmd FileType cpp nnoremap <leader>R
        \ :!g++ -std=c++17 -O2 -Wall -Wshadow % -o %:r<cr>
augroup end

augroup LoadFile
  autocmd!
  autocmd FocusGained * redraw!
  autocmd VimResized * wincmd =
  autocmd CursorMoved,CursorMovedI * setlocal norelativenumber

  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save position cursor

  autocmd BufWritePre * call Mkdir()
  autocmd BufWritePre * silent! :%s#\($\n\s*\)\+\%$## " trim endlines
  autocmd BufWritePre * silent! :%s/\s\+$//e " trim whitespace
  autocmd BufWritePre * silent! :g/^\_$\n\_^$/d " single blank line

  autocmd BufNew,BufRead *.uml set ft=uml
  autocmd BufNew,BufRead,BufWritePost .editorconfig :EditorConfigReload
  autocmd BufNew,BufRead,BufWritePost diary.wiki :VimwikiDiaryGenerateLinks

  autocmd FileType netrw call NetrwSetting()
augroup end

"--- Load lua---
lua << EOF
  require 'module_treesitter'
  require 'module_lspconfig'
  require 'module_cmp'
  require 'module_telescope'
  require 'module_null_ls'

  -- Without config
  require 'fidget'.setup()
EOF
