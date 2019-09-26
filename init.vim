call plug#begin('~/.config/nvim/plugged')
au FocusLost,WinLeave * :silent! w
set spelllang=en
set encoding=UTF-8
set ff=unix
set noeol
syntax on
filetype plugin on
set number
set autoread
set autowrite
set cursorline
set tabstop=2 shiftwidth=2 expandtab
set showmatch
set wildmenu
set hidden
set incsearch
set hlsearch
set ignorecase
set nopaste
set clipboard+=unnamedplus
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
nnoremap <silent> ts :tabnew<cr>
nnoremap <silent> tn :tabnext<cr>
nnoremap <silent> tp :tabprevious<cr>
nnoremap <silent> tf :tabfirst<cr>
nnoremap <silent> tl :tablast<cr>
nnoremap <silent> tx :tabclose<cr>
vmap < <gv
vmap > >gv
let mapleader = ","
inoremap jk <Esc>
nnoremap ww :w<cr>
noremap <leader>q :q <cr>
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <C-t>s <C-w><C-s> :terminal <cr>
nnoremap <C-t>v <C-w><C-v> :terminal <cr>
nnoremap <A-k> :resize +1<cr>
nnoremap <A-j> :resize -1<cr>
nnoremap <A-l> :vertical resize +2<cr>
nnoremap <A-h> :vertical resize -2<cr>

Plug 'joshdick/onedark.vim'

Plug 'tpope/vim-surround'

Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['┊']

Plug 'maxbrunsfeld/vim-yankstack'

Plug 'moll/vim-bbye'

Plug 'tpope/vim-fugitive'

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'thinca/vim-quickrun'
map <leader>r :QuickRun<cr>


Plug 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
map <leader>b :CtrlPBuffer<cr>

Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-commentary'

Plug 'easymotion/vim-easymotion'
map <silent> ;; <Plug>(easymotion-overwin-f)
map <silent> ;l <Plug>(easymotion-overwin-line)

Plug 'prettier/vim-prettier', {
      \ 'do': 'npm install',
      \ 'for': ['css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
let g:prettier#autoformat = 0

Plug 'stephpy/vim-php-cs-fixer'
let g:php_cs_fixer_rules = "@PSR2"
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>

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
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<cr>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
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
nnoremap <Leader>tt :NERDTreeToggle<CR>
nnoremap <Leader>tf :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer = 1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
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

Plug 'sheerun/vim-polyglot'

" Python
let g:python_host_prog = '/usr/bin/python2'
let g:python3_host_prog = '/home/thevan/.pyenv/shims/python3'

" PHP
Plug 'StanAngeloff/php.vim'

" Node
let g:node_host_prog= '/home/thevan/.nvm/versions/node/v10.16.3/bin/neovim-node-host'
let g:coc_node_path='/home/thevan/.nvm/versions/node/v10.16.3/bin/node'

" Ruby
let g:ruby_host_prog ='/home/thevan/.rbenv/versions/2.6.4/bin/neovim-ruby-host'

" HTML, CSS
Plug 'lilydjwg/colorizer'
Plug 'jaxbot/browserlink.vim'
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" Markdown
Plug 'plasticboy/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

call plug#end()

" Final setup colorscheme
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark
colorscheme onedark
let g:onedark_terminal_italics=1
