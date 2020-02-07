" Enable true color
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
set showmatch
set nocompatible
set autoread autowrite
set incsearch hlsearch ignorecase smartcase
filetype plugin on
filetype indent on
set nobackup noswapfile nowritebackup
set splitbelow splitright
set autoindent smartindent
set lazyredraw
set shortmess+=c
set cmdheight=1
set nowrap
set mouse=a
set updatetime=100
set signcolumn=yes
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,mac,dos
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*.pyc,__pycache__,.idea,*.o,*.obj,*rbc
set clipboard=unnamedplus
set list listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set backspace=indent,eol,start
set whichwrap=<,>,h,l

" Setting tab/space by language programing
set tabstop=2 shiftwidth=2
set softtabstop=0 expandtab
autocmd FileType md, html, css, scss, json
      \ setlocal tabstop=2 shiftwidth=2 softtabstop=0 expandtab
autocmd FileType php, js
      \ setlocal tabstop=4 shiftwidth=4 softtabstop=0 noexpandtab

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

" Mapping leader
let mapleader = ' '

" Disable nop
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
map <F1> <nop>
map Q <nop>
map K <nop>

" Remap key
vnoremap < <gv
vnoremap > >gv
nnoremap Y y$
nnoremap J mzJ`z
nnoremap n nzz
nnoremap N Nzz
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Fast command
nnoremap <silent><leader>q :q!<cr>
nnoremap <silent><leader>Q :qa!<cr>
nnoremap <silent><leader>w :w!<cr>
nnoremap <silent><leader>so :so ~/dotfiles/nvim/init.vim<cr>
nnoremap <silent><leader>vi :e ~/dotfiles/nvim/init.vim<cr>

" Remap scrolling
nnoremap H <C-u>
nnoremap L <C-d>

" Zoom in, zoom out
nnoremap <silent>zo :call defx#do_action('quit')<cr><c-w>_ \| <c-w>\|
nnoremap <silent>zi <c-w>=

" Disable highlight search
nnoremap <silent><esc> :nohlsearch<cr>

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
let g:winresizer_vert_resize=3
let g:winresizer_horiz_resize=3

Plug 'moll/vim-bbye'

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'

Plug 'liuchengxu/vista.vim'
map <silent><leader>vt :Vista coc<cr>
map <silent><leader>vs :Vista finder coc<cr>:Vista coc<cr>
map <silent><leader>vf :Vista focus<cr>
let g:vista_sidebar_width= 35

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['markdown']

Plug 'jiangmiao/auto-pairs'

Plug 'tpope/vim-repeat'
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 100

Plug 't9md/vim-choosewin'
nmap <leader>sw :ChooseWinSwap<cr>

Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

Plug 'osyo-manga/vim-anzu'
nmap n <Plug>(anzu-n-with-echo)
nmap N <Plug>(anzu-N-with-echo)
set statusline=%{anzu#search_status()}

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

" Use D to show documentation in preview window
nnoremap <silent>D :call <SID>show_documentation()<CR>
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

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste'], [ 'fugitive', 'absolutepath'] ],
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'method': 'NearestMethodOrFunction',
      \ }
      \}

let g:lightline.component_type   = {'buffers': 'tabsel'}
function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction

function! LightlineModified()
  return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

if isdirectory('~/.fzf/bin/fzf')
  Plug '~/.fzf/bin/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

nnoremap <silent><leader>o :Files<cr>
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, <bang>0)

nnoremap <silent><leader>l :Files <C-r>=expand("%:h")<cr>/<cr>

nnoremap <silent><leader>b :Buffers<cr>
command! -bang -nargs=? -complete=dir Buffers
      \ call fzf#vim#buffers(<bang>0)

nnoremap <silent><leader>r :Rg<cr>
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
      \ 1,
      \ fzf#vim#with_preview(), <bang>0)

nnoremap <silent><leader>k :Maps<cr>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
tnoremap <expr> <esc> (&filetype == "fzf") ? "<esc>" : "<c-\><c-n>"

Plug 'Shougo/defx.nvim'
Plug 'kristijanhusak/defx-git'
Plug 'kristijanhusak/defx-icons'
let g:defx_icons_enable_syntax_highlight = 0
nnoremap <silent>ff :Defx -search=`expand('%:p')` -columns=mark:indent:icons:git:filename -split=vertical -winwidth=32 -direction=topleft -show-ignored-files<cr>
nnoremap <silent>tt :Defx -columns=mark:indent:icons:git:filename -split=vertical -winwidth=32 -direction=topleft -show-ignored-files<cr>

autocmd BufWritePost * call defx#redraw()
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
  " Define mapping
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
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> D
        \ defx#do_action('remove')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> f
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> t
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> T
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> > defx#do_action('resize',
        \ defx#get_context().winwidth + 5)
  nnoremap <silent><buffer><expr> < defx#do_action('resize',
        \ defx#get_context().winwidth - 5)
  nnoremap <silent><buffer><expr> <esc>
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
  nnoremap <silent><buffer><expr> !
        \ defx#do_action('execute_command')
  nnoremap <silent><buffer><expr> i
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
endfunction

" Syntax all language programe
Plug 'sheerun/vim-polyglot'

" PHP => map <leader>p
Plug 'captbaritone/better-indent-support-for-php-with-html'

Plug 'Rican7/php-doc-modded'
let g:pdv_cfg_autoEndFunction = 0
let g:pdv_cfg_autoEndClass = 0
let g:pdv_cfg_annotation_Package = 0
let g:pdv_cfg_annotation_Version = 0
let g:pdv_cfg_annotation_Author = 0
let g:pdv_cfg_annotation_Copyright = 0
let g:pdv_cfg_annotation_License = 0

Plug 'adoy/vim-php-refactoring-toolbox'
let g:vim_php_refactoring_auto_validate_sg = 1
let g:vim_php_refactoring_auto_validate_g = 1
let g:vim_php_refactoring_auto_validate_rename = 1
let g:vim_php_refactoring_use_default_mapping = 0
nnoremap <silent><leader>prv :call PhpRenameLocalVariable()<cr>
nnoremap <silent><leader>prc :call PhpRenameClassVariable()<cr>
nnoremap <silent><leader>prm :call PhpRenameMethod()<cr>
nnoremap <silent><leader>peu :call PhpExtractUse()<cr>
vnoremap <silent><leader>pec :call PhpExtractConst()<cr>
nnoremap <silent><leader>pep :call PhpExtractClassProperty()<cr>
vnoremap <silent><leader>pem :call PhpExtractMethod()<cr>
nnoremap <silent><leader>pcp :call PhpCreateProperty()<cr>
nnoremap <silent><leader>pdu :call PhpDetectUnusedUseStatements()<cr>
vnoremap <silent><leader>p== :call PhpAlignAssigns()<cr>
nnoremap <silent><leader>psg :call PhpCreateSettersAndGetters()<cr>
nnoremap <silent><leader>pcg :call PhpCreateGetters()<cr>
nnoremap <silent><leader>pda :call PhpDocAll()<cr>
nnoremap <silent><leader>pds :call UpdatePhpDocIfExists()<cr>
function! UpdatePhpDocIfExists()
  normal! k
  if getline('.') =~ '/'
    normal! V%d
  else
    normal! j
  endif
  call PhpDocSingle()
  normal! k^%k$
  if getline('.') =~ ';'
    exe "normal! $svoid"
  endif
endfunction

"HTML, CSS
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

"Text object
Plug 'kana/vim-textobj-user' " Core textobject customer
Plug 'wellle/targets.vim' " Textobject + n + target
Plug 'kana/vim-textobj-entire' " Key e
Plug 'kana/vim-textobj-line' " Key l
Plug 'jasonlong/vim-textobj-css' " Key c
Plug 'whatyouhide/vim-textobj-xmlattr' " Key x
Plug 'kana/vim-textobj-indent' " Key i
Plug 'adriaanzon/vim-textobj-blade-directive' " Key d
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

colorscheme one
hi Normal     ctermbg=NONE guibg=NONE
