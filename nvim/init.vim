" General setting
syntax on
set nocompatible
set number
set hidden
set showcmd
set nocursorcolumn
set nocursorline
set autoread autowrite
set incsearch hlsearch ignorecase smartcase
set nobackup noswapfile nowritebackup
set splitbelow splitright
set autoindent smartindent
filetype plugin on
filetype indent on
set synmaxcol=256
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
set lazyredraw
set foldmethod=indent
set showtabline=2

" Setting tab/space by language programing
set tabstop=2 shiftwidth=2 expandtab
autocmd FileType js, md, html, css, scss, json
      \ setlocal tabstop=2 shiftwidth=2 expandtab
autocmd FileType php
      \ setlocal tabstop=4 shiftwidth=4 expandtab

map <F7> :if exists("g:syntax_on")<cr>
      \    syntax off <cr>
      \  else <cr>
      \    syntax on <cr>
      \ hi VertSplit ctermbg=NONE ctermfg=NONE <cr>
      \ hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE <cr>
      \ hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE <cr>
      \ hi Comment cterm=italic gui=italic <cr>
      \  endif <cr>
      \  <cr>

" Sync syntax highlight
autocmd BufEnter * :syntax sync fromstart

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

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Disable netrw
let g:loaded_netrw = 1
let loaded_netrwPlugin = 1

" Mapping leader
let mapleader = ' '

" Fast command
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>Q :qa!<cr>

" Remap yank
nnoremap Y y$

" Begin, end move fast ($, ^, 0)
map H ^
map L $

" Overide jk, >, <
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Indent
vnoremap >> >gv
vnoremap << <gv

" Disable highlight search
nnoremap <silent><esc> :nohlsearch<cr>

" Manager buffer
nnoremap <silent>gl :bnext<cr>
nnoremap <silent>gh :bprevious<cr>
nnoremap <silent>gx :Bdelete<cr>
nnoremap <silent>gv =G
nnoremap <silent>gs <c-^>

" Split window
nnoremap <silent>ss :split<cr>
nnoremap <silent>sv :vsplit<cr>

" Move window
nnoremap sj <c-w><c-j>
nnoremap sk <c-w><c-k>
nnoremap sl <c-w><c-l>
nnoremap sh <c-w><c-h>

" Zoom in, zoom out
nnoremap <silent>si :call defx#do_action('quit')<cr><c-w>_ \| <c-w>\|
nnoremap <silent>so <c-w>=

" Note setup Zettelkasten method
function! Note(...)
  let path = strftime("%Y%m%d%H%M")."-".trim(join(a:000, '-')).".md"
  execute ":e " . fnameescape(path)
endfunction
command! -nargs=* Note call Note(<f-args>)
nnoremap <leader>n :Note<space>

" Format source
function! QuickFormat()
  silent! wall
  let fullpath = expand('%:p')
  let listExtension = split(expand('%t'), '\.')
  let runner1 = "prettier" " List format tool
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

" Rename curren file
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>R :call RenameFile()<cr>

" Load plugin
call plug#begin()

" Setup colorscheme
Plug 'altercation/vim-colors-solarized'
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

Plug 'tpope/vim-eunuch'
nnoremap <leader>R :Rename<space>

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
let g:highlightedyank_highlight_duration = 250

Plug 't9md/vim-choosewin'
nmap <leader>sw :ChooseWinSwap<cr>

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

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'angr'
let g:airline_powerline_fonts = 1
let g:airline_detect_crypt = 1
let g:airline_detect_paste = 1
let g:airline_detect_modified = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1

if isdirectory('~/.fzf/bin/fzf')
  Plug '~/.fzf/bin/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-x': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nnoremap <silent><leader>i :Files<cr>
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse']}, <bang>0)

nnoremap <silent><leader>l :Files <C-r>=expand("%:h")<cr>/<cr>

nnoremap <silent><leader>o :Buffers<cr>
command! -bang -nargs=? -complete=dir Buffers
      \ call fzf#vim#buffers({'options': ['--layout=reverse']}, <bang>0)

nnoremap <silent><leader>f :Rg <c-r><c-w><cr>
nnoremap <silent><leader>r :Rg<cr>
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
      \ 1,
      \ fzf#vim#with_preview({'options': ['--layout=reverse']}), <bang>0)

tnoremap <expr> <esc> (&filetype == "fzf") ? "<esc>" : "<c-\><c-n>"
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

Plug 'Shougo/defx.nvim'
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'

nnoremap <silent>ff :Defx -search=`expand('%:p')` -columns=mark:indent:icons:git:filename:type -split=vertical -winwidth=30 -direction=topleft -show-ignored-files<cr>
autocmd BufWritePost * call defx#redraw()

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  call defx#custom#column('filename', {
        \ 'min_width': '100'
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
  nnoremap <silent><buffer><expr> C
        \ defx#do_action('redraw')
endfunction

" PHP
Plug 'captbaritone/better-indent-support-for-php-with-html'

" HTML, CSS
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

" Hilight syntax language
Plug 'othree/yajs.vim'
Plug 'jwalton512/vim-blade'
Plug 'othree/html5.vim'
Plug 'tpope/vim-markdown'
let g:markdown_syntax_conceal = 0

" Text object
Plug 'kana/vim-textobj-user' " Core textobject customer
Plug 'wellle/targets.vim' " Textobject + n + target
Plug 'kana/vim-textobj-line' " Key l
Plug 'kana/vim-textobj-entire' " Key e
Plug 'jasonlong/vim-textobj-css' " Key c
Plug 'whatyouhide/vim-textobj-xmlattr' " Key x
Plug 'kana/vim-textobj-indent' " Key i
Plug 'b4winckler/vim-angry' " key a

" Provider
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('$HOME/.pyenv/shims/python3')
let g:node_host_prog = expand('$HOME/.nvm/versions/node/v12.14.1/bin/neovim-node-host')
let g:coc_node_path =  expand('$HOME/.nvm/versions/node/v12.14.1/bin/node')
let g:ruby_host_prog = expand('$HOME/.rbenv/versions/2.7.0/bin/neovim-ruby-host')

" Config solarized true color
let g:solarized_termcolors = 16
let g:solarized_italic = 1
let g:solarized_bold = 1
let g:solarized_underline = 1
let g:solarized_termtrans = 1
let g:solarized_visibility = 'low'
let g:solarized_diffmode = 'low'
let g:solarized_contrast = 'normal'

call plug#end()

colorscheme solarized
hi VertSplit ctermbg=NONE ctermfg=NONE
hi Pmenu ctermfg=NONE ctermbg=NONE cterm=NONE
hi PmenuSel ctermfg=NONE ctermbg=24 cterm=NONE
hi Comment cterm=italic gui=italic
