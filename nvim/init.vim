" Basic config
if exists('+termguicolors') " Enable true color
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

syntax on
set number
set hidden
set autoread autowrite
set incsearch hlsearch ignorecase smartcase
filetype plugin on
filetype indent on
set nobackup noswapfile nowritebackup
set splitbelow splitright
set autoindent smartindent
set lazyredraw
set nowrap
set colorcolumn=80
set signcolumn=yes
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set fileformats=unix,mac,dos
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,.git,*.pyc,__pycache__,.idea,*.o,*.obj,*rbc
set clipboard +=unnamedplus
set list listchars=eol:¬,tab:>·,trail:~,space:·
set backspace=indent,eol,start
set mouse=a
set updatetime=50

" Setting tab/space by language programing
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
autocmd FileType js, md, html, css, scss, json, vim
      \ setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
autocmd FileType php
      \ setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab shiftround

" Sync syntax highlight
autocmd BufEnter * :syntax sync fromstart

" Mapping
let mapleader = ' '
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
vnoremap < <gv
vnoremap > >gv
nnoremap <F1> <nop>
nnoremap Q <nop>
nnoremap K <nop>
nnoremap <silent><c-j> <c-w><c-j>
nnoremap <silent><c-k> <c-w><c-k>
nnoremap <silent><c-l> <c-w><c-l>
nnoremap <silent><c-h> <c-w><c-h>
nnoremap <silent><esc> :nohlsearch<cr>
nnoremap <silent>gj :bfirst<cr>
nnoremap <silent>gk :blast<cr>
nnoremap <silent>gh :bprevious<cr>
nnoremap <silent>gl :bnext<cr>
nnoremap <silent>gx :Bdelete<cr>
nnoremap <silent><leader>so :so ~/dotfiles/nvim/init.vim<cr>
nnoremap <silent><leader>vi :e ~/dotfiles/nvim/init.vim<cr>
nnoremap <silent><leader>qq :q<cr>
nnoremap <silent><leader>qa :qa<cr>
nnoremap <silent><leader>e :e!<cr>
nnoremap <silent><leader>w :w<cr>
nnoremap Y y$
nnoremap J mzJ`z
nnoremap n nzzzv
nnoremap N Nzzzv
tnoremap <silent><esc> <c-\><c-n>
tnoremap <silent><c-h> <c-\><c-n><c-w>h
tnoremap <silent><c-j> <c-\><c-n><c-k>j
tnoremap <silent><c-k> <c-\><c-n><c-w>k
tnoremap <silent><c-l> <c-\><c-n><c-w>l

" Disable netrw
let g:loaded_netrw = 1
let loaded_netrwPlugin = 1

" windows creation
nnoremap <leader>sp <c-w>s
nnoremap <leader>sv <c-w>v

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Faster keyword completion
set complete-=i   " disable scanning included files
set complete-=t   " disable searching tags

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
nnoremap <leader>at :call FloatTerm()<cr>

" Format source
function! QuickFormat()
  silent! wall
  let fullpath = expand('%:p')
  let extension = expand('%:e')
  let runner1 ="prettier"
  if extension == "js"
    let runner2 ="semistandard"
    execute ":! ".runner1." --write ".fullpath ." && "
          \ .runner2." --fix ".fullpath." | snazzy"
  elseif extension == "php"
    let runner2 ="php-cs-fixer"
    execute ":! ".runner1." --write ".fullpath." && "
          \ .runner2." fix --rules=@PSR2 ".fullpath." && rm .php_cs.cache"
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
nnoremap <leader>fe :call QuickFormat()<cr>

" Load plugin
call plug#begin()

" Setup colorscheme
Plug 'joshdick/onedark.vim'
set background=dark
" let g:onedark_color_overrides = {
      " \ "black": {"gui": "#242424", "cterm": "235", "cterm16": "0" },
      " \}

Plug 'tpope/vim-sensible'

Plug 'tpope/vim-eunuch'

Plug 'pbrisbin/vim-mkdir'

Plug 'moll/vim-bbye'

Plug 'simeji/winresizer'

Plug 'christoomey/vim-tmux-navigator'

Plug 'matze/vim-move'

Plug 'diepm/vim-rest-console'
autocmd FileType rest setlocal filetype=rest

Plug 'vim-vdebug/vdebug'

Plug 'ryanoasis/vim-devicons'
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']
let g:EditorConfig_core_mode = 'external_command'

Plug 'tpope/vim-repeat'
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

Plug 'tpope/vim-surround'

Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 0
let g:NERDTrimTrailingWhitespace = 1

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'terryma/vim-multiple-cursors'

Plug 'machakann/vim-highlightedyank'
let g:highlightedyank_highlight_duration = 50

Plug 't9md/vim-choosewin'
nmap <leader>cw :ChooseWin<cr>
nmap <leader>sw :ChooseWinSwap<cr>

Plug 'yangmillstheory/vim-snipe'
map <silent>f <Plug>(snipe-f)
map <silent>F <Plug>(snipe-F)

Plug 'benmills/vimux'
map <leader>vp :VimuxPromptCommand<CR>
map <leader>vq :VimuxCloseRunner<CR>
let g:VimuxHeight = '23'

Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsEditSplit="vertical"
nnoremap <leader>js :e ~/dotfiles/UltiSnips/javascript.snippets<cr>
nnoremap <leader>php :e ~/dotfiles/UltiSnips/php.snippets<cr>
nnoremap <leader>html :e ~/dotfiles/UltiSnips/html.snippets<cr>

Plug 'neoclide/coc.nvim'
let g:coc_global_extensions =
      \ [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-phpls',
      \ 'coc-python',
      \ 'coc-vimlsp',
      \ 'coc-svelte',
      \ 'coc-flutter',
      \ 'coc-angular',
      \ 'coc-html'
      \ ]

inoremap <silent><expr> <c-space> coc#refresh()
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gy <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>gt :Tags<cr>

" Create mappings for function text object
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
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
let g:lightline#bufferline#enable_devicons=1
let g:lightline#bufferline#unicode_symbols=1

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
      \ }
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

" Replace the default dictionary completion with fzf-based fuzzy completion
inoremap <expr> <c-x><c-k> fzf#vim#complete('cat /usr/share/dict/words')

nnoremap <silent><leader>ff :Files<cr>
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, <bang>0)

nnoremap <silent><leader>f. :Files <C-r>=expand("%:h")<cr>/<cr>

nnoremap <silent><leader>FF :GFiles<cr>
command! -bang -nargs=? -complete=dir GFiles
      \call fzf#vim#gitfiles(<q-args>, <bang>0)

nnoremap <silent><leader>fr :Rg<cr>
nnoremap <silent><leader>fb :Buffers<cr>
nnoremap <silent><leader>fm :Maps<cr>
nnoremap <silent><leader>fl :Lines<cr>
nnoremap <silent><leader>fc :Colors<cr>
nnoremap <silent><leader>fw :Windows<cr>
nnoremap <silent><leader>fg :Commits<cr>

autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
tnoremap <expr> <esc> (&filetype == "fzf") ? "<Esc>" : "<c-\><c-n>"

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdtree'
" let NERDTreeIgnore = ['^\.git$','^node_modules$']
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
highlight! link NERDTreeFlags NERDTreeDir
nnoremap tt :NERDTreeToggle<cr>
nnoremap tf :NERDTreeFocus<cr>
nnoremap rr :NERDTreeRefreshRoot<cr>
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

" Python
let g:loaded_python_provider = 0
let g:python3_host_prog = '~/.pyenv/shims/python3'
" Node

let g:node_host_prog=
      \ '/home/thevan96/.nvm/versions/node/v12.14.0/bin/neovim-node-host'
let g:coc_node_path=
      \ '/home/thevan96/.nvm/versions/node/v12.14.0/bin/node'

" Ruby
let g:ruby_host_prog ='~/.rbenv/versions/2.6.5/bin/neovim-ruby-host'

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

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }

"Text object
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line' "key l
Plug 'jasonlong/vim-textobj-css' "key c
Plug 'whatyouhide/vim-textobj-xmlattr' "key x
Plug 'machakann/vim-swap' " key a
omap ia <Plug>(swap-textobject-i)
xmap ia <Plug>(swap-textobject-i)
omap aa <Plug>(swap-textobject-a)
xmap aa <Plug>(swap-textobject-a)

Plug 'glts/vim-textobj-comment'

call plug#end()

colorscheme onedark
