call plug#begin()
set termguicolors
syntax on
set spelllang=en
set encoding=UTF-8
set ff=unix
set noeol
filetype plugin on
filetype indent on
set number relativenumber
set autoread autowrite
set cursorline
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType php        setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType md        setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
set showmatch
set hidden
set incsearch hlsearch ignorecase
set nopaste
set clipboard +=unnamedplus
set nobackup noswapfile
set list
set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set splitbelow splitright
set mouse=a
if exists('&colorcolumn')
  set colorcolumn=80
endif

nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
nnoremap j gj
nnoremap k gk
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
nnoremap <space><space> :nohlsearch<cr>
nnoremap bj :bfirst<cr>
nnoremap bk :blast<cr>
nnoremap bs :new<cr>
nnoremap bv :vnew<cr>
nnoremap bh :bprevious<cr>
nnoremap bl :bnext<cr>
nnoremap bx :Bdelete<cr>
nnoremap tl :tabnext<cr>
nnoremap th :tabprevious<cr>
nnoremap tj :tabfirst<cr>
nnoremap tk :tablast<cr>
nnoremap tx :tabclose<cr>
let mapleader = ','
imap jk <esc>
nnoremap <leader><leader>r :so ~/.config/nvim/init.vim<cr>
nnoremap <leader>qq :qall<cr>
tnoremap <esc> <c-\><c-n>
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-k>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l
nnoremap <a-k> :resize +2<cr>
nnoremap <a-j> :resize -2<cr>
nnoremap <a-l> :vertical resize +2<cr>
nnoremap <a-h> :vertical resize -2<cr>

Plug 'joshdick/onedark.vim'

Plug 'justinmk/vim-sneak'
let g:sneak#s_next = 1

Plug 'ryanoasis/vim-devicons'
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1
let g:WebDevIconsNerdTreeBeforeGlyphPadding = ''

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'jiangmiao/auto-pairs'

Plug 'pbrisbin/vim-mkdir'

Plug 'christoomey/vim-tmux-navigator'

Plug 'thinca/vim-quickrun'
nnoremap <leader>r :QuickRun<cr>

Plug 'majutsushi/tagbar'
Plug 'hushicai/tagbar-javascript.vim'
Plug 'vim-php/phpctags'
nmap tb :TagbarToggle<cr>

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"

Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['┊']

Plug 'AndrewRadev/splitjoin.vim'

Plug 'itchyny/vim-cursorword'

Plug 'terryma/vim-multiple-cursors'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

Plug 'moll/vim-bbye'

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
nnoremap <Leader>ggn :GitGutterNextHunk<CR>
nnoremap <Leader>ggp :GitGutterPrevHunk<CR>

Plug 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
map <leader>b :CtrlPBuffer<cr>

Plug 'wesq3/vim-windowswap'
let g:windowswap_map_keys = 0

Plug 't9md/vim-choosewin'
nmap  -  <Plug>(choosewin)

Plug 'easymotion/vim-easymotion'
map ;; <Plug>(easymotion-overwin-f)
map ;l <Plug>(easymotion-overwin-line)

Plug 'airblade/vim-rooter'

Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
      \ 'branch': 'release/1.x',
      \ 'for': [
      \ 'javascript',
      \ 'typescript',
      \ 'css',
      \ 'less',
      \ 'scss',
      \ 'json',
      \ 'graphql',
      \ 'markdown',
      \ 'vue',
      \ 'lua',
      \ 'php',
      \ 'python',
      \ 'ruby',
      \ 'html',
      \ 'swift' ]
      \ }
nmap <leader>p <plug>(Prettier)

Plug 'stephpy/vim-php-cs-fixer'
let g:php_cs_fixer_rules = "@PSR2"
nnoremap <leader>pcd :call PhpCsFixerFixDirectory()<cr>
nnoremap <leader>pcf :call PhpCsFixerFixFile()<cr>
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer"

Plug 'dense-analysis/ale'
nmap e[ <Plug>(ale_previous_wrap)
nmap e] <Plug>(ale_next_wrap)
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_loclist = 0
let g:ale_lint_on_save = 1
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let b:ale_linters = {
      \ 'javascript': ['standard'],
      \ 'php': ['phpcs']
      \ }
let g:ale_php_phpcs_standard = "psr2"

Plug 'neomake/neomake'
let g:neomake_php_enabled_makers = ['prettier']
let g:neomake_php_prettier_maker = {
      \ 'exe': 'prettier',
      \ 'args': ['--write'],
      \ }

autocmd! BufWritePost * Neomake
augroup my_neomake_hooks
  au!
  autocmd User NeomakeJobFinished :checktime
augroup END


Plug 'neoclide/coc.nvim'
let g:coc_snippet_next = '<tab>'
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-phpls',
      \ 'coc-python',
      \ 'coc-emmet',
      \ 'coc-prettier'
      \ ]
inoremap <expr> <c-space> coc#refresh()
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
vmap f  <Plug>(coc-format-selected)
nmap f  <Plug>(coc-format-selected)


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#ale#enabled = 1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔐'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⌘'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_symbols.readonly = '🔒'

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 25
let NERDTreeMinimalUI = 1
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeCascadeSingleChildDir = 0
highlight! link NERDTreeFlags NERDTreeDir
nnoremap tt :NERDTreeToggle<cr>
nnoremap ff :NERDTreeFind<cr>
nnoremap tr :NERDTreeRefreshRoot<cr>
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ 'Ignored'   : '☒',
      \ "Unknown"   : "?"
      \ }

" Syntax all language programe
Plug 'sheerun/vim-polyglot'

" Python
let g:python_host_prog = '/home/thevan96/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog = '/home/thevan96/.pyenv/versions/neovim3/bin/python'

" Node
let g:node_host_prog='/home/thevan96/.nvm/versions/node/v10.16.3/bin/neovim-node-host'
let g:coc_node_path='/home/thevan96/.nvm/versions/node/v10.16.3/bin/node'

" Ruby
let g:ruby_host_prog ='~/.rbenv/versions/2.6.5/bin/neovim-ruby-host'

" HTML, CSS
Plug 'lilydjwg/colorizer'

Plug 'andymass/vim-matchup'
let g:loaded_matchit = 1

Plug 'ap/vim-css-color'

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0

call plug#end()

" Final setup colorscheme
set background =dark
colorscheme onedark
let g:onedark_terminal_italics=1

" Fix error restore session
set sessionoptions-=folds
set sessionoptions-=options

" Config neovim
function! MyOnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  elsif has('unix')
  return readfile('/sys/class/power_supply/AC/online') == ['0']
endif
return 0
endfunction

if MyOnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('nw', 100)
endif

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Clear register
command! Cr for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
