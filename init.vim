call plug#begin('~/.config/nvim/plugged')

set spelllang=en
set encoding=UTF-8
set ff=unix
set noeol
syntax on
filetype plugin on
filetype indent on
set number
set relativenumber
set autoread
set autowrite
set cursorline
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType php        setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
if exists('&colorcolumn')
  set colorcolumn=80
endif
set showmatch
set hidden
set incsearch
set hlsearch
set ignorecase
set nopaste
set clipboard =unnamedplus
set nobackup noswapfile
set list
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨,space:.
set splitbelow
set splitright

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
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-A-k> <C-u>
nnoremap <C-A-j> <C-d>
nnoremap <silent> no :nohlsearch<cr>
nnoremap <silent> bf :bfirst<cr>
nnoremap <silent> bl :blast<cr>
nnoremap <silent> bs :new<cr>
nnoremap <silent> bv :vnew<cr>
nnoremap <silent> bp :bprevious<cr>
nnoremap <silent> bn :bnext<cr>
nnoremap <silent> bx :bdelete <cr>
nnoremap <silent> bd :Bdelete <cr>
nnoremap <silent> tn :tabnext<cr>
nnoremap <silent> tp :tabprevious<cr>
nnoremap <silent> tf :tabfirst<cr>
nnoremap <silent> tl :tablast<cr>
nnoremap <silent> tx :tabclose<cr>

map < <gv
vmap > >gv
imap jk <Esc>
let mapleader = ","
nnoremap <leader>qq :SClose<cr>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <A-k> :resize +2<cr>
nnoremap <A-j> :resize -2<cr>
nnoremap <A-l> :vertical resize +2<cr>
nnoremap <A-h> :vertical resize -2<cr>

Plug 'joshdick/onedark.vim'

Plug 'mklabs/split-term.vim'
nnoremap <C-t>s :Term<cr>
nnoremap <C-t>v :VTerm<cr>
nnoremap <C-t>t :TTerm<cr>

Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['┊']

Plug 'maxbrunsfeld/vim-yankstack'

Plug 'townk/vim-autoclose'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

Plug 'moll/vim-bbye'

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "<c-n>"

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'


Plug 'enricobacis/vim-airline-clock'
let g:airline#extensions#clock#format = '%H:%M:%S'
let g:airline#extensions#clock#updatetime = 1000
let g:airline#extensions#clock#auto = 0
function! AirlineInit()
  let g:airline_section_z = airline#section#create(['clock', g:airline_symbols.space, g:airline_section_z])
endfunction
autocmd User AirlineAfterInit call AirlineInit()

Plug 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
map <leader>b :CtrlPBuffer<cr>
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0

Plug 'mhinz/vim-startify'
let NERDTreeHijackNetrw = 1
let g:startify_session_persistence = 1
let g:startify_session_before_save = [
      \ 'echo "Cleaning up before saving.."',
      \ 'silent! NERDTreeTabsClose'
      \ ]
let g:ascii = [
      \'   __    _  _______  _______  __   __  ___   __   __  ',
      \'  |  |  | ||       ||       ||  | |  ||   | |  |_|  | ',
      \'  |   |_| ||    ___||   _   ||  |_|  ||   | |       | ',
      \'  |       ||   |___ |  | |  ||       ||   | |       | ',
      \'  |  _    ||    ___||  |_|  ||       ||   | |       | ',
      \'  | | |   ||   |___ |       | |     | |   | | ||_|| | ',
      \'  |_|  |__||_______||_______|  |___|  |___| |_|   |_| ',
      \'',
      \'  " To get what you want you have to deserve what you want.             ',
      \'    The world is not yet a crazy world to reward undeserving people."   ',
      \'    >  Charlie Munger'
      \]

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
      \ 'do': 'npm install',
      \ 'for': ['css', 'less', 'scss', 'json', 'graphql',
      \ 'markdown', 'vue', 'yaml', 'html','javascript'] }
let g:prettier#autoformat = 0

Plug 'stephpy/vim-php-cs-fixer'
let g:php_cs_fixer_rules = "@PSR2"
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

Plug 'thinca/vim-quickrun'
map <leader>r :QuickRun<cr>

Plug 'w0rp/ale'
let g:ale_sign_column_always = 1
let g:ale_linters = {'javascript': ['standard'],'php':['php','phpcs']}
let g:ale_php_phpcs_standard = 'PSR2'
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '⚠'
let g:airline#extensions#ale#enabled = 1
function! LinterStatus() abort
  let l:counts = ale#statusline#Count(bufnr(''))

  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors

  return l:counts.total == 0 ? 'OK' : printf(
        \   '%dW %dE',
        \   all_non_errors,
        \   all_errors
        \)
endfunction
set statusline=%{LinterStatus()}

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
let g:EditorConfig_core_mode = 'external_command'

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-phpls',
      \ 'coc-python',
      \ 'coc-snippets',
      \ 'coc-emmet',
      \]
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
vmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'angr'
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
set background=dark
colorscheme onedark

" Clear register
command! Cr for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
