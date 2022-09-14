"--- General setting ---
set nocompatible
set nobackup
set noswapfile
set encoding=utf-8

set autoread
set autowrite

set hlsearch
set incsearch
set ignorecase
set smartcase

set list
set listchars=tab:>\ ,trail:-

set number
set norelativenumber

set laststatus=2
set signcolumn=yes

set wildmenu
set wildmode=longest,list

set textwidth=80
set colorcolumn=+1

set cursorline
set cursorlineopt=number

set backspace=indent,eol,start
set completeopt=menu,menuone,noselect

set nofoldenable
set foldlevelstart=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

" Other
set mouse=a
set showmatch
set autoindent
set matchtime=0
set diffopt=vertical

" Netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Disable
nnoremap S <nop>
let html_no_rendering = 1

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab | retab

" Set keymap
let mapleader = ' '

" Customizer mapping
nnoremap Y y$
nnoremap gp `[v`]
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

nnoremap <silent><C-l> :noh<cr>:redraw!<cr>
nnoremap <silent><leader>n :set number!<cr>
nnoremap <silent><leader>m m`:set relativenumber!<cr>

cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
inoremap <C-d> <esc>:call setline('.',substitute(getline(line('.')),'^\s*',
      \ matchstr(getline(line('.')-1),'^\s*'),''))<cr>I

" File manager netrw
nnoremap <leader>ff :JumpFile<cr>
nnoremap <leader>fv :vsp+JumpFile<cr>
nnoremap <leader>fs :sp+JumpFile<cr>
nnoremap <leader>fr :e .<cr>
command! BufCurOnly execute '%bdelete|edit#|bdelete#'

" Mapping copy clipboard and past
nnoremap <leader>y "+yy
vnoremap <leader>y "+y
nnoremap <leader>Y vg_"+y
nnoremap <leader>gy :%y+<cr>
nnoremap <leader>p o<esc>"+p
nnoremap <leader>P O<esc>"+p
vnoremap <leader>p "+p

" Better indent
xnoremap < <gv
xnoremap > >gv

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

" Fix conflict git
if &diff
  nnoremap <leader>1 :diffget LOCAL<cr>:diffupdate<cr>
  nnoremap <leader>2 :diffget BASE<cr>:diffupdate<cr>
  nnoremap <leader>3 :diffget REMOTE<cr>:diffupdate<cr>
  nnoremap <leader><cr> :diffupdate<cr>:diffupdate<cr>

  function! GRemoveMarkers() range
    execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
  endfunction
  command! -range=% GremoveMarkers <line1>,<line2>call GRemoveMarkers()
endif

" Open in tab terminal
nnoremap <leader>" :silent
      \ exe(':!tmux split-window -v -p 40 -c '.expand('%:p:h'))<cr>
nnoremap <leader>% :silent
      \ exe(':!tmux split-window -h -p 50 -c '.expand('%:p:h'))<cr>
nnoremap <leader>c :silent
      \ exe(':!tmux new-window -c '. expand('%:p:h').' -a')<cr>

call plug#begin()

"--- Core plugins ---

" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'andersevenrud/cmp-tmux'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" Linter and format:
Plug 'dense-analysis/ale'
let g:ale_fix_on_save = 1
let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1

let g:ale_set_signs = 1
let g:ale_set_highlights = 0

let g:ale_open_list = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0

let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linters = {
    \ 'cpp': ['cppcheck'],
    \ 'go': ['staticcheck'],
    \ }

let g:ale_fixers = {
    \ 'javascript': ['prettier'],
    \ 'javascriptreact': ['prettier'],
    \ 'html': ['prettier'],
    \ 'json': ['prettier'],
    \ 'css': ['prettier'],
    \ 'scss': ['prettier'],
    \ 'yaml': ['prettier'],
    \ 'markdown': ['prettier'],
    \ 'go': ['gofmt'],
    \ 'rust': ['rustfmt'],
    \ 'cpp': ['clang-format'],
    \ }

nmap <silent>gK <Plug>(ale_previous_wrap)
nmap <silent>gJ <Plug>(ale_next_wrap)

" File manager
Plug 'tamago324/lir.nvim'
Plug 'nvim-lua/plenary.nvim'

" Fuzzy search
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'
Plug 'gfanto/fzf-lsp.nvim'
Plug 'nvim-lua/plenary.nvim'

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
let g:fzf_layout = { 'down': '50%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']

let rgIgnoreDirectories = "
      \ -g '!{*/.git/*,*/.idea/*, */.vscode/*}'
      \ -g '!{*/node_modules/*,*/vendor/*, */composer/*,*/gems/*}'"

let fdIgnoreDirectories = '
      \ --exclude .git
      \ --exclude .idea
      \ --exclude .vscode
      \ --exclude node_modules
      \ --exclude vendor
      \ --exclude composer
      \ --exclude gems '

let $FZF_DEFAULT_COMMAND = 'fdfind --type f -H '.fdIgnoreDirectories

function! SwitchProject(line)
  %bd | cd `=a:line`
endfunction

command! Projects call fzf#run(fzf#wrap({
      \   'source': 'fdfind --type d -H '.fdIgnoreDirectories,
      \   'dir': expand('$HOME'),
      \   'sink': function('SwitchProject')
      \ }))

command! Directories call fzf#run(fzf#wrap({
      \   'source': 'fdfind --type d -H '.fdIgnoreDirectories
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
nnoremap <leader>l :DocumentSymbols<cr>
nnoremap <leader>L :WorkspaceSymbols<cr>
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

" Test
Plug 'vim-test/vim-test'
let test#strategy = 'basic'
nmap <leader>tf :TestFile<cr>
nmap <leader>tn :TestNearest<cr>
nmap <leader>tl :TestLast<cr>
nmap <leader>ts :TestSuite<cr>

"--- Other plugins ---
Plug 'j-hui/fidget.nvim'
Plug 'AndrewRadev/tagalong.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'mattn/emmet-vim'
Plug 'simeji/winresizer'
let g:winresizer_start_key='<leader>w'

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'
let g:plantuml_previewer#debug_mode = 1
let g:plantuml_previewer#plantuml_jar_path =
      \ expand('$HOME/.config/plantuml/plantuml.jar')

Plug 'preservim/vimux'
let g:VimuxHeight = '50'
let g:VimuxOrientation = 'h'
nnoremap <leader>vo :VimuxOpenRunner<cr>
nnoremap <leader>vp :VimuxPromptCommand<cr>
nnoremap <leader>vx :VimuxCloseRunner<cr>
nnoremap <leader>vl :VimuxRunLastCommand<cr>
nnoremap <leader>vc :VimuxInterruptRunner<cr>
nnoremap <leader>vC :VimuxClearTerminalScreen<cr>
nnoremap <leader>vD :call VimuxRunCommand('exit')<cr>
nnoremap <leader>vr :call VimuxRunCommand(getline('.') . "\n", 1)<cr>
vnoremap <leader>vr "vy :call VimuxRunCommand(@v, 1)<cr>gv

"--- Config Provider ---
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
call plug#end()

"--- Customize theme ---
syntax off
set background=dark
filetype plugin indent on

hi clear Error
hi clear SignColumn
hi clear VertSplit

hi NonText                   ctermfg=none     ctermbg=none     cterm=none
hi Normal                    ctermfg=none     ctermbg=none     cterm=none
hi NormalFloat               ctermfg=none     ctermbg=234      cterm=none
hi Pmenu                     ctermfg=15       ctermbg=236      cterm=none
hi PmenuSel                  ctermfg=0        ctermbg=39       cterm=none

hi LineNr                    ctermfg=240      ctermbg=none     cterm=none
hi LineNrAbove               ctermfg=240      ctermbg=none     cterm=none
hi LineNrBelow               ctermfg=240      ctermbg=none     cterm=none
hi CursorLineNr              ctermfg=none     ctermbg=none     cterm=none

hi StatusLine                ctermfg=15       ctermbg=233      cterm=bold
hi StatusLineNC              ctermfg=15       ctermbg=233      cterm=none

hi ColorColumn               ctermfg=none     ctermbg=233
hi SpecialKey                ctermfg=234      ctermbg=none     cterm=none
hi Whitespace                ctermfg=234      ctermbg=none     cterm=none

hi DiagnosticError           ctermfg=196      ctermbg=none     cterm=none
hi DiagnosticWarn            ctermfg=226      ctermbg=none     cterm=none
hi DiagnosticInfo            ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticHint            ctermfg=34       ctermbg=none     cterm=none

hi DiagnosticSignError       ctermfg=196      ctermbg=none     cterm=none
hi DiagnosticSignWarn        ctermfg=226      ctermbg=none     cterm=none
hi DiagnosticSignInfo        ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticSignHint        ctermfg=34       ctermbg=none     cterm=none

hi DiagnosticUnderlineError  ctermfg=none     ctermbg=none     cterm=underline
hi DiagnosticUnderlineWarn   ctermfg=none     ctermbg=none     cterm=underline
hi DiagnosticUnderlineInfo   ctermfg=none     ctermbg=none     cterm=underline
hi DiagnosticUnderlineHint   ctermfg=none     ctermbg=none     cterm=underline

hi DiagnosticFloatingError   ctermfg=196      ctermbg=none     cterm=none
hi DiagnosticFloatingWarn    ctermfg=226      ctermbg=none     cterm=none
hi DiagnosticFloatingInfo    ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticFloatingHint    ctermfg=34       ctermbg=none     cterm=none

hi ALEErrorSign              ctermfg=196      ctermbg=none     cterm=none
hi ALEWarningSign            ctermfg=226      ctermbg=none     cterm=none
hi ALEInforSign              ctermfg=39       ctermbg=none     cterm=none

"--- Etc ---
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

function! JumpFile()
  let file_name = expand('%:t')
  e %:p:h
  call search(file_name)
endfunction
command! JumpFile call JumpFile()

augroup ChangeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup RunFile
  autocmd!
  autocmd FileType javascript vnoremap <leader>vf :w !node<cr>
  autocmd FileType python vnoremap <leader>vf :w !python<cr>

  autocmd FileType javascript nnoremap <silent><leader>vf :call
        \ VimuxRunCommand('node '.expand('%'))<cr>
  autocmd FileType python nnoremap <silent><leader>vf :call
        \ VimuxRunCommand('python '.expand('%'))<cr>
  autocmd FileType go nnoremap <silent><leader>vf :call
        \ VimuxRunCommand('go run '.expand('%'))<cr>
  autocmd FileType go nnoremap <silent><leader>vd :set number<cr>:call
        \ VimuxRunCommand('dlv debug '.expand('%'))<cr>
  autocmd FileType go nnoremap <silent><leader>vb :set number<cr>:call
        \ VimuxRunCommand('break ' .expand('%').':'.line('.'))<cr>
  autocmd FileType sql nnoremap <silent><leader>vf :call
        \ VimuxRunCommand('\i '.expand('%'))<cr>
augroup end

augroup LoadFile
  autocmd!
  autocmd VimResized * wincmd =
  autocmd FocusGained * redraw!

  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save position cursor

  autocmd BufWritePre * silent! :%s#\($\n\s*\)\+\%$## " trim endlines
  autocmd BufWritePre * silent! :%s/\s\+$//e " trim whitespace
  autocmd BufWritePre * silent! :g/^\_$\n\_^$/d " single blank line

  autocmd BufWritePre * call Mkdir()
  autocmd BufNew,BufRead *.uml set ft=uml

  autocmd InsertEnter *.* lua vim.diagnostic.disable()
  autocmd BufWritePre *.* lua vim.diagnostic.enable()

  autocmd FileType lir setlocal nonumber
augroup end

"--- Load lua---
lua << EOF
  require 'module_lspconfig'
  require 'module_mason'
  require 'module_cmp'
  require 'module_lir'
  require 'module_treesitter'

  -- Without config
  require 'fidget'.setup()
EOF
