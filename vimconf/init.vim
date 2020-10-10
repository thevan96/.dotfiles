" General setting
syntax on
set termguicolors
set hlsearch ignorecase
set nobackup noswapfile
set splitbelow splitright
set number nowrap
set autoindent
set tabstop=2 shiftwidth=2 shiftround expandtab
set mouse=a
set laststatus=2
set encoding=utf-8
set updatetime=100
set synmaxcol=200
set clipboard+=unnamedplus
set fillchars+=vert:\|
set list listchars=tab:␣\ ,extends:▶,precedes:◀
set signcolumn=yes:2
set virtualedit=all
set conceallevel=0
set foldlevel=99
set foldmethod=indent

" Remap
let mapleader = ' '
nnoremap Y y$
vnoremap p "0P
nnoremap <silent><leader>a <c-^>
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>Q :qa!<cr>
nnoremap <silent><leader>d :bd!<cr>

" Fix missing block visual
nnoremap gv `[v`]

" Better indent
nnoremap < <<
nnoremap > >>
xnoremap < <gv
xnoremap > >gv
xnoremap < <gv
xnoremap > >gv

" Delete without yank
nnoremap <leader>dd "_dd
nnoremap <leader>x "_x

" Split
map <silent>ss :split<cr>
map <silent>sv :vsplit<cr>

" Disable highlight search
nnoremap <silent><esc> :nohlsearch<cr>

" Scaner command-line history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Save position cursor, load file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif
  autocmd FocusGained * :checktime
endif

" Disable mapping
map s <nop>
map q <nop>
map <F1> <nop>

call plug#begin()
" Text object
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-indent'

" Utils
Plug 'tpope/vim-sleuth'
Plug 'bronson/vim-visual-star-search'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sheerun/vim-polyglot'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'tpope/vim-fugitive'
set statusline=\ %f\ %y%{FugitiveStatusline()}%m%r%=%l/%L\ %P\ |

Plug 't9md/vim-choosewin'
let g:choosewin_overlay_enable = 0
nmap <silent><leader>ww :ChooseWin<cr>
nmap <silent><leader>ws :ChooseWinSwap<cr>

Plug 'mhinz/vim-signify'
nmap <silent>gl <plug>(signify-next-hunk)
nmap <silent>gh <plug>(signify-prev-hunk)

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'

Plug 'diepm/vim-rest-console'
let g:vrc_trigger = '<leader>r'

Plug 'puremourning/vimspector'
let g:vimspector_enable_mappings = 'HUMAN'

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'
let g:winresizer_vert_resize = 5
let g:winresizer_horiz_resize = 5

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
      \ 'coc-phpls',
      \ 'coc-prettier',
      \ ]
" Prettier format
command! -nargs=0 Prettier :CocCommand prettier.formatFile
nnoremap <silent><leader>p :Prettier<cr>

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
autocmd FileType defx setlocal nobuflisted nonumber
autocmd BufWritePost * call defx#redraw()
autocmd FileType defx call s:defx_my_settings()
nnoremap <silent><leader>f :Defx -search=`expand('%:p')`
      \ -split=vertical -winwidth=45 -direction=botright
      \ -columns=indent:icon:mark:git:filename
      \ -show-ignored-files -listed
      \ -resume -listed <cr>
nnoremap <silent><leader>F :Defx
      \ -split=vertical -winwidth=45 -direction=botright
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
let g:vimtex_compiler_progname = 'nvr'
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
let g:coc_node_path =  expand('$HOME/.asdf/shims/node')
let g:node_host_prog = expand('$HOME/.asdf/shims/neovim-node-host')
call plug#end()

colorscheme desert
set background=dark
highlight SignifySignAdd    guifg=#00ff00
highlight SignifySignDelete guifg=#ff0000
highlight SignifySignChange guifg=#ffff00
highlight VertSplit         guibg=NONE     guifg=NONE
highlight StatusLine        guibg=white    guifg=black
highlight Normal            guibg=NONE
highlight NonText           guibg=NONE
highlight SignColumn        guibg=NONE
highlight Pmenu             guibg=gray
highlight LineNr            guifg=gray
highlight comment           guifg=green

