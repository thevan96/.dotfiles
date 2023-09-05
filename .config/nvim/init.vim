"--- General setting ---
set nobackup
set noswapfile
set spelllang=en_us
set encoding=utf-8
set autoread autowrite
set list listchars=tab:→\ ,lead:.,trail:\ |
set number norelativenumber
set signcolumn=yes
set textwidth=80
set colorcolumn=80
set cursorline cursorlineopt=number
set wildmode=longest,list
set completeopt=menu,menuone,noinsert
set noshowcmd
set backspace=0
set nofoldenable
set guicursor=i:block
set mouse=

" Netrw
let g:loaded_netrw = 0
let g:loaded_netrwPlugin = 0

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab

" Set keymap
let mapleader = ' '

" Customizer mapping
xnoremap p pgvy
nnoremap gV `[v`]
nnoremap <C-l> :noh<cr>
nnoremap <leader>h yypVr-
nnoremap <leader>H yypVr=
inoremap <C-l> <C-o>:noh<cr>
nnoremap <leader>fm :Format<cr>
nnoremap <leader>C :set invspell<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Disable autocomplete
inoremap <C-n> <nop>
inoremap <C-p> <nop>
inoremap <C-x><C-n> <nop>
inoremap <C-x><C-p> <nop>
inoremap <C-x><C-o> <nop>

" Remap omnifunc
inoremap <expr> <C-h>
  \ (pumvisible() && &omnifunc != '' ? '<C-h><C-x><C-o>' : '<C-h>')
inoremap <expr> <BS>
  \ (pumvisible() && &omnifunc != '' ? '<BS><C-x><C-o>' : '<BS>')
inoremap <expr> <C-w>
  \ (pumvisible() && &omnifunc != '' ? '<C-w><C-x><C-o>' : '<C-w>')

" Align table
vnoremap <leader>ft :'<,'>!prettier --parser markdown<cr>
nnoremap <leader>ft vip:'<,'>!prettier --parser markdown<cr>

" Virtual edit
nnoremap <leader>va :set virtualedit=all nolist<cr>
nnoremap <leader>vn :set virtualedit=none list<cr>

" Toggle relative number/number
nnoremap <silent><leader>N :set invnumber<cr>
nnoremap <silent><leader>n :set invrelativenumber<cr>
vnoremap <silent><leader>n <esc>:set invrelativenumber<cr>V
xnoremap <silent><leader>n <esc>:set invrelativenumber<cr>gv

" Relativenumber keep jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Buffer only
command! BufOnly exe '%bdelete|edit#|bdelete#'

" Current path to clipboard
command! Path let @+ = expand('%')
command! Dpath let @+ = expand('%:h')

" Navigate quickfix/loclist
nnoremap <leader>qo :copen<cr>
nnoremap <leaer>qx :cclose<cr>
nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>

nnoremap <leader>zo :lopen<cr>
nnoremap <leader>zx :lclose<cr>
nnoremap [z :lprev<cr>
nnoremap ]z :lnext<cr>
nnoremap [Z :lfirst<cr>
nnoremap ]Z :llast<cr>

nnoremap [a :previous<cr>
nnoremap ]a :next<cr>
nnoremap [A :first<cr>
nnoremap ]A :last<cr>

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

" Fuzzy search
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'

let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }
let g:fzf_layout = { 'down': '~40%' }

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
nnoremap <leader>o :Buffers<cr>
nnoremap <leader>d :Directories<cr>
nnoremap <leader>s :Rg<cr>
nnoremap <leader>S :Rg <c-r><c-w><cr>
nnoremap <leader>T :Snippets<cr>
au! FileType fzf set laststatus=0 noshowmode noruler
  \| au BufLeave <buffer> set laststatus=2 showmode ruler

"--- Other plugins ---
Plug 'mattn/emmet-vim'
Plug 'rlue/vim-barbaric'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }

Plug 'jpalardy/vim-slime'
let g:slime_target = 'tmux'
let g:slime_default_config = {'socket_name': 'default', 'target_pane': '{last}'}
let g:slime_dont_ask_default = 1

Plug 'lambdalisue/suda.vim'
command! W exe 'SudaWrite'

Plug 'tommcdo/vim-exchange'
Plug 'kylechui/nvim-surround'

Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'

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
filetype plugin indent off

hi SignColumn                ctermfg=none   ctermbg=none   cterm=none
hi NormalFloat               ctermfg=none   ctermbg=none   cterm=none
hi Pmenu                     ctermfg=15     ctermbg=236    cterm=none
hi PmenuSel                  ctermfg=0      ctermbg=39     cterm=none

hi LineNr                    ctermfg=242    ctermbg=none   cterm=none
hi LineNrAbove               ctermfg=242    ctermbg=none   cterm=none
hi LineNrBelow               ctermfg=242    ctermbg=none   cterm=none
hi CursorLine                ctermfg=242    ctermbg=none   cterm=none
hi CursorLineNr              ctermfg=255    ctermbg=none   cterm=bold,underline

hi SpecialKey                ctermfg=236    ctermbg=none   cterm=none
hi Whitespace                ctermfg=236    ctermbg=none   cterm=none
hi ExtraWhitespace           ctermfg=196    ctermbg=196    cterm=none
hi ColorColumn               ctermfg=none   ctermbg=233    cterm=none

hi DiagnosticError           ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticWarn            ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticInfo            ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticHint            ctermfg=34     ctermbg=none   cterm=none

hi DiagnosticSignError       ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticSignWarn        ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticSignInfo        ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticSignHint        ctermfg=34     ctermbg=none   cterm=none

hi DiagnosticFloatingError   ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticFloatingWarn    ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticFloatingInfo    ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticFloatingHint    ctermfg=34     ctermbg=none   cterm=none

hi DiagnosticUnderlineError  ctermfg=none   ctermbg=none   cterm=underline
hi DiagnosticUnderlineWarn   ctermfg=none   ctermbg=none   cterm=underline
hi DiagnosticUnderlineInfo   ctermfg=none   ctermbg=none   cterm=underline
hi DiagnosticUnderlineHint   ctermfg=none   ctermbg=none   cterm=underline

"--- Function utils ---
function! GRemoveMarkers() range
  execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction
command! -range=% GremoveMarkers <line1>,<line2>call GRemoveMarkers()

function! IsInCurrentProject()
  let pwd = getcwd()
  let file = expand('%:p:h')

  return stridx(file, pwd) >= 0
endfunction

function! Trim()
  if !&binary && IsInCurrentProject()
    silent! %s#\($\n\s*\)\+\%$## " trim end newlines
    silent! %s/\s\+$//e " trim whitespace
    silent! g/^\_$\n\_^$/d " single blank line
    silent! w
  endif
endfunction
command! Trim :call Trim()

function! Format()
  if !IsInCurrentProject()
    return
  endif

  let extension = expand('%:e')
  call Trim()
  if extension == 'go'
	  !goimports -w . && golines -m 80 -w .
  elseif extension == 'rs'
    !rufmt %
  elseif extension == 'lua'
    !stylua %
  elseif extension == 'sql'
    !sqlfluff fix --dialect postgres -f %
  elseif extension == 'md'
    !prettier --prose-wrap always -w %
  elseif index(['css', 'scss', 'html'], extension) >= 0
    !prettier -w %
  endif
endfunction
command! Format :call Format()

function! Scratch()
  new
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal ft=scratch
endfunction
command! Scratch :call Scratch()

augroup ConfigStyleTabOrSpace
  au!
  au BufNewFile,BufRead *.go setlocal tabstop=2 shiftwidth=2 noexpandtab
  au BufNewFile,BufRead *.rs setlocal tabstop=4 shiftwidth=4 expandtab
  au BufNewFile,BufRead *.md setlocal tabstop=2 shiftwidth=2 expandtab
  au BufNewFile,BufRead Makefile setlocal tabstop=2 shiftwidth=2 noexpandtab
augroup end

augroup ShowExtraWhitespace
  au!
  au InsertLeave * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
augroup end

augroup RelativeWorkingDirectory
  au!
  au InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  au InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup JumpQuickfx
  au QuickFixCmdPost [^l]* nested cwindow
  au QuickFixCmdPost    l* nested lwindow
augroup end

augroup DisableNoiseLSP
  au BufWrite * lua vim.diagnostic.enable()
  au InsertEnter * lua vim.diagnostic.disable()
augroup end

augroup LoadFile
  au!
  au VimResized * wincmd =
  au CursorMoved * checktime
  au BufWritePost * call Trim()
  au CursorMoved,CursorMovedI * set norelativenumber
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup end

"--- Load lua---
lua << EOF
  require 'module_lspconfig'
  require 'module_mason'
  require 'module_oil'

  -- Without config
  require 'fidget'.setup()
  require 'nvim-surround'.setup()
EOF
