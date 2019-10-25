call plug#begin()

set termguicolors
syntax on
set spelllang=en encoding=UTF-8
set ff=unix noeol
filetype plugin on
filetype indent on
set number
set autoread autowrite
set cursorline
set signcolumn=yes
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
autocmd FileType php        setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab shiftround
autocmd FileType md        setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
set hidden
set incsearch hlsearch ignorecase
set clipboard +=unnamedplus
set nobackup noswapfile
set list listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
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
nnoremap <leader>so :so ~/.config/nvim/init.vim<cr>
nnoremap <leader>vi :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>qq :qall<cr>
nnoremap <leader>w :w<cr>
tnoremap <esc> <c-\><c-n>
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-k>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l
nnoremap <c-a-k> :resize +2<cr>
nnoremap <c-a-j> :resize -2<cr>
nnoremap <c-a-l> :vertical resize +2<cr>
nnoremap <c-a-h> :vertical resize -2<cr>

" Floating Term
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm(...)
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  let border_buf = nvim_create_buf(v:false, v:true)
  let s:float_term_border_win = nvim_open_win(border_buf, v:true, border_opts)
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  hi FloatTermNormal term=None guibg=#2d3d45
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:FloatTermNormal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:FloatTermNormal')
  if a:0 == 0
    terminal
  else
    call termopen(a:1)
  endif
  startinsert
  " Close border window when terminal window close
  autocmd TermClose * ++once :bd! | call nvim_win_close(s:float_term_border_win, v:true)
endfunction
" Open terminal
nnoremap <leader>at :call FloatTerm()<cr>
" Open node REPL
nnoremap <leader>an :call FloatTerm('"node"')<cr>
" Open tig, yes TIG, A FLOATING TIGGGG!!!!!!
nnoremap <leader>ag :call FloatTerm('"tig"')<cr>

Plug 'joshdick/onedark.vim'

Plug 'ryanoasis/vim-devicons'
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

Plug 'jiangmiao/auto-pairs'

Plug 'christoomey/vim-tmux-navigator'

Plug 'huytd/vim-quickrun'
nnoremap <leader>e :QuickRunExecute<cr>

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'liuchengxu/vista.vim'
nnoremap <leader>v :Vista coc<cr>
let g:vista#renderer#enable_icon = 1
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['┊']

Plug 'AndrewRadev/splitjoin.vim'

Plug 'itchyny/vim-cursorword'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'matze/vim-move'

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','

Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

Plug 'moll/vim-bbye'

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
set updatetime=100
nnoremap <Leader>ggn :GitGutterNextHunk<CR>
nnoremap <Leader>ggp :GitGutterPrevHunk<CR>

Plug 'kien/ctrlp.vim'
let g:ctrlp_map = '<c-p>'
map <leader>b :CtrlPBuffer<cr>

Plug 't9md/vim-choosewin'
nmap <leader>cw :ChooseWin<cr>
nmap <leader>cs :ChooseWinSwap<cr>

Plug 'easymotion/vim-easymotion'
nmap s <Plug>(easymotion-overwin-f)
map <leader>l <Plug>(easymotion-bd-jk)

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

autocmd! BufReadPost,BufWritePost * Neomake
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
      \ 'coc-prettier'
      \ ]
inoremap <expr> <c-space> coc#refresh()
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)
" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
nnoremap <c-o> :CocList outline<cr>

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'onedark'
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

Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup=2
let g:nerdtree_tabs_autoclose=0

Plug 'scrooloose/nerdtree'
let g:NERDTreeWinSize = 25
let NERDTreeMinimalUI = 1
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeCascadeSingleChildDir = 0
let NERDTreeChDirMode=2
set autochdir
highlight! link NERDTreeFlags NERDTreeDir
nnoremap tt :NERDTreeToggle<cr>
nnoremap ff :NERDTreeFind<cr>
nnoremap rr :NERDTreeRefreshRoot<cr>
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
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
" Fix error restore session
set sessionoptions-=folds
set sessionoptions-=options

" Config neovim
function! MyOnBattery()
  return readfile('/sys/class/power_supply/AC/online') == ['0']
endfunction
if MyOnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('nrw', 1000)
endif

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Clear register
command! Cr for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor
