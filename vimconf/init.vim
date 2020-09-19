" General setting
syntax on
set termguicolors
set hlsearch
set nobackup noswapfile
set splitbelow splitright
set autoindent
set ruler showcmd hidden number nowrap
set mouse=a
set list listchars=tab:␣\ ,extends:▶,precedes:◀
set tabstop=2 shiftwidth=2 expandtab
set updatetime=150
set signcolumn=yes:2
set encoding=utf-8
set clipboard=unnamed
set conceallevel=0
set textwidth=80

" Mapping leader
let mapleader = ' '

" Sync file another open
autocmd FocusGained * :checktime

" Remap
map S <c-^>
vnoremap p "0P
nnoremap gv `[v`]
nnoremap < <<
nnoremap > >>
xnoremap < <gv
xnoremap > >gv
xnoremap < <gv
xnoremap > >gv

" Navigate, split
map <silent>sj <c-w><c-j>
map <silent>sk <c-w><c-k>
map <silent>sl <c-w><c-l>
map <silent>sh <c-w><c-h>

" Split
map <silent>ss :split<cr>
map <silent>sv :vsplit<cr>

" Disable highlight search
nnoremap <silent><esc> :nohlsearch<cr>

" Scaner command-line history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Disable
map s <nop>
map q <nop>
map Q <nop>
map <F1> <nop>

call plug#begin()
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'

Plug 'takac/vim-hardtime'
let g:hardtime_maxcount = 5
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
let g:hardtime_ignore_buffer_patterns = [ "defx"]
let g:list_of_normal_keys = ["h", "l"]
let g:list_of_visual_keys = ["h", "l"]
let g:list_of_insert_keys = []
let g:list_of_disabled_keys = []

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'

Plug 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <silent><leader>i :Files<cr>
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse']}, <bang>0)

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
let g:diagnostic_insert_delay = 1
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
imap <silent><expr> <c-n> coc#refresh()
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>gl <Plug>(coc-diagnostic-next)
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
      \ -split=vertical -winwidth=40 -direction=topleft
      \ -columns=indent:icon:mark:git:filename
      \ -show-ignored-files -listed
      \ -resume -listed <cr>
nnoremap <silent><leader>F :Defx
      \ -split=vertical -winwidth=40 -direction=topleft
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
let g:vimtex_compiler_progname = 'nvr'
let g:python_host_prog = expand('$HOME/.asdf/shims/python2')
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
let g:coc_node_path =  expand('$HOME/.asdf/shims/node')
let g:node_host_prog = expand('$HOME/.asdf/shims/neovim-node-host')

set background=dark
call plug#end()

colorscheme desert
highlight Normal      ctermbg=NONE guibg=NONE
highlight SignColumn  ctermbg=NONE guibg=NONE
highlight VertSplit   guibg=NONE   guifg=NONE
highlight NonText     guibg=NONE   guifg=NONE
highlight Pmenu       ctermbg=NONE guibg=gray
highlight LineNr      guifg=gray   guibg=NONE
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
