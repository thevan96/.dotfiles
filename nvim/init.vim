" Basic config
if exists('+termguicolors') " Enable true color
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
syntax on
set number
set hidden
set showcmd
set showmatch
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
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType js, md, html, css, scss, json
      \ setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
autocmd FileType php
      \ setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab

" Sync syntax highlight
autocmd BufEnter * :syntax sync fromstart

" Tweak for Markdown mode
autocmd FileType markdown call s:markdown_mode_setup()
function! s:markdown_mode_setup()
  set wrap
  set conceallevel=0
endfunction

" Save position cursor
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Mapping
let mapleader = ' '
vnoremap < <gv
vnoremap > >gv
nnoremap Y y$
nnoremap J mzJ`z
nnoremap n nzz
nnoremap N Nzz
noremap 0 g0
noremap $ g$
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap 0 ^
nnoremap $ g_
map Q <nop>
map K <nop>
map <F1> <nop>
map <silent>zo <c-w>=
map <silent>zi :NERDTreeClose<cr><c-w>_ \| <c-w>\|
nnoremap <silent><c-j> <c-w><c-j>
nnoremap <silent><c-k> <c-w><c-k>
nnoremap <silent><c-l> <c-w><c-l>
nnoremap <silent><c-h> <c-w><c-h>
nnoremap <silent><esc> :nohlsearch<cr>
nnoremap <silent>gx :Bdelete<cr>
nnoremap <silent>gh :bprevious<cr>
nnoremap <silent>gl :bnext<cr>
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>Q :qa!<cr>
nnoremap <silent><leader>w :w<cr>
tnoremap <silent><esc> <c-\><c-n>
tnoremap <silent><c-h> <c-\><c-n><c-w>h
tnoremap <silent><c-j> <c-\><c-n><c-k>j
tnoremap <silent><c-k> <c-\><c-n><c-w>k
tnoremap <silent><c-l> <c-\><c-n><c-w>l
" noremap <silent><leader>so :so ~/dotfiles/nvim/init.vim<cr>
" nnoremap <silent><leader>vi :e ~/dotfiles/nvim/init.vim<cr>

" Disable netrw
let g:loaded_netrw = 1
let loaded_netrwPlugin = 1

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Floating Term
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm(...)
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let top = "╭" . repeat("─", width + 2) . "╮"
  let mid = "│" . repeat(" ", width + 2) . "│"
  let bot = "╰" . repeat("─", width + 2) . "╯"
  let lines = [top] + repeat([mid], height) + [bot]
  let bbuf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(bbuf, 0, -1, v:true, lines)
  let s:float_term_border_win = nvim_open_win(bbuf, v:true, border_opts)
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:Normal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:Normal')
  if a:0 == 0
    terminal
  else
    call termopen(a:1)
  endif
  startinsert
  " Close border window when terminal window close
  autocmd TermClose * ++once :bd! |
        \ call nvim_win_close(s:float_term_border_win, v:true)
endfunction
nnoremap <silent><leader>at :call FloatTerm()<cr>

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
nnoremap <leader>f :call QuickFormat()<cr>

" Load plugin
call plug#begin()

" Setup colorscheme
Plug 'joshdick/onedark.vim'
set background=dark

Plug 'tpope/vim-eunuch'

Plug 'moll/vim-bbye'

Plug 'simeji/winresizer'
let g:winresizer_vert_resize=3
let g:winresizer_horiz_resize=3

Plug 'christoomey/vim-tmux-navigator'

Plug 'diepm/vim-rest-console'
autocmd FileType rest setlocal filetype=rest

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<C-Z>'

Plug 'liuchengxu/vista.vim'
map <silent><leader>vt :Vista coc<cr>
map <silent><leader>vs :Vista finder coc<cr>:Vista coc<cr>
map <silent><leader>vf :Vista focus<cr>
let g:vista_sidebar_width= 33

Plug 'ryanoasis/vim-devicons'
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_fileTypeExclude = ['markdown']

Plug 'jiangmiao/auto-pairs'

Plug 'matze/vim-move'

Plug 'tpope/vim-repeat'
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'terryma/vim-multiple-cursors'

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 100

Plug 'itchyny/vim-cursorword'

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
let g:UltiSnipsJumpForwardTrigger="<c-n>"
let g:UltiSnipsJumpBackwardTrigger="<c-p>"

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

" Create mappings for function text object
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

Plug 'mengelbrecht/lightline-bufferline'

Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'absolutepath'] ],
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'method': 'NearestMethodOrFunction'
      \   }
      \ }
set showtabline=2
let g:lightline.tabline          = {'left': [['buffers']], 'right':[[]]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
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

Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_autoclose=0

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

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
tnoremap <expr> <esc> (&filetype == "fzf") ? "<esc>" : "<c-\><c-n>"

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
let NERDTreeIgnore = ['^\.git$','^node_modules$', '^vendor$']
let g:NERDTreeWinPos = 'left'
let NERDTreeMinimalUI = 1
let NERDTreeMinimalMenu = 0
let NERDTreeShowHidden = 1
let NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeMapJumpNextSibling = '<nop>'
let g:NERDTreeMapJumpPrevSibling = '<nop>'
highlight! link NERDTreeFlags NERDTreeDir
nnoremap <silent><leader>nt :NERDTreeToggle<cr>
nnoremap <silent><leader>nf :NERDTreeFind<cr>
nnoremap <silent><leader>nr :NERDTreeRefreshRoot<cr>
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ 'Ignored'   : '☒',
      \ "Unknown"   : "?"
      \ }

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

" Blade
Plug 'jwalton512/vim-blade'
autocmd BufNewFile,BufRead *.blade.php set ft=html | set ft=phtml | set ft=blade

" Flutter, dart
Plug 'dart-lang/dart-vim-plugin'
Plug 'thosakwe/vim-flutter'
nnoremap <leader>dr :FlutterRun<cr>
nnoremap <leader>dq :FlutterQuit<cr>
nnoremap <leader>dh :FlutterHotReload<cr>
nnoremap <leader>dR :FlutterHotRestart<cr>
nnoremap <leader>dd :FlutterVisualDebug<cr>

"Javascript
Plug 'Galooshi/vim-import-js'

"Text object
Plug 'wellle/targets.vim' "textobject + n + target
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire' "key e
Plug 'kana/vim-textobj-line' "key l
Plug 'jasonlong/vim-textobj-css' "key c
Plug 'whatyouhide/vim-textobj-xmlattr' "key x
Plug 'kana/vim-textobj-indent' "key i
Plug 'adriaanzon/vim-textobj-blade-directive' "key d
Plug 'machakann/vim-swap' "key s
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

colorscheme onedark
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
