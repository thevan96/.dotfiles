"--- General setting ---
set nobackup
set noswapfile
set spelllang=en_us
set encoding=utf-8
set autoread autowrite
set list listchars=tab:→\ ,lead:.,trail:\ |
set number relativenumber
set signcolumn=no
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
inoremap <C-l> <C-o>:noh<cr>
nnoremap <leader>h yypVr-
nnoremap <leader>H yypVr=
nnoremap <leader>fm :Format<cr>
nnoremap <leader>C :set invspell<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
" inoremap <C-Space> <C-x><C-o>
inoremap <C-Space> <nop>
inoremap <C-x><C-o> <nop>
nnoremap Zz <c-w>_ \| <c-w>\|
nnoremap Zo <c-w>=

" Remap omnifunc
inoremap <expr> <C-h>
  \ (pumvisible() && &omnifunc != '' ? '<C-h><C-x><C-o>' : '<C-h>')
inoremap <expr> <BS>
  \ (pumvisible() && &omnifunc != '' ? '<BS><C-x><C-o>' : '<BS>')
inoremap <expr> <C-w>
  \ (pumvisible() && &omnifunc != '' ? '<C-w><C-x><C-o>' : '<C-w>')

" Align table
au BufNewFile,BufRead *.md,*.txt
  \ vnoremap <leader>ft :'<,'>!prettier --parser markdown<cr>
au BufNewFile,BufRead *.md,*.txt
  \ nnoremap <leader>ft vip:'<,'>!prettier --parser markdown<cr>

" Virtual edit
nnoremap <leader>Va :set virtualedit=all nolist<cr>
nnoremap <leader>Vn :set virtualedit=none list<cr>

" Toggle relative number
nnoremap <silent><leader>N :set invrelativenumber<cr>

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

nnoremap <leader>so :lopen<cr>
nnoremap <leader>sx :lclose<cr>
nnoremap [s :lprev<cr>
nnoremap ]s :lnext<cr>
nnoremap [s :lfirst<cr>
nnoremap ]s :llast<cr>

nnoremap <leader>ao :args<cr>
nnoremap <leader>aa :argadd %<cr>:argdedupe<cr>
nnoremap <leader>ax :args<cr>:argdelete<space>
nnoremap <leader>aX :argdelete *<cr>:echo 'clear args list'<cr>
nnoremap [a :previous<cr>:args<cr>
nnoremap ]a :next<cr>:args<cr>
nnoremap [A :first<cr>:args<cr>
nnoremap ]A :last<cr>:args<cr>

" Mapping copy clipboard and past
noremap <leader>y "+yy
noremap <leader>p "+p
nnoremap <leader>_ vg_"+y
nnoremap <leader>Y :%y+<cr>

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
Plug 'machakann/vim-swap'
Plug 'tommcdo/vim-exchange'
Plug 'kylechui/nvim-surround'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'

Plug 'lambdalisue/suda.vim'
command! W exe 'SudaWrite'

Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
nmap <silent> <leader>D <Plug>(doge-generate)

Plug 'christoomey/vim-tmux-runner'
let g:VtrPercentage = 50
let g:VtrOrientation = 'h'
nnoremap <leader>va :VtrAttachToPane<cr>
nnoremap <leader>vA :VtrUnsetRunnerPane<cr>
nnoremap <leader>vs :VtrSendCommandToRunner<cr>
nnoremap <leader>vl :VtrSendLinesToRunner<cr>
vnoremap <leader>vl :VtrSendLinesToRunner<cr>gv
nnoremap <leader>vo :VtrOpenRunner<cr>
nnoremap <leader>vx :VtrKillRunner<cr>
nnoremap <leader>vz :VtrFocusRunner<cr>
nnoremap <leader>vf :VtrFlushCommand<cr>
nnoremap <leader>vd :VtrSendCtrlD<cr>
nnoremap <leader>vc :VtrSendCtrlC<cr>
nnoremap <leader>vC :VtrClearRunner<cr>

function! SendCommand(command)
  if a:command == ''
    return
  endif
  exe 'VtrSendCommandToRunner '.a:command
endfunction

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

hi DiagnosticUnderlineError  ctermfg=196    ctermbg=none   cterm=underline
hi DiagnosticUnderlineWarn   ctermfg=226    ctermbg=none   cterm=underline
hi DiagnosticUnderlineInfo   ctermfg=39     ctermbg=none   cterm=underline
hi DiagnosticUnderlineHint   ctermfg=34     ctermbg=none   cterm=underline

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
  elseif index(['html', 'css', 'scss', 'yaml', 'json'], extension) >= 0
    !prettier -w %
  elseif filereadable('package.json')
    if filereadable('node_modules/bin/prettier')
      !npx prettier -w %
    elseif filereadable('node_modules/bin/standard')
      !npx standard --fix %
    elseif filereadable('node_modules/bin/eslint')
      !npx eslint --fix %
    endif
  elseif extension == 'js' || extension == 'jsx'
    !standard --fix %
  elseif extension == 'ts' || extension == 'tsx'
    !ts-standard --fix %
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

function! Presentation()
  let save_pos = getpos('.')
  let start_row = searchpos('\s*```', 'bn')[0]+1
  let end_row = searchpos('\s*```', 'n')[0]-1

  if start_row > end_row
    return
  endif

  let line_language = searchpos('\s*```', 'bn')[0]
  let lang = matchlist(getline(line_language), '\([`~]\{3,}\)\(\S\+\)\?')[2]

  if lang == 'go'
    let start_row = searchpos('\s*```', 'bn')[0]+1
    let end_row = searchpos('\s*```', 'n')[0]-1
    silent exe start_row.','.end_row.'w! /tmp/main.go'
  elseif lang == 'js'
    let start_row = searchpos('\s*```', 'bn')[0]+1
    let end_row = searchpos('\s*```', 'n')[0]-1

    silent exe start_row.','.end_row.'w! /tmp/main.js'
  endif
  call setpos('.', save_pos)
endfunction

au BufNewFile,BufRead *.md,*.txt
  \ nnoremap <silent><leader>P :w<cr>:call Presentation()<cr>

augroup ConfigStyleTabOrSpace
  au!
  au BufNewFile,BufRead *.go setlocal tabstop=2 shiftwidth=2 noexpandtab
  au BufNewFile,BufRead *.rs setlocal tabstop=4 shiftwidth=4 expandtab
  au BufNewFile,BufRead *.md setlocal tabstop=2 shiftwidth=2 expandtab
  au BufNewFile,BufRead Makefile setlocal tabstop=2 shiftwidth=2 noexpandtab
augroup end

augroup Test
  au!
  au BufNewFile,BufRead *.go nnoremap <leader>tf
    \ :!go test -v %:p:h<cr>
  au BufNewFile,BufRead *.go nnoremap <leader>tt
    \ :!go test ./...<cr>
augroup end

augroup ShowExtraWhitespace
  au!
  au InsertLeave * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
augroup end

augroup RelativeWorkingDirectory
  au!
  au InsertEnter * let save_cwd = getcwd() | silent! lcd %:h
  au InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup JumpQuickfx
  au QuickFixCmdPost [^l]* nested cwindow
  au QuickFixCmdPost    l* nested lwindow
augroup end

augroup LoadFile
  au!
  au VimResized * wincmd =
  au CursorMoved *.* checktime
  au BufWritePost * call Trim()
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
