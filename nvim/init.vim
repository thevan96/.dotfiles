if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" Set property
syntax on
set number
set hidden
set showcmd
set nocompatible
set autoread autowrite
set incsearch hlsearch ignorecase smartcase
filetype plugin on
filetype indent on
set nobackup noswapfile nowritebackup
set splitbelow splitright
set autoindent smartindent
set cmdheight=1
set nowrap
set mouse=a
set updatetime=100
set signcolumn=yes
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,mac,dos
set clipboard=unnamedplus
set list listchars=eol:¬,tab:>·,trail:~,space:·
set backspace=indent,eol,start
set shortmess-=S
set whichwrap=<,>,h,l
set re=1
set foldmethod=indent

" Setting tab/space by language programing
set tabstop=2 shiftwidth=2 expandtab
autocmd FileType js, md, html, css, scss, json
      \ setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType php
      \ setlocal tabstop=4 shiftwidth=4 expandtab

" Sync syntax highlight
set lazyredraw
autocmd BufEnter * :syntax sync fromstart

" Run record
nnoremap Q @q

" Markdown mode
autocmd FileType markdown call s:markdown_mode_setup()
function! s:markdown_mode_setup()
  set wrap
  set conceallevel=0
endfunction

" Blade mode
autocmd FileType *.blade.php call s:blade_mode_setup()
function! s:blade_mode_setup()
  set ft=html | set ft=phtml | set ft=blade
endfunction

" Save position cursor
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Mapping leader
let mapleader = ' '

" Fast command
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>Q :qa!<cr>
nnoremap <silent><leader>so :so ~/dotfiles/nvim/init.vim<cr>
nnoremap <silent><leader>vi :e ~/dotfiles/nvim/init.vim<cr>

" Remap yank
nnoremap Y y$

" Overide jk, >, <
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Indent
vnoremap >> >gv
vnoremap << <gv

" Zoom in, zoom out
nnoremap <silent>zz :call defx#do_action('quit')<cr><c-w>_ \| <c-w>\|
nnoremap <silent>zo <c-w>=

" Disable highlight search
nnoremap <silent><esc> :nohlsearch<cr>

" Remap navigte
noremap H <c-u>
noremap L <c-d>

" Manager buffer
nnoremap gd :bclose<cr>
nnoremap gx :Bdelete<cr>
nnoremap gh :bprevious<cr>
nnoremap gl :bnext<cr>

" Split window
nmap <silent>ss :split<cr>
nmap <silent>sv :vsplit<cr>

" Move window
nnoremap sj <c-w><c-j>
nnoremap sk <c-w><c-k>
nnoremap sl <c-w><c-l>
nnoremap sh <c-w><c-h>

" Disable netrw
let g:loaded_netrw = 1
let loaded_netrwPlugin = 1

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Format source
function! QuickFormat()
  silent! wall
  let fullpath = expand('%:p')
  let listExtension = split(expand('%t'), '\.')

  " List format tool
  let runner1 = "prettier"
  let runner2 = "semistandard"
  let runner3 = "php-cs-fixer"
  let runner4 = "blade-formatter"

  let extension = listExtension[len(listExtension) - 1]
  if extension == "js"
    execute ":! ".runner1." --write ".fullpath ." && "
          \ .runner2." --fix ".fullpath." | snazzy"
  elseif extension == "ts"
    execute ":! ".runner1." --write ".fullpath
  elseif extension == "php"
    let isBlade = listExtension[len(listExtension) - 2]
    if isBlade =='blade'
      execute ":! ".runner1." --write ".fullpath." && "
            \ .runner4." --write ".fullpath
    else
      execute ":! ".runner1." --write ".fullpath." && "
            \ .runner3." fix --rules=@PSR2 ".fullpath." && rm .php_cs.cache"
    endif
  elseif extension == "html"
    execute ":! ".runner1." --write ".fullpath
  elseif extension == "css"
    execute ":! ".runner1." --write ".fullpath
  elseif extension == "scss"
    execute ":! ".runner1." --write ".fullpath
  elseif extension == "json"
    execute ":! ".runner1." --write ".fullpath
  elseif extension == "md"
    execute ":! ".runner1." --write ".fullpath
  elseif extension == "py"
    execute ":! ".runner1." --write ".fullpath
  else
    echoerr "File type not supported!"
  endif
  execute ":e!"
endfunction
nnoremap <leader>F :call QuickFormat()<cr>

" Load plugin
call plug#begin()

" Setup colorscheme
Plug 'laggardkernel/vim-one'
set background=dark

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 3

Plug 'moll/vim-bbye'

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'tpope/vim-repeat'
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

Plug 'tpope/vim-surround'

Plug 'jiangmiao/auto-pairs'

Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

Plug 'pseewald/vim-anyfold'
autocmd Filetype * AnyFoldActivate
set foldlevel=99

Plug 'tpope/vim-sleuth'

Plug 'vim-scripts/matchit.zip'

Plug 'matze/vim-move'
let g:move_key_modifier = 'C'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-fugitive'

Plug 'airblade/vim-gitgutter'

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 120

Plug 't9md/vim-choosewin'
nmap <leader>sw :ChooseWinSwap<cr>

Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

Plug 'google/vim-searchindex'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

Plug 'neoclide/coc.nvim'
let g:coc_global_extensions =
      \ [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-phpls',
      \ 'coc-python',
      \ 'coc-sql',
      \ 'coc-webpack',
      \ 'coc-vimlsp',
      \ 'coc-svelte',
      \ 'coc-flutter',
      \ 'coc-angular',
      \ 'coc-tailwindcss',
      \ 'coc-snippets'
      \ ]

" Refresh suggest
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"

" Remap keys for gotos
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

" Create mappings for function text object - coc-nvim
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use K to show documentation in preview window
nnoremap <silent>K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" navigate error
map <silent>gj <Plug>(coc-diagnostic-next)
map <silent>gk <Plug>(coc-diagnostic-prev)

Plug 'mengelbrecht/lightline-bufferline'
Plug 'itchyny/lightline.vim'

let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'relativepath'] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename'
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' }
      \ }

function! LightlineModified()
  return &ft =~# 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help\|vimfiler' && &readonly ? '' : ''
endfunction

function! LightlineFilename()
  return (LightlineReadonly() !=# '' ? LightlineReadonly() . ' ' : '') .
        \ (&ft ==# 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft ==# 'unite' ? unite#get_status_string() :
        \  &ft ==# 'vimshell' ? vimshell#get_status_string() :
        \ expand('%:t') !=# '' ? expand('%:t') : '[No Name]') .
        \ (LightlineModified() !=# '' ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFugitive()
  if &ft !~? 'vimfiler' && exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction

set showtabline=2
let g:lightline.tabline          = {'left': [['buffers']], 'right':[[]]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

if isdirectory('~/.fzf/bin/fzf')
  Plug '~/.fzf/bin/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.9 } }

nnoremap <silent><leader>i :Files<cr>
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, <bang>0)

nnoremap <silent><leader>l :Files <C-r>=expand("%:h")<cr>/<cr>

nnoremap <silent><leader>o :Buffers<cr>
command! -bang -nargs=? -complete=dir Buffers
      \ call fzf#vim#buffers(<bang>0)

nnoremap <silent><leader>r :Rg<cr>
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
      \ 1,
      \ fzf#vim#with_preview(), <bang>0)

tnoremap <expr> <esc> (&filetype == "fzf") ? "<esc>" : "<c-\><c-n>"

Plug 'Shougo/defx.nvim'
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'

nnoremap <silent>ff :Defx -search=`expand('%:p')` -columns=mark:indent:icons:git:filename -split=vertical -winwidth=35 -direction=topleft -show-ignored-files<cr>

autocmd BufWritePost * call defx#redraw()

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  nnoremap <silent><buffer><expr> <cr>
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> u
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> o
        \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> ss
        \ defx#do_action('drop','split')
  nnoremap <silent><buffer><expr> sv
        \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> dd
        \ defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> D
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> K
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> f
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> F
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> > defx#do_action('resize',
        \ defx#get_context().winwidth + 5)
  nnoremap <silent><buffer><expr> < defx#do_action('resize',
        \ defx#get_context().winwidth - 5)
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <space>
        \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> a
        \ defx#do_action('toggle_select_visual')
  nnoremap <silent><buffer><expr> c
        \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> j
        \ line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k
        \ line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> yp
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> i
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr> <C-l>
        \ defx#do_action('redraw')
endfunction

" Hilight syntax language
Plug 'sheerun/vim-polyglot'

" PHP
Plug 'captbaritone/better-indent-support-for-php-with-html'

" HTML, CSS
Plug 'lilydjwg/colorizer'
Plug 'ap/vim-css-color'

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }
nmap <silent><leader>m <Plug>MarkdownPreviewToggle

" Flutter, dart
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
nnoremap <leader>dr :FlutterRun<cr>
nnoremap <leader>dq :FlutterQuit<cr>
nnoremap <leader>dh :FlutterHotReload<cr>
nnoremap <leader>dR :FlutterHotRestart<cr>
nnoremap <leader>dd :FlutterVisualDebug<cr>

" Text object
Plug 'kana/vim-textobj-user' " Core textobject customer
Plug 'wellle/targets.vim' " Textobject + n + target
Plug 'kana/vim-textobj-entire' " Key e
Plug 'kana/vim-textobj-line' " Key l
Plug 'jasonlong/vim-textobj-css' " Key c
Plug 'whatyouhide/vim-textobj-xmlattr' " Key x
Plug 'kana/vim-textobj-indent' " Key i
Plug 'machakann/vim-swap' " Key s
omap is <Plug>(swap-textobject-i)
xmap is <Plug>(swap-textobject-i)
omap as <Plug>(swap-textobject-a)
xmap as <Plug>(swap-textobject-a)

" Provider
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('$HOME/.pyenv/shims/python3')
let g:node_host_prog = expand('$HOME/.nvm/versions/node/v12.14.1/bin/neovim-node-host')
let g:coc_node_path =  expand('$HOME/.nvm/versions/node/v12.14.1/bin/node')
let g:ruby_host_prog = expand('$HOME/.rbenv/versions/2.7.0/bin/neovim-ruby-host')

call plug#end()

let g:one_allow_italics = 1

" Overide color background -> terminal
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi Folded     ctermbg=NONE guibg=NONE

colorscheme one
