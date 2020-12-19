"----------------------------------"
" Simple is the best, less is more "
"----------------------------------"

"--- General setting ---"
syntax on
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

set tabstop=2
set shiftwidth=2
set expandtab
set shiftround

set nowrap
set conceallevel=0
set backspace=indent,eol,start
set list listchars=tab:␣\ ,extends:▶,precedes:◀

set mouse=a
set termguicolors
set shortmess+=c
set textwidth=80
set signcolumn=yes:2
set completeopt-=preview
set inccommand=nosplit

set updatetime=100
set synmaxcol=320

" Set keymap
let mapleader = ' '

" Customizer mapping
map Y y$
vnoremap p "0P
nnoremap S <C-^>
nnoremap gs `[v`]
map <silent><leader>y "+yy
nnoremap <leader>/ :grep<space>
nnoremap <silent><leader>l :nohlsearch<cr>

" Customize status line
set statusline=\ %f%m%r\ %=%l/%c/%L\ %P\ %{FugitiveStatusline()}\ %y\ |

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

" Disable
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Autocmd
augroup loadFile
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif
  autocmd FileType qf wincmd J
  autocmd FocusGained * :checktime
  autocmd FileType markdown setlocal wrap
augroup END

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
  elseif extension == "md"
    execute ":e!"
  else
    execute ":! ".prettier." --write --single-quote ".fullpath
  endif
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
nnoremap <silent><leader>f :Defx
      \ -columns=indent:icon:mark:filename
      \ -show-ignored-files
      \ -resume -listed<cr>
nnoremap <silent><leader>F :Defx -search=`expand('%:p')`
      \ -columns=indent:icon:mark:filename
      \ -show-ignored-files
      \ -resume -listed<cr>
function! s:defx_my_settings() abort
  call defx#custom#column('icon', {
        \ 'directory_icon': '▷',
        \ 'opened_icon': '▼',
        \ })
  call defx#custom#column('filename', {
        \ 'min_width': 50,
        \ 'max_width': 50,
        \ })
  nnoremap <silent><buffer><expr> <cr>
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> u
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> o
        \ defx#do_action('open_or_close_tree')
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
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
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
      \ 'coc-phpls',
      \ 'coc-pyright',
      \ 'coc-calc'
      \ ]

" Remap <C-u> and <C-d> for scroll float windows/popups.
nnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
vnoremap <silent><nowait><expr> <C-u> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"

" Remap keys for gotos, refresh
imap <silent><expr> <c-space> coc#refresh()
nmap <silent>gJ <Plug>(coc-float-jump)
nmap <silent>gH <Plug>(coc-float-hide)
nmap <silent>gj <Plug>(coc-diagnostic-next)
nmap <silent>gk <Plug>(coc-diagnostic-prev)
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)

" Symbol renaming.
nmap <leader>R <Plug>(coc-rename)

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent>K :call <SID>show_documentation()<cr>

"--- Debug ---"
Plug 'puremourning/vimspector'

"--- Git ---"
Plug 'tpope/vim-fugitive'
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>gs :Gstatus<cr>

"--- Utils ---"

Plug 'christoomey/vim-tmux-navigator'
let g:tmux_navigator_no_mappings = 1
nnoremap <silent> <A-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <A-j> :TmuxNavigateDown<cr>
nnoremap <silent> <A-k> :TmuxNavigateUp<cr>
nnoremap <silent> <A-l> :TmuxNavigateRight<cr>

Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['markdown', 'python']

Plug 'ntpeters/vim-better-whitespace'
let g:better_whitespace_filetypes_blacklist = []

Plug 'simeji/winresizer'
let g:winresizer_start_key='<leader>e'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 3

Plug 'tpope/vim-sleuth'
Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

Plug 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf
nnoremap <silent><leader>i :Files<cr>
nnoremap <silent><leader>o :Buffers<cr>
nnoremap <silent><leader>r :Rg<cr>
augroup customizeFzf
  autocmd! FileType fzf set noshowmode noruler
    \| autocmd BufLeave <buffer> set showmode ruler
augroup END

Plug 'stefandtw/quickfix-reflector.vim'
set grepprg=rg\ --vimgrep\ --hidden\
      \ --glob\ '!.git'\
      \ --glob\ '!.idea'\
      \ --glob\ '!.vscode'\
      \ --glob\ '!node_modules'\
      \ --glob\ '!vendor'\
      \ --glob\ '!composer'

"--- Provider ---"
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = expand("$HOME/.asdf/shims/python3")
let g:loaded_node_provider = 0
call plug#end()

"--- Customize theme ---"
set background=dark
colorscheme default
hi SignColumn            guifg=NONE guibg=NONE
hi Normal                guifg=NONE guibg=NONE
hi NonText               guifg=NONE guibg=NONE
hi LineNr                guibg=NONE
hi Pmenu                 guibg=#303030 guifg=NONE

