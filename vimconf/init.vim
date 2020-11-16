"----------------------------------"
" Simple is the best, less is more "
"----------------------------------"

"--- General setting ---"
syntax on
filetype on
filetype indent on
set encoding=utf-8

set nobackup
set noswapfile

set splitbelow
set splitright

set hlsearch

set ruler
set number
set showmode
set showcmd
set hidden

set foldlevel=99
set foldmethod=syntax

set autoindent
set tabstop=2
set shiftwidth=2
set expandtab
set shiftround

set nowrap
set conceallevel=0
set list listchars=tab:␣\ ,extends:▶,precedes:◀
set backspace=indent,eol,start

set termguicolors
set colorcolumn=80
set textwidth=80
set completeopt-=preview
set signcolumn=yes
set shortmess+=c
set mouse=a

set updatetime=100
set synmaxcol=320

" Set keymap
let mapleader = ' '
map Y y$
map <leader>y "+yy
nnoremap gV `[v`]
nnoremap <silent><leader>l :nohlsearch<cr>

" Better indent
nnoremap < <<
nnoremap > >>
xnoremap < <gv
xnoremap > >gv

" Navigate quickfix
nnoremap <silent>gp :cp<cr>
nnoremap <silent>gn :cn<cr>
nnoremap <silent>go :copen<cr>
nnoremap <silent>gx :cclose<cr>

" Disable netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Autocmd
augroup loadFile
  autocmd BufRead,BufNewFile *.md set wrap
  autocmd FileType qf wincmd J
  autocmd FocusGained * :checktime
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif
augroup end

augroup workingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup END

" Config format
function! QuickFormat()
  silent! wall
  let fullpath = expand('%:p')
  let listExtension = split(expand('%t'), '\.')
  let prettier = "prettier"
  let phpcsfixer = "php-cs-fixer"
  let blade = "blade-formatter"
  let extension = listExtension[len(listExtension) - 1]
  if extension == "php"
    let isBlade = listExtension[len(listExtension) - 2]
    if isBlade =='blade'
      execute ":! ".prettier." --write ".fullpath." && "
            \ .blade." --write ".fullpath
    else
      execute ":! ".prettier." --write ".fullpath." && "
            \ .phpcsfixer." fix --rules=@PSR2 ".fullpath." && rm .php_cs.cache"
    endif
  else
    execute ":! ".prettier." --write ".fullpath
  endif
  execute ":e!"
endfunction
nnoremap <silent><leader>p :call QuickFormat()<cr>

call plug#begin()

"--- Navigate explore ---"
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
augroup defxConfig
  autocmd FileType defx set nobuflisted
  autocmd BufWritePost * call defx#redraw()
  autocmd FileType defx call s:defx_my_settings()
augroup end
nnoremap <silent><leader>f :Defx -search=`expand('%:p')`
      \ -split=vertical -winwidth=45 -direction=topleft
      \ -columns=indent:icon:mark:filename
      \ -show-ignored-files
      \ -resume -listed<cr>
nnoremap <silent><leader>F :Defx
      \ -split=vertical -winwidth=45 -direction=topleft
      \ -columns=indent:icon:mark:filename
      \ -show-ignored-files
      \ -resume -listed -toggle<cr>
function! s:defx_my_settings() abort
  call defx#custom#column('icon', {
        \ 'directory_icon': '●',
        \ 'opened_icon': '○',
        \ })
  call defx#custom#column('filename', {
        \ 'min_width': 50,
        \ 'max_width': 50,
        \ })
  nnoremap <silent><buffer><expr> <cr>
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> u
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> o
        \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> dd
        \ defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> ss
        \ defx#do_action('drop','split')
  nnoremap <silent><buffer><expr> sv
        \ defx#do_action('drop', 'vsplit')
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
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> a
        \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> A
        \ defx#do_action('toggle_select_visual')
  nnoremap <silent><buffer><expr> cl
        \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> yp
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> i
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> j 'j'
  nnoremap <silent><buffer><expr> k 'k'
endfunction

"--- Autocomplete ---"
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
      \ 'coc-styled-components',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-python',
      \ 'coc-phpls',
      \ 'coc-snippets',
      \ ]
" Remap <C-u> and <C-d> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"

" Remap keys for gotos, refresh
imap <silent><expr> <c-x><c-o> coc#refresh()
nmap <silent>gJ <Plug>(coc-float-jump)
nmap <silent>gH <Plug>(coc-float-hide)
nmap <silent>gj <Plug>(coc-diagnostic-next)
nmap <silent>gk <Plug>(coc-diagnostic-prev)
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent>K :call <SID>show_documentation()<cr>

"--- Snippet ---"
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"--- Debug ---"
Plug 'puremourning/vimspector'

"--- Git ---"
Plug 'tpope/vim-fugitive'
set statusline=\ %f%m%r\ %=%l/%c/%L\ %P\ %{FugitiveStatusline()}

"--- Best search and replace ---"
Plug 'stefandtw/quickfix-reflector.vim'
set grepprg=rg\ --vimgrep\ --hidden\
      \ --glob\ '!.git'\
      \ --glob\ '!.idea'\
      \ --glob\ '!.vscode'\
      \ --glob\ '!node_modules'\
      \ --glob\ '!vendor'\
      \ --glob\ '!composer'

"--- Utils ---"
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'machakann/vim-swap'
omap is <Plug>(swap-textobject-i)
xmap is <Plug>(swap-textobject-i)
omap as <Plug>(swap-textobject-a)
xmap as <Plug>(swap-textobject-a)

Plug 'christoomey/vim-tmux-navigator'

Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['markdown']

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'
let g:winresizer_vert_resize = 5
let g:winresizer_horiz_resize = 5

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"--- Theme ---"
Plug 'lifepillar/vim-solarized8'

"--- Provider ---"
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = expand("$HOME/.asdf/shims/python3")
let g:coc_node_path = expand("$HOME/.asdf/shims/node")
let g:node_host_prog = expand("$HOME/.asdf/shims/neovim-node-host")
call plug#end()

"--- Customize theme ---"
set background=dark
colorscheme solarized8
hi SignColumn        guifg=NONE      guibg=NONE
hi Normal            guifg=NONE      guibg=NONE
hi NonText           guifg=NONE      guibg=NONE
hi VertSplit         guifg=NONE      guibg=NONE
hi LineNr            guibg=NONE

