call plug#begin()
set termguicolors
syntax on
set encoding=UTF-8
set ff=unix
filetype plugin on
filetype indent on
set number
set autoread autowrite
set cursorline
set signcolumn=yes
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set hidden
set incsearch hlsearch ignorecase smartcase
set clipboard +=unnamedplus
set nobackup noswapfile nowritebackup
set list listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set splitbelow splitright
set autoindent smartindent
set mouse=a
set colorcolumn=80
set re=1
set updatetime=100
set lazyredraw
set nojoinspaces
set nowrap
set ttyfast
let g:is_posix = 1

set tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
autocmd FileType php        setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab shiftround
autocmd FileType md        setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
autocmd BufEnter * :syntax sync fromstart

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Remap scrolling
nnoremap <a-K> <c-u>
nnoremap <a-J> <c-d>

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
nnoremap <esc><esc> :nohlsearch<cr>
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
let mapleader = ' '
nnoremap <leader>so :so ~/.config/nvim/init.vim<cr>
nnoremap <leader>vi :e ~/.config/nvim/init.vim<cr>
nnoremap <leader>qq :q<cr>
nnoremap <leader>qa :qall<cr>
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

" Setup colorscheme
Plug 'joshdick/onedark.vim'
set background=dark

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

Plug 'ryanoasis/vim-devicons'
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif
let g:webdevicons_enable_nerdtree = 1

Plug 'jiangmiao/auto-pairs'

Plug 'christoomey/vim-tmux-navigator'

Plug 'huytd/vim-quickrun'
nnoremap <leader>e :QuickRunExecute<cr>

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['┊']

Plug 'AndrewRadev/splitjoin.vim'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'matze/vim-move'

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','

Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

Plug 'moll/vim-bbye'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
nnoremap <leader>ggn :GitGutterNextHunk<CR>
nnoremap <leader>ggp :GitGutterPrevHunk<CR>

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'kien/ctrlp.vim'
nmap <leader>p :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

Plug 't9md/vim-choosewin'
nmap <leader>cw :ChooseWin<cr>
nmap <leader>cs :ChooseWinSwap<cr>

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-z>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
nnoremap <leader>js :e ~/.config/nvim/UltiSnips/javascript.snippets<cr>
nnoremap <leader>php :e ~/.config/nvim/UltiSnips/php.snippets<cr>
nnoremap <leader>html :e ~/.config/nvim/UltiSnips/html.snippets<cr>

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
      \ 'python',
      \ 'ruby',
      \ 'html',
      \ 'swift' ]
      \ }
nmap <leader>f <plug>(Prettier)

Plug 'neoclide/coc.nvim'
let g:coc_global_extensions =
      \ [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-phpls',
      \ 'coc-python',
      \ 'coc-prettier',
      \ 'coc-vimlsp',
      \ 'coc-solargraph'
      \ ]
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

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

Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_autoclose=0

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdtree'
let NERDTreeIgnore = ['^\.git$','^node_modules$',]
let g:NERDTreeWinSize = 30
let NERDTreeMinimalUI = 1
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeCascadeSingleChildDir = 0
let NERDTreeChDirMode=2
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer = 1
set autochdir
highlight! link NERDTreeFlags NERDTreeDir
nnoremap tt :NERDTreeToggle<cr>
nnoremap ff :NERDTreeFind<cr>
nnoremap rr :NERDTreeRefreshRoot<cr>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
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

" PHP
Plug 'stephpy/vim-php-cs-fixer'
let g:php_cs_fixer_rules = "@PSR2"
nnoremap <leader>pcd :call PhpCsFixerFixDirectory()<cr>
nnoremap <leader>pcf :call PhpCsFixerFixFile()<cr>
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer"

"HTML, CSS
Plug 'lilydjwg/colorizer'

Plug 'andymass/vim-matchup'
let g:loaded_matchit = 1

Plug 'ap/vim-css-color'

call plug#end()

colorscheme onedark

" Clear register
command! Cr for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor