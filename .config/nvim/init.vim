"--- General setting ---
set nobackup
set noswapfile
set encoding=utf-8

set autoread
set autowrite

set hlsearch
set incsearch
set ignorecase

set list
set listchars=tab:→\ ,lead:.,trail:\ |

set nonumber
set norelativenumber

set ruler
set laststatus=2
set signcolumn=no

set textwidth=80
set colorcolumn=+1

set cursorline
set cursorlineopt=number

set wildmenu
set wildmode=longest,list
set completeopt=menu,menuone

" Other
set mouse=
set showmatch
set autoindent
set backspace=0
set matchtime=0
set nofoldenable
set diffopt=vertical
set scrolloff=0

" Netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Disable
let html_no_rendering = 1
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab

" Set keymap
let mapleader = ' '

" Customizer mapping
xnoremap p pgvy
nnoremap gp `[v`]
nnoremap <C-l> :noh<cr>
nnoremap <leader>h yypVr=
nnoremap <leader>x :bd<cr>
nnoremap <leader>cc :set invspell<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'

" Virtual edit
nnoremap <leader>va :set virtualedit=all nolist<cr>
nnoremap <leader>vn :set virtualedit=none list<cr>

" Better relative number
nnoremap <silent><leader>n m':set relativenumber!<cr>
vnoremap <silent><leader>n <esc>m':set relativenumber!<cr>V
xnoremap <silent><leader>n <esc>m':set relativenumber!<cr>gv
nnoremap <silent><leader>N :set invnumber<cr>
vnoremap <silent><leader>N <esc>:set invnumber<cr>V
xnoremap <silent><leader>N <esc>:set invnumber<cr>gv

" Better search and replace all
nnoremap cn *``cgn
nnoremap cN #``cgN

" Buffer only
command! BufOnly exe '%bdelete|edit#|bdelete#'

" Current path to clipboard
command! CopyPath let @+ = expand('%')

" Navigate wrap
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Navigate quickfix/loclist
nnoremap go :copen<cr>
nnoremap gx :cclose<cr>
nnoremap gh :cprev<cr>
nnoremap gl :cnext<cr>
nnoremap gH :cfirst<cr>
nnoremap gL :clast<cr>

nnoremap zo :lopen<cr>
nnoremap zx :lclose<cr>
nnoremap zh :lprev<cr>
nnoremap zl :lnext<cr>
nnoremap zH :lfirst<cr>
nnoremap zL :llast<cr>

" Mapping copy clipboard and past
nnoremap <leader>y "+yy
vnoremap <leader>y "+y
nnoremap <leader>_ vg_"+y
nnoremap <leader>Y :%y+<cr>
nnoremap <leader>p o<esc>"+p
nnoremap <leader>P O<esc>"+p
vnoremap <leader>p "+p

" Fix conflict git
if &diff
  nnoremap <leader>1 :diffget LOCAL<cr>:diffupdate<cr>
  nnoremap <leader>2 :diffget BASE<cr>:diffupdate<cr>
  nnoremap <leader>3 :diffget REMOTE<cr>:diffupdate<cr>
  nnoremap <leader><cr> :diffupdate<cr>
  vnoremap <leader>= :GremoveMarkers<cr><gv>
endif

" Open in tab terminal
nnoremap <leader>" :silent
  \ exe(':!tmux split-window -v -p 50 -c '.expand('%:p:h'))<cr>
nnoremap <leader>% :silent
  \ exe(':!tmux split-window -h -p 50 -c '.expand('%:p:h'))<cr>

call plug#begin()

"--- Core plugins ---

" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'

" File manager
Plug 'stevearc/oil.nvim'
nnoremap <leader>ff :Oil<cr>
nnoremap <leader>fv :vsp+Oil<cr>
nnoremap <leader>fs :sp+Oil<cr>

Plug 'obaland/vfiler.vim'
nnoremap <leader>vv :VFiler<cr>
nnoremap <leader>vf :VFiler -find-file<cr>

" Fuzzy search
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'

" Send to quickfix
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

let rgIgnoreDirectories = "
  \ -g '!{**/.git/**,**/.idea/**, **/.vscode/**}'
  \ -g '!{**/node_modules/**,**/vendor/**, **/composer/**,**/gems/**}'"

let fdIgnoreDirectories = '
  \ --exclude .git
  \ --exclude .idea
  \ --exclude .vscode
  \ --exclude node_modules
  \ --exclude vendor
  \ --exclude composer
  \ --exclude gems '

let $FZF_DEFAULT_COMMAND = 'fd --type f -H '.fdIgnoreDirectories

command! Directories call fzf#run(fzf#wrap({
  \   'source': 'fd --type d -H '.fdIgnoreDirectories,
  \ }))

command! -bang -nargs=* Rg call fzf#vim#grep(
  \  'rg --hidden --column --line-number --no-heading --color=always
  \  --smart-case '.rgIgnoreDirectories.' '.shellescape(<q-args>),
  \  1, fzf#vim#with_preview(), <bang>0
  \ )

nnoremap <leader>i :Files<cr>
nnoremap <leader>d :Directories<cr>
nnoremap <leader>o :Buffers<cr>
nnoremap <leader>s :Rg<cr>
nnoremap <leader>S :Rg <c-r><c-w><cr>
autocmd! FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

"--- Other plugins ---
Plug 'mattn/emmet-vim'
Plug 'rlue/vim-barbaric'
Plug 'nvim-lua/plenary.nvim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }

Plug 'wellle/tmux-complete.vim'
let g:tmuxcomplete#trigger = 'omnifunc'

Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|'

Plug 'christoomey/vim-tmux-runner'
let g:VtrPercentage = 50
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
nnoremap <leader>ra :VtrAttachToPane<cr>
nnoremap <leader>rA :VtrUnsetRunnerPane<cr>
nnoremap <leader>rs :VtrSendCommandToRunner<cr>
nnoremap <leader>rl :VtrSendLinesToRunner<cr>
vnoremap <leader>rl :VtrSendLinesToRunner<cr>gv
nnoremap <leader>ro :VtrOpenRunner<cr>
nnoremap <leader>rk :VtrKillRunner<cr>
nnoremap <leader>rz :VtrFocusRunner<cr>
nnoremap <leader>rc :VtrClearRunner<cr>
nnoremap <leader>rC :VtrFlushCommand<cr>
nnoremap <leader>rd :VtrSendCtrlD<cr>

Plug 'vim-test/vim-test'
nnoremap <leader>tn :TestNearest<cr>
nnoremap <leader>tf :TestFile<cr>
nnoremap <leader>ts :TestSuite<cr>
nnoremap <leader>tl :TestLast<cr>
nnoremap <leader>tv :TestVisit<cr>

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
let g:mkdp_theme = 'light'
nnoremap <leader>mp :MarkdownPreviewToggle<cr>

call plug#end()

"--- Config Provider ---
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')

"--- Customize theme ---
syntax off
set background=dark
filetype indent off

hi clear Error
hi clear SignColumn
hi clear VertSplit

hi NonText                   ctermfg=none     ctermbg=none     cterm=none
hi Normal                    ctermfg=none     ctermbg=none     cterm=none
hi NormalFloat               ctermfg=none     ctermbg=none     cterm=none
hi Pmenu                     ctermfg=15       ctermbg=236      cterm=none
hi PmenuSel                  ctermfg=0        ctermbg=39       cterm=none

hi LineNr                    ctermfg=240      ctermbg=none     cterm=none
hi LineNrAbove               ctermfg=240      ctermbg=none     cterm=none
hi LineNrBelow               ctermfg=240      ctermbg=none     cterm=none
hi CursorLine                ctermfg=240      ctermbg=none     cterm=none
hi CursorLineNr              ctermfg=255      ctermbg=none     cterm=bold

hi ColorColumn               ctermfg=none     ctermbg=233      cterm=none
hi SpecialKey                ctermfg=235      ctermbg=none     cterm=none
hi Whitespace                ctermfg=235      ctermbg=none     cterm=none
hi ExtraWhitespace           ctermfg=196      ctermbg=196

"--- Function utils ---
function! Mkdir()
  let dir = expand('%:p:h')
  if dir =~ '://'
    return
  endif

  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction

function! GRemoveMarkers() range
  execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction
command! -range=% GremoveMarkers <line1>,<line2>call GRemoveMarkers()

function! Trim()
  silent! %s#\($\n\s*\)\+\%$## " trim end newlines
  silent! %s/\s\+$//e " trim whitespace
  silent! g/^\_$\n\_^$/d " single blank line
endfunction
command! Trim :call Trim()

augroup ConfigStyleTabOrSpace
  autocmd!
  autocmd BufNewFile,BufRead,BufWrite *.go
    \ setlocal tabstop=2 shiftwidth=2 noexpandtab | retab
  autocmd BufNewFile,BufRead,Bufwrite *.md
    \ setlocal tabstop=2 shiftwidth=2 expandtab | retab
augroup end

augroup RunFile
  autocmd!
  autocmd FileType javascript vnoremap <leader>rr :w !node<cr>
  autocmd FileType python vnoremap <leader>rr :w !python<cr>
augroup end

augroup ShowExtraWhitespace
  autocmd!
  autocmd BufRead,InsertLeave *.* match ExtraWhitespace /\s\+$/
  autocmd InsertEnter *.* match ExtraWhitespace /\s\+\%#\@<!$/
augroup end

augroup RelativeWorkingDirectory
  autocmd!
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup vimwikigroup
  autocmd!
  autocmd BufRead,BufNewFile diary.md VimwikiDiaryGenerateLinks
augroup end

augroup DisableNoiseLSP
  autocmd InsertEnter *.* lua vim.diagnostic.disable()
  autocmd BufWritePost *.* lua vim.diagnostic.enable()
augroup end

augroup LoadFile
  autocmd!
  autocmd VimResized * wincmd =
  autocmd BufWritePost * call Mkdir()
  autocmd CursorMoved,CursorMovedI * set norelativenumber
  autocmd BufReadPost *.* if line("'\"") > 1 && line("'\"") <= line("$")
    \ | exe "normal! g'\"" | endif
augroup end

"--- Load lua---
lua << EOF
  require 'module_lspconfig'
  require 'module_vfiler'
  require 'module_mason'
  require 'module_oil'
  require 'module_cmp'

  -- Without config
  require 'fidget'.setup()
EOF
