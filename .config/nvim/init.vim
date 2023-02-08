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
set listchars=tab:→\ |

set number
set norelativenumber

set ruler
set laststatus=2
set signcolumn=yes

set textwidth=80
set colorcolumn=+1

set cursorline
set cursorlineopt=number

set wildmenu
set wildmode=longest,list
set completeopt=menu,menuone

" Other
set mouse=a
set showmatch
set autoindent
set backspace=0
set matchtime=1
set nofoldenable
set diffopt=vertical
set scrolloff=0

" Netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Disable
let html_no_rendering = 1
inoremap <tab> <nop>

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab | retab

" Set keymap
let mapleader = ' '

" Customizer mapping
xnoremap p pgvy
nnoremap gp `[v`]
nnoremap <leader>y :%y<cr>
nnoremap <leader>x :bd!<cr>
nnoremap <leader>n :set relativenumber!<cr>
nnoremap <leader>N :call ToggleScrollOff()<cr>
nnoremap <silent><C-l> :noh<cr>:redraw!<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'

" Buffer only
command! BufOnly exe '%bdelete|edit#|bdelete#'

" Navigate wrap
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Mapping copy clipboard and past
nnoremap <leader>y "+yy
vnoremap <leader>y "+y
nnoremap <leader>_y vg_"+y
nnoremap <leader>Y :%y+<cr>
nnoremap <leader>p o<esc>"+p
nnoremap <leader>P O<esc>"+p
vnoremap <leader>p "+p

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

" Open in tab terminal
nnoremap <leader>" :silent
      \ exe(':!tmux split-window -v -p 40 -c '.expand('%:p:h'))<cr>
nnoremap <leader>% :silent
      \ exe(':!tmux split-window -h -p 50 -c '.expand('%:p:h'))<cr>
nnoremap <leader>c :silent
      \ exe(':!tmux new-window -c '. expand('%:p:h').' -a')<cr>

" Fix conflict git
if &diff
  nnoremap <leader>1 :diffget LOCAL<cr>:diffupdate<cr>
  nnoremap <leader>2 :diffget BASE<cr>:diffupdate<cr>
  nnoremap <leader>3 :diffget REMOTE<cr>:diffupdate<cr>
  nnoremap <leader><cr> :diffupdate<cr>
  vnoremap <leader>= :GremoveMarkers<cr><gv>
endif

call plug#begin()

"--- Core plugins ---

" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

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

let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

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

let $FZF_DEFAULT_COMMAND = 'fdfind --type f -H '.fdIgnoreDirectories

function! SinkSwitchProjects(line)
  %bd | cd `=a:line`
endfunction

function! SinkSwitchDirectories(line)
  e `=a:line`
endfunction

command! Projects call fzf#run(fzf#wrap({
      \   'source': 'fdfind --type d -H '.fdIgnoreDirectories,
      \   'dir': expand('$HOME'),
      \   'sink': function('SinkSwitchProjects')
      \ }))

command! Directories call fzf#run(fzf#wrap({
      \   'source': 'fdfind --type d -H '.fdIgnoreDirectories,
      \   'sink': function('SinkSwitchDirectories')
      \ }))

command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \   'rg --hidden --column --line-number --no-heading --color=always
      \   --smart-case '.rgIgnoreDirectories.' '.shellescape(<q-args>),
      \   1, fzf#vim#with_preview(), <bang>0
      \ )

nnoremap <leader>i :Files<cr>
nnoremap <leader>d :Directories<cr>
nnoremap <leader>D :Projects<cr>
nnoremap <leader>o :Buffers<cr>
nnoremap <leader>s :Rg<cr>
nnoremap <leader>S :Rg <c-r><c-w><cr>
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Test
Plug 'vim-test/vim-test'
let test#strategy = 'basic'
nmap <leader>tf :TestFile<cr>
nmap <leader>tn :TestNearest<cr>
nmap <leader>tl :TestLast<cr>
nmap <leader>ts :TestSuite<cr>

" Extends feature vim
Plug 'mattn/emmet-vim'
Plug 'wellle/targets.vim'
Plug 'kylechui/nvim-surround'

"--- Other plugins ---
Plug 'j-hui/fidget.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'preservim/vimux'
let g:VimuxHeight = '50'
let g:VimuxOrientation = 'h'
nnoremap <leader>vo :VimuxOpenRunner<cr>
nnoremap <leader>vp :VimuxPromptCommand<cr>
nnoremap <leader>vx :VimuxCloseRunner<cr>
nnoremap <leader>vl :VimuxRunLastCommand<cr>
nnoremap <leader>vc :VimuxInterruptRunner<cr>
nnoremap <leader>vC :VimuxClearTerminalScreen<cr>
nnoremap <leader>vv :call VimuxRunCommand(getline('.') . "\n", 1)<cr>
vnoremap <leader>vv "vy :call VimuxRunCommand(@v, 1)<cr>gv

Plug 'AndrewRadev/tagalong.vim'
Plug 'rlue/vim-barbaric'

Plug 'ferrine/md-img-paste.vim'
let g:mdip_imgdir = 'images'

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
let g:mkdp_theme = 'light'
nnoremap <leader>m :MarkdownPreviewToggle<cr>

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
call plug#end()

"--- Config Provider ---
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
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

hi LineNr                    ctermfg=238      ctermbg=none     cterm=none
hi LineNrAbove               ctermfg=238      ctermbg=none     cterm=none
hi LineNrBelow               ctermfg=238      ctermbg=none     cterm=none
hi CursorLine                ctermfg=238      ctermbg=none     cterm=none
hi CursorLineNr              ctermfg=none     ctermbg=none     cterm=none

hi StatusLine                ctermfg=none     ctermbg=233      cterm=bold
hi StatusLineNC              ctermfg=none     ctermbg=233      cterm=none

hi ColorColumn               ctermfg=none     ctermbg=233      cterm=none
hi SpecialKey                ctermfg=236      ctermbg=none     cterm=none
hi Whitespace                ctermfg=236      ctermbg=none     cterm=none

hi DiagnosticError           ctermfg=196      ctermbg=none     cterm=none
hi DiagnosticWarn            ctermfg=226      ctermbg=none     cterm=none
hi DiagnosticInfo            ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticHint            ctermfg=34       ctermbg=none     cterm=none

hi DiagnosticSignError       ctermfg=196      ctermbg=none     cterm=none
hi DiagnosticSignWarn        ctermfg=226      ctermbg=none     cterm=none
hi DiagnosticSignInfo        ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticSignHint        ctermfg=34       ctermbg=none     cterm=none

hi DiagnosticFloatingError   ctermfg=196      ctermbg=none     cterm=none
hi DiagnosticFloatingWarn    ctermfg=226      ctermbg=none     cterm=none
hi DiagnosticFloatingInfo    ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticFloatingHint    ctermfg=34       ctermbg=none     cterm=none

hi DiagnosticUnderlineError  ctermfg=none     ctermbg=none     cterm=underline
hi DiagnosticUnderlineWarn   ctermfg=none     ctermbg=none     cterm=underline
hi DiagnosticUnderlineInfo   ctermfg=none     ctermbg=none     cterm=underline
hi DiagnosticUnderlineHint   ctermfg=none     ctermbg=none     cterm=underline
hi ExtraWhitespace           ctermbg=196

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

function! ToggleScrollOff()
  if &scrolloff == 0
    set scrolloff=999
  else
    set scrolloff=0
  endif
endfunction

function! IsInCurrentProject()
  let pwd = getcwd()
  let file = expand('%:p:h')

  return stridx(file, pwd) >= 0
endfunction

function! Trim()
  silent! %s#\($\n\s*\)\+\%$## " trim end newlines
  silent! %s/\s\+$//e " trim whitespace
  silent! g/^\_$\n\_^$/d " single blank line
endfunction

nnoremap <expr><leader>= IsInCurrentProject() ?
      \ ":call Trim()<cr>
      \ :lua vim.lsp.buf.format({async = false})<cr>
      \ :echo 'Format done!'<cr>"
      \ :'<esc>'

augroup ConfigStyleTabOrSpace
  autocmd!
  autocmd BufNewFile,BufRead,BufWrite *.go
        \ setlocal tabstop=2 shiftwidth=2 noexpandtab | retab
  autocmd BufNewFile,BufRead,Bufwrite *.md
        \ setlocal tabstop=2 shiftwidth=2 expandtab | retab
augroup end

augroup RunFile
  autocmd!
  autocmd FileType javascript vnoremap <leader>vf :w !node<cr>
  autocmd FileType python vnoremap <leader>vf :w !python<cr>
  autocmd FileType sql nnoremap <silent><leader>vf :call
        \ VimuxRunCommand('\i '.expand('%'))<cr>
augroup end

augroup ShowExtraWhitespace
  autocmd!
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
augroup end

augroup RunFile
  autocmd!
  autocmd FileType javascript vnoremap <leader>vf :w !node<cr>
  autocmd FileType python vnoremap <leader>vf :w !python<cr>
augroup end

augroup ChangeWorkingDirectory
  autocmd!
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup LoadFile
  autocmd!
  autocmd VimResized * wincmd =
  autocmd BufWritePre * call Mkdir()
  autocmd BufReadPost *.* if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif

  autocmd FileType markdown let g:PasteImageFunction = 'g:MarkdownPasteImage'
  autocmd FileType markdown,tex nmap <buffer><silent> <leader>I :call mdip#MarkdownClipboardImage()<cr>

  autocmd CursorMoved,CursorMovedI * setlocal norelativenumber
  autocmd BufWritePre *.* lua vim.diagnostic.enable()
  autocmd InsertEnter *.* lua vim.diagnostic.disable()
augroup end

"--- Load lua---
lua << EOF
  require 'module_lspconfig'
  require 'module_mason'
  require 'module_cmp'
  require 'module_null_ls'
  require 'module_oil'

  -- Without config
  require 'fidget'.setup()
  require 'nvim-surround'.setup()
EOF
