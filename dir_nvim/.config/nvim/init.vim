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
set fillchars=vert:\|

set nonumber
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

" Status line
set statusline=
set statusline+=%<%f\ %h%m%r
set statusline+=%{FugitiveStatusline()}
set statusline+=%=
set statusline+=%-14.(%l,%c%V%)\ %P

" Other
set mouse=a
set showmatch
set autoindent
set matchtime=0
set nofoldenable
set diffopt=vertical

" Netrw
let g:netrw_banner = 0
let g:netrw_cursor = 0
let g:netrw_keepdir= 0
let g:netrw_localcopydircmd = 'cp -r'

" Disable
nnoremap S <nop>
let html_no_rendering = 1

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab | retab

" Set keymap
let mapleader = ' '
let g:root_cwd = getcwd()

" Customizer mapping
nnoremap Y y$
nnoremap gp `[v`]
tnoremap <esc> <C-\><C-n>
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
nnoremap <leader>fr :e `=g:root_cwd`<cr>
command! Root execute 'cd ' fnameescape(g:root_cwd)
command! BufCurOnly execute '%bdelete|edit#|bdelete#'

" Mapping copy clipboard and past
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>
nnoremap <leader>p o<esc>"+p
nnoremap <leader>P O<esc>"+p
vnoremap <leader>p "+p

" Better indent
xnoremap < <gv
xnoremap > >gv

" Navigate quickfix, buffers
nnoremap go :copen<cr>
nnoremap gx :cclose<cr>
nnoremap gh :cprev<cr>
nnoremap gl :cnext<cr>
nnoremap g< :cfirst<cr>
nnoremap g> :clast<cr>

" Open in tab terminal
nnoremap <leader>"
      \ :silent exe(':!tmux split-window -v -p 40 -c '.expand('%:p:h'))<cr>
nnoremap <leader>%
      \ :silent exe(':!tmux split-window -h -p 50 -c '.expand('%:p:h'))<cr>
nnoremap <leader>c
      \ :silent exe(':!tmux new-window -c '. expand('%:p:h').' -a')<cr>

call plug#begin()

"--- Core plugins ---

" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'andersevenrud/cmp-tmux'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
inoremap <C-n> <cmd>lua require('cmp').complete()<cr>

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" Linter and format:
Plug 'dense-analysis/ale'
let g:ale_fix_on_save = 0
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
    \ 'javascript': ['standard'],
    \ 'javascriptreact': ['standard'],
    \ 'cpp': ['cppcheck'],
    \ 'go': ['staticcheck'],
    \ }

let g:ale_fixers = {
    \ 'javascript': ['standard'],
    \ 'javascriptreact': ['standard'],
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

nmap <silent><C-k> <Plug>(ale_previous_wrap)
nmap <silent><C-j> <Plug>(ale_next_wrap)
nnoremap <silent><leader>fm :ALEFix<cr>

" Fuzzy search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
nnoremap <leader>i :Root<cr><cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>s :Root<cr><cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>S :Root<cr><cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>I :Root<cr><cmd>lua require('telescope.builtin').find_files({
      \ prompt_title = 'Find directory',
      \ find_command = { 'fdfind', '--type', 'd' },
      \ cwd = vim.fn.getcwd(),
      \ })<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>l
      \ :Root<cr><cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>L
      \ :Root<cr><cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>

" Itegrated git
Plug 'tpope/vim-fugitive'
nnoremap <leader>< :diffget //2<cr>:diffupdate<cr>
nnoremap <leader>> :diffget //3<cr>:diffupdate<cr>
nnoremap <leader>gs :Git<cr>
nnoremap <leader>gb :Git blame<cr>
nnoremap <leader>gd :Gdiffsplit<cr>
nnoremap <leader>gg :Git pull<cr>
nnoremap <leader>gp :Git push<cr>
nnoremap <leader>gP :Git push -f<cr>
nnoremap <leader>gl :Git log --all --graph --decorate --oneline<cr>

" Test
Plug 'vim-test/vim-test'
let test#strategy = 'basic'
nmap <leader>tf :TestFile<cr>
nmap <leader>tn :TestNearest<cr>
nmap <leader>tl :TestLast<cr>
nmap <leader>ts :TestSuite<cr>

" Generate document comment
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
let g:doge_enable_mappings= 1
let g:doge_mapping = '<leader>d'

"--- Other plugins ---
Plug 'mattn/emmet-vim'
Plug 'j-hui/fidget.nvim'
Plug 'jbyuki/venn.nvim'

Plug 'AndrewRadev/tagalong.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'
let g:plantuml_previewer#debug_mode = 1
let g:plantuml_previewer#plantuml_jar_path =
      \ expand('$HOME/.config/plantuml/plantuml.jar')

Plug 'preservim/vimux'
let g:VimuxHeight = '50'
let g:VimuxOrientation = 'v'
nnoremap <silent><leader>vo :VimuxOpenRunner<cr>
nnoremap <silent><leader>vc :VimuxPromptCommand<cr>
nnoremap <silent><leader>vx :VimuxCloseRunner<cr>
nnoremap <silent><leader>vl :VimuxRunLastCommand<cr>
nnoremap <silent><leader>vL :VimuxClearTerminalScreen<cr>
vnoremap <silent><leader>vr "vy :call VimuxRunCommand(@v, 1)<cr>gv
nnoremap <silent><leader>vr :call VimuxRunCommand(getline('.') . "\n", 1)<cr>
autocmd FileType sql nnoremap <silent><leader>vi
      \ :call VimuxRunCommand('\i '.expand('%'))<cr>

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

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

hi NonText                        ctermfg=none     ctermbg=none     cterm=none
hi Normal                         ctermfg=none     ctermbg=none     cterm=none
hi NormalFloat                    ctermfg=none     ctermbg=234      cterm=none
hi Pmenu                          ctermfg=15       ctermbg=236      cterm=none
hi PmenuSel                       ctermfg=0        ctermbg=39       cterm=none

hi LineNr                         ctermfg=240      ctermbg=none     cterm=none
hi LineNrAbove                    ctermfg=240      ctermbg=none     cterm=none
hi LineNrBelow                    ctermfg=240      ctermbg=none     cterm=none
hi CursorLineNr                   ctermfg=none     ctermbg=none     cterm=none

hi ColorColumn                    ctermfg=none     ctermbg=233
hi SpecialKey                     ctermfg=240      ctermbg=none     cterm=none
hi Whitespace                     ctermfg=240      ctermbg=none     cterm=none

hi StatusLine                     ctermfg=15       ctermbg=233      cterm=bold
hi StatusLineNC                   ctermfg=15       ctermbg=233      cterm=none

hi DiagnosticError                ctermfg=160      ctermbg=none     cterm=none
hi DiagnosticWarn                 ctermfg=190      ctermbg=none     cterm=none
hi DiagnosticInfo                 ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticHint                 ctermfg=34       ctermbg=none     cterm=none

hi DiagnosticSignError            ctermfg=160      ctermbg=none     cterm=none
hi DiagnosticSignWarn             ctermfg=190      ctermbg=none     cterm=none
hi DiagnosticSignInfo             ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticSignHint             ctermfg=34       ctermbg=none     cterm=none

hi DiagnosticFloatingError        ctermfg=160      ctermbg=none     cterm=none
hi DiagnosticFloatingWarning      ctermfg=190      ctermbg=none     cterm=none
hi DiagnosticFloatingInformation  ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticFloatingHint         ctermfg=34       ctermbg=none     cterm=none

hi ALEErrorSign                   ctermfg=160      ctermbg=none     cterm=none
hi ALEWarningSign                 ctermfg=190      ctermbg=none     cterm=none
hi ALEInforSign                   ctermfg=39       ctermbg=none     cterm=none

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

" CreateFile
function! CreateFile(path)
  let date = strftime('%Y-%m-%d')
  let path = a:path.date.'.txt'
  execute ':e '. fnameescape(path)
endfunction
command! Diary call CreateFile('~/Workspace/Personal/todo-diary/diary/')
command! Todo call CreateFile('~/Workspace/Personal/todo-diary/todo/')
command! Note call CreateFile('~/Workspace/Personal/notes/')

function! JumpFile()
  let file_name = expand('%:t')
  Explore
  call search(file_name)
endfunction
command! JumpFile call JumpFile()

command! JumpFile call JumpFile()
function! NetrwSetting()
  autocmd BufLeave <buffer> cd `=g:root_cwd`
  nnoremap <silent><buffer> u <nop>
  nnoremap <silent><buffer> U <nop>
  nnoremap <silent><buffer> s <nop>
  nnoremap <silent><buffer> <C-l> :nohl<cr>:e .<cr>
  nnoremap <silent><buffer> g? :h netrw-quickhelp<cr>
  nnoremap <silent><buffer> mL :echo join(
        \ netrw#Expose('netrwmarkfilelist'), "\n")<cr>
endfunction

augroup ChangeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup SettingTabSpace
  autocmd!
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 expandtab | retab
  autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab | retab
augroup end

augroup RunFile
  autocmd!
  autocmd FileType javascript vnoremap <leader>rf :w !node<cr>
  autocmd FileType javascript nnoremap <leader>rf :!node %<cr>
  autocmd FileType python vnoremap <leader>rf :w !python<cr>
  autocmd FileType python nnoremap <leader>rf :!python %<cr>
  autocmd FileType go nnoremap <leader>rf :!go run %<cr>
  autocmd FileType cpp nnoremap <leader>rf :!./%:r<cr>
  autocmd FileType cpp nnoremap <leader>rb :!g++ -std=c++17
        \ -O2 -Wall -Wshadow % -o %:r<cr>
augroup end

augroup LoadFile
  autocmd!
  autocmd FocusGained * redraw!
  autocmd VimResized * wincmd =

  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save position cursor

  autocmd BufWritePre * call Mkdir()
  autocmd BufWritePre * silent! :%s#\($\n\s*\)\+\%$## " trim endlines
  autocmd BufWritePre * silent! :%s/\s\+$//e " trim whitespace
  autocmd BufWritePre * silent! :g/^\_$\n\_^$/d " single blank line

  autocmd BufNew,BufRead *.uml set ft=uml
  autocmd BufNew,BufRead,BufWritePost .editorconfig :EditorConfigReload
  autocmd FileType netrw call NetrwSetting()
augroup end

"--- Load lua---
lua << EOF
  require 'module_treesitter'
  require 'module_lspconfig'
  require 'module_telescope'
  require 'module_mason'
  require 'module_venn'
  require 'module_cmp'

  -- Without config
  require 'fidget'.setup()
EOF
