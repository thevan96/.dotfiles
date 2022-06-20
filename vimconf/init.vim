"--- General setting ---
set nobackup
set noswapfile
set encoding=utf-8

set hlsearch
set incsearch
set ignorecase
set smartcase

set showmatch
set autoindent
set smartindent

set number
set relativenumber

set list
set laststatus=2
set signcolumn=yes
set textwidth=80
set colorcolumn=+1
set completeopt=menu,menuone

" Other
set mouse=a
set matchtime=0
set nofoldenable
set nocursorline
set nrformats+=alpha
set pumheight=15

" Disable
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let html_no_rendering = 1

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab | retab
augroup settingTabSpace
  autocmd!
  autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab | retab
augroup end

" Set keymap
let mapleader = ' '

" Customizer mapping
nnoremap Y y$
nnoremap gm `[v`]
nnoremap <silent><C-l> :nohl<cr>:redraw!<cr>
nnoremap <silent><leader>L :set relativenumber!<cr>
nnoremap <silent><leader>D :bd!<cr>
nnoremap <silent><leader>H :HardTimeToggle<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
inoremap <C-D> <Esc>:call setline(".",substitute(getline(line(".")),'^\s*',
      \ matchstr(getline(line(".")-1),'^\s*'),''))<cr>I

" Mapping copy clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>

" Better indent, move
xnoremap < <gv
xnoremap > >gv

" Navigate quickfix
nnoremap <silent><tab>p :cprev<cr>
nnoremap <silent><tab>n :cnext<cr>
nnoremap <silent><tab>N :cfirst<cr>
nnoremap <silent><tab>P :clast<cr>
nnoremap <silent><tab>o :copen<cr>
nnoremap <silent><tab>x :cclose<cr>

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
" Lsp + autocomplete
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

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

if filereadable('.prettierrc')
  if match(readfile('package.json'), 'prettier')
    let g:ale_javascript_prettier_executable = 'npx prettier'
    echo 'Prettier local active!'
  else
    echo 'Prettier local not found'
  end
endif

let g:ale_linters = {
      \ 'cpp': ['cpplint'],
      \ 'go': ['staticcheck'],
      \}

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
      \ }

nmap <silent><C-k> <Plug>(ale_previous_wrap)
nmap <silent><C-j> <Plug>(ale_next_wrap)
nnoremap <silent><leader>p :ALEFix<cr>

" Fuzzy search
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>C <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>gb <cmd>lua require('telescope.builtin').git_branches()<cr>
nnoremap <leader>gc <cmd>lua require('telescope.builtin').git_commits()<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>i <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>n <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>N <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>s
      \ <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>S
      \ <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>

" File manager
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
augroup defxConfig
  autocmd FileType defx setlocal nonumber norelativenumber
  autocmd FileType defx call s:defx_my_settings()
  autocmd BufWritePost * call defx#redraw()
augroup end
nnoremap <silent><leader>f :Defx
      \ -new
      \ -sort=filename:extension
      \ -columns=indent:mark:icon:filename
      \ -show-ignored-files<cr><C-w>=
nnoremap <silent><leader>F :Defx `escape(expand('%:p:h'), ' :')` -search=`expand('%:p')`
      \ -new
      \ -sort=filename:extension
      \ -columns=indent:mark:icon:filename
      \ -show-ignored-files<cr><C-w>=
function! s:defx_my_settings() abort
  call defx#custom#column('filename', {
        \ 'min_width': 50,
        \ 'max_width': 100,
        \ })
  call defx#custom#column('icon', {
        \ 'directory_icon': ' ',
        \ 'opened_icon': ' ',
        \ 'file_icon': ' ',
        \ 'root_icon': ' ',
        \ })
  nnoremap <silent><buffer><expr> <cr>
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> l
        \ defx#is_directory() ?
        \ defx#do_action('open_directory') :
        \ defx#do_action('print')
  nnoremap <silent><buffer><expr> h
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> j 'j'
  nnoremap <silent><buffer><expr> k 'k'
  nnoremap <silent><buffer><expr> d
        \ defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> c
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> m
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> r
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> n
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> t
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> a
        \ defx#do_action('toggle_select_visual')
  nnoremap <silent><buffer><expr> u
        \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> y
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> R
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
  nnoremap <silent><buffer><expr> C
        \ defx#do_action('change_vim_cwd')
endfunction

" Itegrated git
Plug 'tpope/vim-fugitive'

" Test
Plug 'vim-test/vim-test'
let test#strategy = 'basic'
nmap <silent><leader>tf :TestFile<cr>
nmap <silent><leader>tn :TestNearest<cr>
nmap <silent><leader>tl :TestLast<cr>
nmap <silent><leader>ts :TestSuite<cr>

" SQL Tool
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-dotenv'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'kristijanhusak/vim-dadbod-completion'
let g:db_ui_dotenv_variable_prefix = 'DBUI_'

" Debugger
Plug 'mfussenegger/nvim-dap'
Plug 'rcarriga/nvim-dap-ui'

"--- Other plugins ---
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'j-hui/fidget.nvim'
Plug 'mattn/emmet-vim'
Plug 'wakatime/vim-wakatime'

Plug 'takac/vim-hardtime'
let g:hardtime_allow_different_key = 1
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
let g:hardtime_maxcount = 9
let g:hardtime_ignore_buffer_patterns = ['dbui', 'defx']

Plug 'AndrewRadev/tagalong.vim'
let g:tagalong_filetypes = [
      \ 'xml',
      \ 'html',
      \ 'php',
      \ 'javascript',
      \ 'eruby',
      \ 'javascriptreact'
      \ ]

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

if executable('rg')
  set grepprg=rg\ --vimgrep\ --hidden\
        \ --glob\ '!.git'\
        \ --glob\ '!.idea'\
        \ --glob\ '!.vscode'\
        \ --glob\ '!node_modules'\
        \ --glob\ '!vendor'\
        \ --glob\ '!composer'\
        \ --glob\ '!gems'\
        \ --glob\ '!tmp'
endif

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
hi NormalFloat                    ctermfg=white    ctermbg=black    cterm=none
hi Pmenu                          ctermfg=white    ctermbg=black    cterm=none
hi PmenuSel                       ctermfg=black    ctermbg=blue     cterm=none

hi ColorColumn                    ctermfg=none     ctermbg=black
hi SpecialKey                     ctermfg=darkgray ctermbg=none     cterm=none
hi Whitespace                     ctermfg=darkgray ctermbg=none     cterm=none

hi LineNr                         ctermfg=darkgray ctermbg=none     cterm=none
hi LineNrAbove                    ctermfg=darkgray ctermbg=none     cterm=none
hi LineNrBelow                    ctermfg=darkgray ctermbg=none     cterm=none
hi CursorLineNr                   ctermfg=none     ctermbg=none     cterm=none

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

" Relative path (insert mode)
augroup changeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup loadFile
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save position cursor
  autocmd VimResized * wincmd = " auto resize window
  autocmd BufWritePre * call Mkdir() " create file when folder is not exists
  autocmd BufWritePost *.snippets :CmpUltisnipsReloadSnippets
augroup end

augroup loadConfigSql
  autocmd!
  autocmd FileType dbui,sql,mysql,plsql setlocal nocursorline
  autocmd FileType sql,mysql,plsql
        \ lua require('cmp').setup.buffer({
        \   sources = {{ name = 'vim-dadbod-completion' }}
        \ })
augroup end

"--- Load lua---
lua << EOF
  require 'module_treesitter'
  require 'module_lspconfig'
  require 'module_telescope'
  require 'module_fidget'
  require 'module_cmp'
EOF
