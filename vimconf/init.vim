" General setting
syntax on
set termguicolors
set hlsearch ignorecase
set nobackup noswapfile
set splitbelow splitright
set autoindent
set mouse=a
set encoding=utf-8
set updatetime=100
set synmaxcol=300
set clipboard+=unnamedplus
set fillchars+=vert:\|
set list listchars=tab:␣\ ,extends:▶,precedes:◀
set tabstop=2 shiftwidth=2 expandtab
set signcolumn=yes:2
set virtualedit=all
set number nowrap
set conceallevel=0
set foldmethod=expr
set foldlevel=99
set foldexpr=nvim_treesitter#foldexpr()

" Remap
let mapleader = ' '
nnoremap S <c-^>
noremap Y y$
vnoremap p "0P
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>Q :qa!<cr>
nnoremap <silent><leader>D :bd!<cr>
nnoremap gv `[v`]
nnoremap < <<
nnoremap > >>
xnoremap < <gv
xnoremap > >gv
xnoremap < <gv
xnoremap > >gv

" Split
map <silent>ss :split<cr>
map <silent>sv :vsplit<cr>

" Disable highlight search
nnoremap <silent><esc> :nohlsearch<cr>

" Scaner command-line history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Saner behavior of n and N
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

" Save position cursor, load file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif
  autocmd FocusGained * :checktime
endif

" Disable
map s <nop>
map q <nop>
map <F1> <nop>

call plug#begin()
" Text object
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'kana/vim-textobj-line'
Plug 'sgur/vim-textobj-parameter'
let g:vim_textobj_parameter_mapping = 's'

" Utils
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'bronson/vim-visual-star-search'
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-sleuth'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
nmap <silent><leader>pp :Prettier<cr>

Plug 'puremourning/vimspector'
let g:vimspector_enable_mappings = 'HUMAN'

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'
let g:winresizer_vert_resize = 5
let g:winresizer_horiz_resize = 5

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'Valloric/MatchTagAlways'
let g:mta_filetypes = {
      \ 'html' : 1,
      \ 'javascript' : 1,
      \ }

Plug 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <silent><leader>i :Files<cr>
nnoremap <silent><leader>o :Buffers<cr>
nnoremap <silent><leader>s :Rg<cr>
nnoremap <silent><leader>S :Rg <c-r><c-w><cr>

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions =
      \ [
      \ 'coc-styled-components',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-python',
      \ 'coc-phpls',
      \ ]

" Remap keys for gotos, refresh
imap <silent><expr> <c-space> coc#refresh()
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>gj <Plug>(coc-diagnostic-next)
nmap <silent>gk <Plug>(coc-diagnostic-prev

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent>K :call <SID>show_documentation()<cr>

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
Plug 'kristijanhusak/defx-git'
autocmd FileType defx setlocal nobuflisted
autocmd BufWritePost * call defx#redraw()
autocmd FileType defx call s:defx_my_settings()
nnoremap <silent><leader>f :Defx -search=`expand('%:p')`
      \ -split=vertical -winwidth=35 -direction=topleft
      \ -columns=indent:icon:mark:git:filename
      \ -show-ignored-files -listed
      \ -resume -listed <cr>
nnoremap <silent><leader>F :Defx
      \ -split=vertical -winwidth=35 -direction=topleft
      \ -columns=indent:icon:mark:git:filename
      \ -show-ignored-files -listed
      \ -toggle -resume -listed <cr>

function! s:defx_my_settings() abort
  call defx#custom#column('icon', {
        \ 'directory_icon': ' ●',
        \ 'opened_icon': ' ○',
        \ })
  call defx#custom#column('filename', {
        \ 'min_width': 40,
        \ 'max_width': 50,
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
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> a
        \ defx#do_action('toggle_select_visual')
  nnoremap <silent><buffer><expr> <esc>
        \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> yp
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> i
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr> rr
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> j 'j'
  nnoremap <silent><buffer><expr> k 'k'
endfunction

" Provider
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
let g:coc_node_path =  expand('$HOME/.asdf/shims/node')
let g:node_host_prog = expand('$HOME/.asdf/shims/neovim-node-host')
let g:vimtex_compiler_progname = 'nvr'

Plug 'nanotech/jellybeans.vim'
set background=dark
call plug#end()

colorscheme jellybeans
highlight Normal      ctermbg=none guibg=none
highlight SignColumn  ctermbg=none guibg=none
highlight VertSplit   guibg=none   guifg=none
highlight NonText     guibg=none   guifg=none
highlight LineNr      guifg=gray   guibg=none
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Treesistter config
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
      enable = true,
    },
  }
EOF

