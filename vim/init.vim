" General setting
syntax on
set mouse=a
set termguicolors
set hlsearch
set nobackup noswapfile
set splitbelow splitright
set autoindent
set hidden number nowrap
set lazyredraw
set updatetime=150
set signcolumn=yes:2
set encoding=utf-8
set clipboard=unnamed
set conceallevel=2
set virtualedit=all
set fillchars+=vert:\|
set list listchars=tab:␣\ ,extends:▶,precedes:◀

" Mapping leader
let mapleader = ' '

" Setting default tab/space
set tabstop=2 shiftwidth=2 expandtab

" Sync file another open
autocmd FocusGained * :checktime

" Save position cursor
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif
endif

" Smarter cursorline
autocmd InsertLeave,WinEnter * set cursorline
autocmd InsertEnter,WinLeave * set nocursorline

" Fast mapping
map S <c-^>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :qa!<cr>

" Remap
map * *N
vnoremap p "0P
nnoremap < <<
nnoremap > >>

" Fix missing visual block
nnoremap gv `[v`]
xnoremap < <gv
xnoremap > >gv
xnoremap < <gv
xnoremap > >gv

" Disable highlight search, clear
nnoremap <silent><esc> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Scaner command-line history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Disable
nnoremap Q <nop>
nnoremap <F1> <nop>

" Split window
nmap <silent>ss :split<cr>
nmap <silent>sv :vsplit<cr>

" Move window
nnoremap sj <c-w><c-j>
nnoremap sk <c-w><c-k>
nnoremap sl <c-w><c-l>
nnoremap sh <c-w><c-h>

" Format
function! QuickFormat()
  silent! wall
  let fullpath = expand('%:p')
  let listExtension = split(expand('%t'), '\.')
  let prettier = "prettier"
  let semistandard = "semistandard"
  let phpCsFixer = "php-cs-fixer"
  let bladeFormat = "blade-formatter"
  let extension = listExtension[len(listExtension) - 1]
  if extension == "js"
    execute ":! ".prettier." --write ".fullpath ." && "
          \ .semistandard." --fix ".fullpath." | snazzy"
  elseif extension == "php"
    let isBlade = listExtension[len(listExtension) - 2]
    if isBlade =='blade'
      execute ":! ".prettier." --write ".fullpath." && "
            \ .bladeFormat." --write ".fullpath
    else
      execute ":! ".prettier." --write ".fullpath." && "
            \ .phpCsFixer." fix --rules=@PSR2 ".fullpath." && rm .php_cs.cache"
    endif
  else
    execute ":! ".prettier." --write ".fullpath
  endif
  execute ":e!"
endfunction
nnoremap <leader>P :call QuickFormat()<cr>

call plug#begin()
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'ntpeters/vim-better-whitespace'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'

Plug 'puremourning/vimspector'
let g:vimspector_enable_mappings = 'HUMAN'

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 3

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
      \ 'coc-html',
      \ ]

" Remap keys for gotos, refresh
imap <silent><expr> <c-n> coc#refresh()
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

" Navigate error
map <silent>gl <Plug>(coc-diagnostic-next)
map <silent>gk <Plug>(coc-diagnostic-prev

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent>K :call <SID>show_documentation()<CR>

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
nmap gj <Plug>(GitGutterNextHunk)
nmap gk <Plug>(GitGutterPrevHunk)

Plug 'sheerun/vim-polyglot'
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
        \ 'directory_icon': ' +',
        \ 'opened_icon': ' -',
        \ })
  call defx#custom#column('filename', {
        \ 'min_width': 40,
        \ 'max_width': 50,
        \})
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

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'sgur/vim-textobj-parameter'
let g:vim_textobj_parameter_mapping = 's'

Plug 'nanotech/jellybeans.vim'
set background=dark
call plug#end()

colorscheme jellybeans
highlight Normal      ctermbg=NONE guibg=NONE
highlight LineNr      ctermbg=NONE guibg=NONE
highlight SignColumn  ctermbg=NONE guibg=NONE
highlight VertSplit   guibg=NONE   guifg=NONE
highlight StatusLine  guibg=NONE   guifg=NONE
