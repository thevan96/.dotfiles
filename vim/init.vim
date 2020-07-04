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
set clipboard=unnamedplus
set list listchars=tab:␣\ ,extends:▶,precedes:◀
set fillchars+=vert:\|
set conceallevel=2

" Setting default tab/space
set tabstop=2 shiftwidth=2 expandtab

" Sync file another open
autocmd FocusGained * :checktime

" Save position cursor
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Mapping leader
let mapleader = ' '

" Fast command
nnoremap <silent><leader>w :w<cr>
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>Q :qa!<cr>
nnoremap <silent><leader>z <c-z><cr>

" Remap
map * *N
map S <c-^>
map <c-n> <c-d>
map <c-p> <c-u>
nnoremap j gj
nnoremap k gk
nnoremap <silent>< <<
nnoremap <silent>> >>
vnoremap <silent>< <gv
vnoremap <silent>> >gv

" Disable highlight search
nnoremap <silent><esc> :nohlsearch<cr>

" Split window
nnoremap <silent>sv :vsplit<cr>
nnoremap <silent>ss :split<cr>

" Move window
nnoremap sj <c-w><c-j>
nnoremap sk <c-w><c-k>
nnoremap sl <c-w><c-l>
nnoremap sh <c-w><c-h>

call plug#begin()
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
nnoremap <silent><leader>p :Prettier<cr>

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'

Plug 'bronson/vim-visual-star-search'

Plug 'MattesGroeger/vim-bookmarks'
let g:bookmark_highlight_lines = 1

Plug 'wellle/targets.vim'

Plug 'AndrewRadev/splitjoin.vim'

Plug 'wincent/ferret'

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 3

Plug 'tpope/vim-repeat'
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

Plug 'tpope/vim-sleuth'

Plug 'airblade/vim-gitgutter'
nmap gl <Plug>(GitGutterNextHunk)
nmap gh <Plug>(GitGutterPrevHunk)

Plug 'zivyangll/git-blame.vim'
nnoremap <silent><leader>b :<C-u>call gitblame#echo()<cr>

Plug 'wakatime/vim-wakatime'

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

nnoremap <silent><leader>o :Buffers<cr>
command! -bang -nargs=? -complete=dir Buffers
      \ call fzf#vim#buffers({'options': ['--layout=reverse']}, <bang>0)

nnoremap <silent><leader>R :Rg <c-r><c-w><cr>
nnoremap <silent><leader>r :Rg<cr>
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
      \ 'coc-styled-components',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-python',
      \ ]

" Refresh suggest
imap <silent><expr> <c-n> coc#refresh()

" Remap keys for gotos
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gt <Plug>(coc-type-definition)
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
nnoremap <silent><leader>f :Defx -search=`expand('%:p')` -columns=indent:icon:mark:git:filename -split=vertical -winwidth=30 -direction=topleft -show-ignored-files -resume<cr>
nnoremap <silent><leader>F :Defx -search=`expand('%:p')` -columns=indent:icon:mark:git:filename -split=vertical -winwidth=30 -direction=topleft -show-ignored-files -toggle -resume<cr>

autocmd BufWritePost * call defx#redraw()
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  call defx#custom#column('filename', {
        \ 'min_width': '50'
        \})
  call defx#custom#column('icon', {
        \ 'directory_icon': ' ⮞',
        \ 'opened_icon': ' ⮟',
        \ 'root_icon': ' ⬢',
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
  nnoremap <silent><buffer><expr> j 'j'
  nnoremap <silent><buffer><expr> k  'k'
  nnoremap <silent><buffer><expr> yp
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> i
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr> rr
        \ defx#do_action('redraw')
endfunction

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'jelera/vim-javascript-syntax'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ap/vim-css-color'

Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

Plug 'tpope/vim-markdown'
autocmd FileType markdown call s:markdown_mode_setup()
function! s:markdown_mode_setup()
  set wrap
  set conceallevel=0
endfunction

" Provider
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:vimtex_compiler_progname = 'nvr'
let g:loaded_python_provider = 0
let g:python_host_prog = expand('$HOME/.pyenv/shims/python2')
let g:python3_host_prog = expand('$HOME/.pyenv/shims/python3')
let g:node_host_prog = expand('$HOME/.nvm/versions/node/v12.18.1/bin/neovim-node-host')
let g:coc_node_path =  expand('$HOME/.nvm/versions/node/v12.18.1/bin/node')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'wombat'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'sgur/vim-textobj-parameter'
let g:vim_textobj_parameter_mapping = 's'

Plug 'nanotech/jellybeans.vim'
set background=dark

call plug#end()

colorscheme jellybeans
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi VertSplit  ctermbg=NONE guibg=NONE
