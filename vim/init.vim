" General setting
syntax on
set nocompatible
set termguicolors
set ignorecase hlsearch
set nobackup noswapfile
set splitbelow splitright
set autoindent smartindent
set hidden number nowrap
set lazyredraw
set cmdheight=1
set mouse=a
set updatetime=100
set signcolumn=yes
set encoding=utf-8
set list listchars=tab:␣\ ,extends:▶,precedes:◀
set shortmess-=S
" set showtabline=2
set conceallevel=2

" Setting default tab/space
set tabstop=2 shiftwidth=2 expandtab

" Sync syntax highlight
autocmd BufEnter * :syntax sync fromstart

" Save position cursor
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Disable
nnoremap Q <nop>
nnoremap <Space> <Nop>

" Mapping leader
let mapleader = ' '

" Fast command
nnoremap <silent><leader>q :bdelete<cr>
nnoremap <silent><leader>w :w<cr>
nnoremap <silent><leader>Q :qa!<cr>

" Remap
map Y y$
nnoremap j gj
nnoremap k gk
nnoremap * *N

" Move
vnoremap . >gv
vnoremap , <gv
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<cr>gv=gv
vnoremap <C-k> :m '<-2<cr>gv=gv

" Disable highlight search
nnoremap <silent><esc> :nohlsearch<cr>

" Manager buffer
nnoremap <silent>gl :bnext<cr>
nnoremap <silent>gh :bprevious<cr>
nnoremap <silent>gv =G
nnoremap <silent>gx :Bdelete<cr>
nnoremap <silent>S <c-^>

" Split window
nnoremap <silent>ss :split<cr>
nnoremap <silent>sv :vsplit<cr>

" Move window
nnoremap sj <c-w><c-j>
nnoremap sk <c-w><c-k>
nnoremap sl <c-w><c-l>
nnoremap sh <c-w><c-h>

call plug#begin()
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html', 'php'] }
let g:prettier#quickfix_enabled = 0
nnoremap <leader>p :Prettier<cr>
autocmd  BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.php PrettierAsync


Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'

Plug 'jiangmiao/auto-pairs'

Plug 'terryma/vim-multiple-cursors'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-abolish'

Plug 'tpope/vim-commentary'

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'wakatime/vim-wakatime'

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 3

Plug 'moll/vim-bbye'

Plug 'tpope/vim-repeat'
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

Plug 'tpope/vim-eunuch'
nnoremap <leader>R :Rename<space>
nnoremap <leader>D :Delete<cr>

Plug 'tpope/vim-sleuth'

Plug 'airblade/vim-gitgutter'

Plug 'google/vim-searchindex'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'onedark'
" let g:airline#extensions#tabline#enabled = 1

if isdirectory('~/.fzf/bin/fzf')
  Plug '~/.fzf/bin/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

nnoremap <silent><leader>i :Files<cr>
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse']}, <bang>0)

nnoremap <silent><leader>l :Files <C-r>=expand("%:h")<cr>/<cr>

nnoremap <silent><leader>o :Buffers<cr>
command! -bang -nargs=? -complete=dir Buffers
      \ call fzf#vim#buffers({'options': ['--layout=reverse']}, <bang>0)

nnoremap <silent><leader>S :Rg <c-r><c-w><cr>
nnoremap <silent><leader>s :Rg<cr>
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
      \ 1,
      \ fzf#vim#with_preview({'options': ['--layout=reverse']}), <bang>0)

tnoremap <expr> <esc> (&filetype == "fzf") ? "<esc>" : "<c-\><c-n>"
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions =
      \ [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-python',
      \ ]

" Refresh suggest
inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<c-y>" : "\<c-g>u\<cr>"
nnoremap <silent><leader><leader> :call coc#util#float_hide()<cr>

" Remap keys for gotos
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent>K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Navigate error
map <silent>gj <Plug>(coc-diagnostic-next)
map <silent>gk <Plug>(coc-diagnostic-prev

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
nnoremap <silent><leader>f :Defx -search=`expand('%:p')` -columns=indent:icon:mark:git:icons:filename:type -split=vertical -winwidth=32 -direction=topleft -show-ignored-files<cr>
nnoremap <silent><leader>F :Defx -search=`expand('%:p')` -columns=indent:icon:mark:git:icons:filename:type -split=vertical -winwidth=32 -direction=topleft -show-ignored-files -toggle<cr>

autocmd BufWritePost * call defx#redraw()
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  call defx#custom#column('filename', {
        \ 'min_width': '100'
        \})
  call defx#custom#column('icon', {
        \ 'directory_icon': '▸',
        \ 'opened_icon': '▾',
        \ 'root_icon': 'R',
        \ })
  call defx#custom#column('mark', {
        \ 'readonly_icon': '✗',
        \ 'selected_icon': '✓',
        \ })
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
  nnoremap <silent><buffer><expr> mv
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> mk
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> t
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> T
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> rn
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <tab>
        \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> a
        \ defx#do_action('toggle_select_visual')
  nnoremap <silent><buffer><expr> cl
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
  nnoremap <silent><buffer><expr> rr
        \ defx#do_action('redraw')
endfunction

Plug 'othree/yajs.vim'

Plug 'ap/vim-css-color'

Plug 'tpope/vim-markdown'
autocmd FileType markdown call s:markdown_mode_setup()
function! s:markdown_mode_setup()
  set wrap
  set conceallevel=0
endfunction

Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" Text object
Plug 'wellle/targets.vim'
Plug 'kana/vim-textobj-user'
Plug 'whatyouhide/vim-textobj-xmlattr' " key x
Plug 'machakann/vim-swap' "key s
omap is <Plug>(swap-textobject-i)
xmap is <Plug>(swap-textobject-i)
omap as <Plug>(swap-textobject-a)
xmap as <Plug>(swap-textobject-a)

" Provider
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:vimtex_compiler_progname = 'nvr'
let g:loaded_python_provider = 0
let g:python_host_prog = expand('$HOME/.pyenv/shims/python2')
let g:python3_host_prog = expand('$HOME/.pyenv/shims/python3')
let g:node_host_prog = expand('$HOME/.nvm/versions/node/v12.16.3/bin/neovim-node-host')
let g:coc_node_path =  expand('$HOME/.nvm/versions/node/v12.16.3/bin/node')

Plug 'joshdick/onedark.vim'
set background=dark
call plug#end()

colorscheme onedark
