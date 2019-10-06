call plug#begin()

set spelllang=en
set encoding=UTF-8
set ff=unix
set noeol
syntax on
filetype plugin on
filetype indent on
set number relativenumber
set autoread autowrite
set cursorline
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType php        setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
if exists('&colorcolumn')
  set colorcolumn=80
endif
set showmatch
set hidden
set incsearch hlsearch ignorecase
set nopaste
set clipboard +=unnamedplus
set nobackup noswapfile
set list
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:.
set splitbelow splitright

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
nnoremap <silent> j gj
nnoremap <silent> k gk
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
nnoremap <silent> <leader><space> :nohlsearch<cr>
nnoremap <silent> bj :bfirst<cr>
nnoremap <silent> bk :blast<cr>
nnoremap <silent> bs :new<cr>
nnoremap <silent> bv :vnew<cr>
nnoremap <silent> bh :bprevious<cr>
nnoremap <silent> bl :bnext<cr>
nnoremap <silent> bx :bdelete <cr>
nnoremap <silent> bd :Bdelete <cr>
nnoremap <silent> tl :tabnext<cr>
nnoremap <silent> th :tabprevious<cr>
nnoremap <silent> tj :tabfirst<cr>
nnoremap <silent> tk :tablast<cr>
nnoremap <silent> tx :tabclose<cr>
map < <gv
vmap > >gv
imap jk <Esc>
tnoremap jk <c-\><c-n>
let mapleader = ","
nnoremap <leader>qq :SClose<cr>
tnoremap <esc> <c-\><c-n>
tnoremap <c-h> <c-\><c-n><C-w>h
tnoremap <c-j> <c-\><c-n><C-w>j
tnoremap <c-k> <c-\><c-n><C-w>k
tnoremap <c-l> <c-\><c-n><C-w>l
nnoremap <up> :resize +2<cr>
nnoremap <down> :resize -2<cr>
nnoremap <right> :vertical resize +2<cr>
nnoremap <left> :vertical resize -2<cr>

Plug 'joshdick/onedark.vim'

Plug 'mklabs/split-term.vim'

Plug 'honza/vim-snippets'

Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"

Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['┊']

Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-surround'

Plug 'bronson/vim-trailing-whitespace'

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

Plug 'enricobacis/vim-airline-clock'
let g:airline#extensions#clock#format = '%H:%M:%S|%d/%m/%Y'
let g:airline#extensions#clock#updatetime = 1000
let g:airline#extensions#clock#auto = 0
function! AirlineInit()
  let g:airline_section_z = airline#section#create(['clock', g:airline_symbols.space, g:airline_section_z])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

Plug 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
map <leader>b :CtrlPBuffer<cr>

Plug 'mhinz/vim-startify'
let NERDTreeHijackNetrw = 1
let g:startify_session_persistence = 1
autocmd VimEnter *
      \ if !argc()
      \ |   Startify
      \ |   NERDTree
      \ |   wincmd w
      \ | endif
let g:startify_session_before_save = [
      \ 'echo "Cleaning up before saving.."',
      \ 'silent! NERDTreeTabsClose'
      \ ]

let g:ascii = [
      \ '   __    _  _______  _______  __   __  ___   __   __',
      \ '  |  |  | ||       ||       ||  | |  ||   | |  |_|  |',
      \ '  |   |_| ||    ___||   _   ||  |_|  ||   | |       |',
      \ '  |       ||   |___ |  | |  ||       ||   | |       |',
      \ '  |  _    ||    ___||  |_|  ||       ||   | |       |',
      \ '  | | |   ||   |___ |       | |     | |   | | ||_|| |',
      \ '  |_|  |__||_______||_______|  |___|  |___| |_|   |_|',
      \ '',
      \ '  " To get what you want you have to deserve what you want.',
      \ '    The world is not yet a crazy world to reward undeserving people."',
      \ '    >  Charlie Munger'
      \ ]

let g:startify_custom_header = g:ascii
let g:startify_files_number = 3
let g:startify_lists = [
      \ { 'header': ['   MRU'],            'type': 'files' },
      \ { 'header': ['   Sessions'],       'type': 'sessions' },
      \ ]

Plug 't9md/vim-choosewin'
nmap  -  <Plug>(choosewin)

Plug 'wesq3/vim-windowswap'

Plug 'easymotion/vim-easymotion'
map <silent> ;; <Plug>(easymotion-overwin-f)
map <silent> ;l <Plug>(easymotion-overwin-line)

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
let g:neomake_php_enabled_makers = ['prettier', 'phpcsfixer']

Plug 'stephpy/vim-php-cs-fixer'
let g:php_cs_fixer_rules = "@PSR2"
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<cr>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<cr>
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer"

Plug 'thinca/vim-quickrun'
map <leader>r :QuickRun<cr>

Plug 'dense-analysis/ale'
nmap <silent> e[ <Plug>(ale_previous_wrap)
nmap <silent> e] <Plug>(ale_next_wrap)
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:ale_sign_column_always = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale_set_loclist = 0

let b:ale_linters = {
      \ 'javascript': ['standard'],
      \ 'php': ['phpcs']
      \ }
let g:ale_php_phpcs_standard = "psr2"

Plug 'neomake/neomake'
let g:neomake_javascript_enabled_makers = ['standard']
let g:neomake_javascript_standard_maker = {
      \ 'exe': 'standard',
      \ 'args': ['--fix'],
      \ }

let g:neomake_php_enabled_makers = ['prettier', 'phpcsfixer']
let g:neomake_php_prettier_maker = {
      \ 'exe': 'prettier',
      \ 'args': ['--write'],
      \ }
let g:neomake_php_phpcsfixer_maker = {
      \ 'exe': 'php-cs-fixer',
      \ 'args': ['fix', '--rules=@PSR2'],
      \ }

autocmd! BufWritePost * Neomake
augroup my_neomake_hooks
  au!
  autocmd User NeomakeJobFinished :checktime
augroup END

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
let g:EditorConfig_core_mode = 'external_command'

Plug 'neoclide/coc.nvim'
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-phpls',
      \ 'coc-python',
      \ 'coc-snippets',
      \ 'coc-emmet',
      \ 'coc-prettier'
      \ ]
inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
set statusline^=%{coc#status()}%{StatusDiagnostic()}

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
let g:airline_symbols.maxlinenr = '㏑'
let g:airline_symbols.branch = '⌘'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.readonly = '🔒'

Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeWinPos = "left"
let g:NERDTreeWinSize = 25
let NERDTreeMinimalUI = 1
nnoremap tt :NERDTreeToggle<cr>
nnoremap ff :NERDTreeFind<cr>
nnoremap tr :NERDTreeRefreshRoot<cr>
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer = 1
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
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '~/.pyenv/shims/python3'

" Node
let g:node_host_prog='/home/thevan/.nvm/versions/node/v10.16.3/bin/neovim-node-host'
let g:coc_node_path='/home/thevan/.nvm/versions/node/v10.16.3/bin/node'

" Ruby
let g:ruby_host_prog ='~/.rbenv/versions/2.6.4/bin/neovim-ruby-host'

" HTML, CSS
Plug 'lilydjwg/colorizer'
Plug 'jaxbot/browserlink.vim'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" Markdown
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

call plug#end()

" Final setup colorscheme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background =dark
colorscheme onedark

" Fix error restore session
set sessionoptions-=folds
set sessionoptions-=options
let g:onedark_terminal_italics=1

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
