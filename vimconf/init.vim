"--- General setting ---
set nocompatible
set nobackup
set noswapfile
set encoding=utf-8

set hlsearch
set incsearch
set ignorecase
set smartcase

set showmatch
set autoindent

set nonumber
set norelativenumber

set laststatus=2
set signcolumn=yes
set textwidth=80
set colorcolumn=+1

set list
set wildmenu
set wildmode=longest,list
set completeopt=menu,preview

" Status line
set statusline=
set statusline+=%<%f\ %h%m%r
set statusline+=%{FugitiveStatusline()}
set statusline+=%=
set statusline+=%-14.(%l,%c%V%)\ %P

" Other
set mouse=a
set matchtime=0
set nofoldenable
set nocursorline
set nrformats+=alpha
set pumheight=25
set diffopt=vertical

" Netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Disable
let html_no_rendering = 1

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab | retab
augroup settingTabSpace
  autocmd!
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 expandtab | retab
  autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab | retab
  autocmd FileType snippets setlocal tabstop=2 shiftwidth=2 expandtab | retab
augroup end

" Set keymap
let mapleader = ' '

" Customizer mapping
nnoremap Y y$
nnoremap gp `[v`]
nnoremap <silent><C-l> :nohl<cr>:redraw!<cr>
nnoremap <silent><leader>L :set number!<cr>
nnoremap <silent><leader>vi
      \ :source $MYVIMRC<cr>
      \ :echo 'Reload vim config done!'<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
inoremap <C-d> <esc>:call setline(".",substitute(getline(line(".")),'^\s*',
      \ matchstr(getline(line(".")-1),'^\s*'),''))<cr>I

" Mapping copy clipboard and past
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" Navigate window
nnoremap <tab>j <C-w>j
nnoremap <tab>k <C-w>k
nnoremap <tab>h <C-w>h
nnoremap <tab>l <C-w>l

" Better indent, move
xnoremap < <gv
xnoremap > >gv

" Navigate quickfix, buffers
nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>
nnoremap [b :bprevious<cr>
nnoremap ]b :bnext<cr>
nnoremap [B :bfirst<cr>
nnoremap ]B :blast<cr>

" Open in tab terminal(tmux/gnome terminal)
function! OpenNew(mode)
  let l:dir = expand('%:p:h')
  let l:command = a:mode? ':!tmux split-window -h -c '.l:dir
        \ : ':!tmux new-window -c '.l:dir.' -a'

  if isdirectory(l:dir)
    silent execute(l:command)
  endif
endfunction
nnoremap <silent><leader>% :call OpenNew(1)<cr>
nnoremap <silent><leader>c :call OpenNew(0)<cr>

call plug#begin()

"--- Core plugins ---

" Lsp
Plug 'neovim/nvim-lspconfig'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'andersevenrud/cmp-tmux'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'
inoremap <C-n> <Cmd>lua require('cmp').complete()<cr>
inoremap <C-x><C-o> <Cmd>lua require('cmp').complete()<cr>

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" Linter and format
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

let g:ale_cpp_cpplint_options = '--filter=-build/c++11,-whitespace/indent'
if filereadable('package.json')
  if match(readfile('package.json'), 'prettier') > 0
    let g:ale_javascript_prettier_executable = 'npx prettier'
    echo 'Prettier local active!'
  endif
endif

let g:ale_linters = {
    \ 'cpp': ['cpplint'],
    \ 'go': ['staticcheck'],
    \ }

let g:ale_fixers = {
    \ '*': ['remove_trailing_lines', 'trim_whitespace'],
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

nmap <silent><C-k> <Plug>(ale_previous_wrap)
nmap <silent><C-j> <Plug>(ale_next_wrap)

" Fuzzy search
Plug 'junegunn/fzf.vim'
set rtp+=~/.fzf

let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

let ignoreDirectories = '
      \ --exclude .git
      \ --exclude .idea
      \ --exclude .vscode
      \ --exclude node_modules
      \ --exclude vendor
      \ --exclude composer
      \ --exclude gems'

let $FZF_DEFAULT_COMMAND = 'fd --type f -H '.ignoreDirectories

function! HandleSink(line)
  execute('cd '.a:line)
endfunction

command! -bang -nargs=* Rg call fzf#vim#grep(
      \   'rg --column --line-number --no-heading --color=never
      \   --hidden --smart-case -- '.shellescape(<q-args>), 1,
      \   fzf#vim#with_preview(), <bang>0)

command! Directories call fzf#run(fzf#wrap({
      \ 'source': 'fd --type d -H '.ignoreDirectories
      \ }))
command! Projects call fzf#run(fzf#wrap({
      \ 'source': 'fd --type d -H '.ignoreDirectories,
      \ 'dir': expand('$HOME/'),
      \ 'sink': function('HandleSink')
      \ }))

let g:fzf_layout = { 'down': '40%' }
let g:fzf_preview_window = ['right:50%', 'ctrl-/']
nnoremap <leader>i :Files<cr>
nnoremap <leader>I :Directories<cr>
nnoremap <leader>P :Projects<cr>
nnoremap <leader>s :Snippets<cr>
nnoremap <leader>n :Rg<cr>
nnoremap <leader>N :Rg <c-r><c-w><cr>

" Itegrated git
Plug 'tpope/vim-fugitive'
nnoremap <leader>h :diffget //2<cr>:diffupdate<cr>
nnoremap <leader>l :diffget //3<cr>:diffupdate<cr>

" Test
Plug 'vim-test/vim-test'
let test#strategy = 'basic'
nmap <leader>tf :TestFile<cr>
nmap <leader>tn :TestNearest<cr>
nmap <leader>tl :TestLast<cr>
nmap <leader>ts :TestSuite<cr>

" Generate document comment
Plug 'kkoomen/vim-doge'
let g:doge_enable_mappings= 1
let g:doge_mapping = '<leader>D'

" Debugger
Plug 'rcarriga/nvim-dap-ui'
Plug 'mfussenegger/nvim-dap'
nnoremap <leader>dc <cmd>lua require'dap'.continue()<cr>
nnoremap <leader>di <cmd>lua require'dap'.step_into()<cr>
nnoremap <leader>do <cmd>lua require'dap'.step_over()<cr>
nnoremap <leader>dO <cmd>lua require'dap'.step_out()<cr>
nnoremap <leader>db <cmd>lua require'dap'.toggle_breakpoint()<cr>
nnoremap <leader>dC
      \ <cmd>lua require'dap'.set_breakpoint(
      \   vim.fn.input('Breakpoint condition: ')
      \ )<cr>
nnoremap <leader>dl
      \ <cmd>lua require'dap'.set_breakpoint(
      \   nil, nil, vim.fn.input('Log point message: ')
      \ )<cr>
nnoremap <leader>dB <cmd>lua require'dap'.clear_breakpoints()<cr>
nnoremap <leader>dr <cmd>lua require'dap'.repl.toggle()<cr>
nnoremap <leader>dL <cmd>lua require'dap'.run_last()<cr>
nnoremap <leader>dq <cmd>lua require'dap'.close()<cr>
      \ :echo 'Close debugger'<cr>
      \ <cmd>lua require'dapui'.close()<cr>
nnoremap <leader>dt <cmd>lua require'dapui'.toggle()<cr>

" File manager
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
augroup defxConfig
  autocmd FileType defx setlocal nonumber norelativenumber
  autocmd FileType defx call s:defx_my_settings()
  autocmd FileChangedShellPost,BufWritePost * call defx#redraw()
augroup end
nnoremap <silent><leader>f :Defx
      \ -new
      \ -sort=filename:extension
      \ -columns=indent:mark:filename
      \ -show-ignored-files<cr>
nnoremap <silent><leader>F :Defx `expand('%:p:h')` -search=`expand('%:p')`
      \ -sort=filename:extension
      \ -columns=indent:mark:filename
      \ -show-ignored-files<cr>

command! -nargs=? -complete=dir Explore silent execute 'Defx '.
      \ expand('%:p:h').
      \ ' -search='.expand('%:p').
      \ ' -new -sort=filename:extension -columns=indent:mark:filename'.
      \ ' -show-ignored-files'
command! -nargs=? -complete=dir Vexplore vsplit | silent execute 'Defx '.
      \ expand('%:p:h').
      \ ' -search='.expand('%:p').
      \ ' -new -sort=filename:extension -columns=indent:mark:filename'.
      \ ' -show-ignored-files'
command! -nargs=? -complete=dir Sexplore split | silent execute 'Defx '.
      \ expand('%:p:h').
      \ ' -search='.expand('%:p').
      \ ' -new -sort=filename:extension -columns=indent:mark:filename'.
      \ ' -show-ignored-files'

function! s:defx_my_settings() abort
  call defx#custom#column('filename', {
        \ 'min_width': 50,
        \ 'max_width': 100,
        \ })
  call defx#custom#column('icon', {
        \ 'directory_icon': '',
        \ 'opened_icon': '',
        \ 'file_icon': '',
        \ 'root_icon': '',
        \ })
  nnoremap <silent><buffer><expr> <cr>
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> v
        \ defx#do_action('open', 'vsplit')
  nnoremap <silent><buffer><expr> s
        \ defx#do_action('open', 'split')
  nnoremap <silent><buffer><expr> -
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> D
        \ defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> mc
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> mm
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> mt
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> R
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> %
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> T
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> mf
        \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> mF
        \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> y
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> gh
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <C-l>
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
endfunction

"--- Other plugins ---
Plug 'mattn/emmet-vim'
Plug 'jbyuki/venn.nvim'
Plug 'j-hui/fidget.nvim'
Plug 'kylechui/nvim-surround'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'

Plug 'vimwiki/vimwiki'
let g:vimwiki_auto_header = 1
let g:vimwiki_list = [{'path': '~/Workspace/Personal/notes/'}]

Plug 'christoomey/vim-tmux-runner'
let g:VtrPercentage = 50
let g:VtrOrientation = 'h'
nnoremap <leader>rr :VtrSendLinesToRunner<cr>
xnoremap <leader>rr :VtrSendLinesToRunner<cr>gv
nnoremap <leader>rs :VtrSendCommandToRunner<cr>
nnoremap <leader>ra :VtrAttachToPane<cr>
nnoremap <leader>rd :VtrDetachRunner<cr>
nnoremap <leader>rx :VtrKillRunner<cr>
nnoremap <leader>ro :VtrOpenRunner<cr>
nnoremap <leader>rc :VtrClearRunner<cr>

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

hi clear SignColumn
hi clear VertSplit
hi clear Error

hi NonText                        ctermfg=none     ctermbg=none     cterm=none
hi Normal                         ctermfg=none     ctermbg=none     cterm=none
hi NormalFloat                    ctermfg=none     ctermbg=none     cterm=none
hi FloatBorder                    ctermfg=none     ctermbg=none     cterm=none
hi Pmenu                          ctermfg=white    ctermbg=black    cterm=none
hi PmenuSel                       ctermfg=black    ctermbg=blue     cterm=none

hi ColorColumn                    ctermfg=none     ctermbg=black
hi SpecialKey                     ctermfg=darkgray ctermbg=none     cterm=none
hi Whitespace                     ctermfg=darkgray ctermbg=none     cterm=none

hi LineNr                         ctermfg=darkgray ctermbg=none     cterm=none
hi LineNrAbove                    ctermfg=darkgray ctermbg=none     cterm=none
hi LineNrBelow                    ctermfg=darkgray ctermbg=none     cterm=none
hi CursorLineNr                   ctermfg=none     ctermbg=none     cterm=none

hi StatusLine                     ctermfg=white    ctermbg=black    cterm=bold
hi StatusLineNC                   ctermfg=white    ctermbg=black    cterm=none

hi DiagnosticError                ctermfg=red      ctermbg=none     cterm=none
hi DiagnosticWarn                 ctermfg=yellow   ctermbg=none     cterm=none
hi DiagnosticInfo                 ctermfg=blue     ctermbg=none     cterm=none
hi DiagnosticHint                 ctermfg=green    ctermbg=none     cterm=none

hi DiagnosticSignError            ctermfg=red      ctermbg=none     cterm=none
hi DiagnosticSignWarn             ctermfg=yellow   ctermbg=none     cterm=none
hi DiagnosticSignInfo             ctermfg=blue     ctermbg=none     cterm=none
hi DiagnosticSignHint             ctermfg=green    ctermbg=none     cterm=none

hi DiagnosticFloatingError        ctermfg=none     ctermbg=none     cterm=none
hi DiagnosticFloatingWarning      ctermfg=none     ctermbg=none     cterm=none
hi DiagnosticFloatingInformation  ctermfg=none     ctermbg=none     cterm=none
hi DiagnosticFloatingHint         ctermfg=none     ctermbg=none     cterm=none

hi ALEErrorSign                   ctermbg=none     ctermfg=red      cterm=none
hi ALEInforSign                   ctermbg=none     ctermfg=blue     cterm=none
hi ALEWarningSign                 ctermbg=none     ctermfg=yellow   cterm=none

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

function! s:browse_check(path) abort
  if bufnr('%') != expand('<abuf>')
    return
  endif

  execute 'Defx
        \ -new
        \ -sort=filename:extension
        \ -columns=indent:mark:filename
        \ -show-ignored-files
        \ ' a:path
endfunction

augroup changeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup LoadFile
  autocmd!
  autocmd FocusGained * redraw
  autocmd VimResized * wincmd = " auto resize window

  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save position cursor
  autocmd BufWritePre * call Mkdir()
  autocmd BufNew,BufRead,BufWritePost .editorconfig :EditorConfigReload
  autocmd BufNew,BufRead,BufWritePost diary.wiki :VimwikiDiaryGenerateLinks

  " Defx replace netrw
  autocmd BufEnter,VimEnter,BufNew,BufWinEnter,BufRead,BufCreate
        \ * if isdirectory(expand('<amatch>'))
        \   | call s:browse_check(expand('<amatch>')) | endif

  autocmd FileType vim-plug setlocal nocursorline
  autocmd FileType fzf set laststatus=0 noshowmode noruler
    \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
augroup end

"--- Load lua---
lua << EOF
  require 'module_treesitter'
  require 'module_lspconfig'
  require 'module_cmp'
  require 'module_venn'
  require 'module_dap'
  require 'module_dapui'

  -- Without config
  require 'fidget'.setup()
  require 'nvim-surround'.setup()
EOF
