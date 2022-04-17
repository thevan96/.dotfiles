" General setting
set nobackup
set noswapfile
set encoding=utf-8

set hlsearch
set incsearch
set ignorecase
set smartcase

set autoindent
set smartindent
set completeopt=menu,menuone
set list listchars=tab:␣\ ,extends:>,precedes:<

set nonumber
set laststatus=1
set signcolumn=yes
set textwidth=80
set scrolloff=3

" Other
set mouse=a
set showmatch
set matchtime=0
set diffopt+=vertical

filetype on
filetype indent on
let g:netrw_banner = 0
let html_no_rendering = 1

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab | retab
augroup settingTabSpace
  autocmd!
  autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab | retab
augroup end

" Set keymap
let mapleader = ' '

" Float terminal
if has('nvim')
  tmap <Esc> <C-\><C-n>
endif

" Customizer mapping
nnoremap Y y$
nnoremap gm `[v`]
xnoremap <silent><C-l> :noh<cr>:redraw<cr>
nnoremap <silent><leader>L :set number!<cr>
nnoremap <silent><leader>D :bd!<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent><leader>C :execute 'set colorcolumn='
                  \ . (&colorcolumn == '' ? '80' : '')<cr>

" Mapping copy clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>

" Better indent, move
xnoremap < <gv
xnoremap > >gv

" Navigate quickfix
nnoremap <silent>gp :cprev<cr>
nnoremap <silent>gn :cnext<cr>
nnoremap <silent>gN :cfirst<cr>
nnoremap <silent>gP :clast<cr>
nnoremap <silent>go :copen<cr>
nnoremap <silent>gx :cclose<cr>

" Open in tab terminal(tmux/gnome terminal)
function! OpenNewTab()
  let dir = expand('%:p:h')

  let command = ':!tmux new-window -c '.dir.' -a'
  " Gnome terminal ':!gnome-terminal --tab --working-directory='.dir

  if isdirectory(dir)
    silent execute(command)
  endif
endfunction
nnoremap <silent><leader>T :call OpenNewTab()<cr>

" Execute Code
function! ExecuteCode()
  let l:languageSupport = {
        \ 'ts': ':below sp | term tsc %',
        \ 'js': ':below sp | term node %',
        \ 'rb': ':below sp | term ruby %',
        \ 'py': ':below sp | term pyton %',
        \ 'cpp': ':below sp | term g++ -std=c++14 % -o %<',
        \ 'rs': ':below sp | term rustc %',
        \ 'go': ':below sp | term go %',
        \ }

  let l:extension = expand('%:e')
  if l:languageSupport->has_key(l:extension)
    execute l:languageSupport[l:extension]
  end
endfunction
nnoremap <silent><leader>R :call ExecuteCode()<cr>:startinsert<cr>

" Auto create file/folder
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

call plug#begin()

" Core plugins
Plug 'neovim/nvim-lspconfig'

Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
augroup defxConfig
  autocmd FileType defx setlocal nobuflisted nonumber norelativenumber
  autocmd FileType defx call s:defx_my_settings()
  autocmd BufWritePost * call defx#redraw()
augroup end
nnoremap <silent><leader>f :Defx
      \ -resume
      \ -sort=extension:filename
      \ -columns=indent:indent:icon:mark:filename
      \ -show-ignored-files<cr><C-w>=
nnoremap <silent><leader>F :Defx -search-recursive=`expand('%:p')`
      \ -resume
      \ -sort=extension:filename
      \ -columns=indent:indent:icon:mark:filename
      \ -show-ignored-files<cr><C-w>=
function! s:defx_my_settings() abort
  call defx#custom#column('icon', {
        \ 'directory_icon': ' +',
        \ 'opened_icon': ' -',
        \ 'file_icon': '  ',
        \ 'root_icon': '',
        \ })
  nnoremap <silent><buffer><expr> <cr>
        \ defx#do_action('multi', ['drop', 'quit'])
  nnoremap <silent><buffer><expr> l
        \ defx#do_action('open_tree')
  nnoremap <silent><buffer><expr> h
        \ defx#do_action('close_tree')
  nnoremap <silent><buffer><expr> j 'j'
  nnoremap <silent><buffer><expr> k 'k'
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> D
        \ defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> C
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> M
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> P
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> R
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> K
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> T
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> Y
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> A
        \ defx#do_action('toggle_select_visual')
  nnoremap <silent><buffer><expr> U
        \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> R
        \ defx#do_action('search',
        \ fnamemodify(defx#get_candidate().action__path, ':h')
        \ )
  nnoremap <silent><buffer><expr> <Space>
        \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> <C-l>
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <C-g>
        \ defx#do_action('print')
  nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
endfunction

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

Plug 'dense-analysis/ale'
let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1

let g:ale_set_signs = 1
let g:ale_set_highlights = 0

let g:ale_open_list = 0
let g:ale_set_loclist = 0
let g:ale_set_quickfix = 0

let g:ale_sign_error = '~~'
let g:ale_sign_infor = '--'
let g:ale_sign_warning = '>>'
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
      \ }

nmap <silent><C-k> <Plug>(ale_previous_wrap)
nmap <silent><C-j> <Plug>(ale_next_wrap)
nnoremap <silent><leader>p :ALEFix<cr>

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>o <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>i <cmd>lua require('telescope.builtin').find_files{
      \ find_command = { 'fdfind', '--type', 'f', '--hidden', '--no-ignore' }
      \ }<cr>
nnoremap <leader>n <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>N <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>s
      \ <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>S
      \ <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>

Plug 'tpope/vim-fugitive'
nnoremap <silent><leader>G :Git<cr>
nnoremap <silent><leader>gd :Gdiffsplit<cr>
nnoremap <leader>gg :Git<space>

Plug 'vim-test/vim-test'
let test#strategy = 'basic'
nmap <silent><leader>tf :TestFile<cr>
nmap <silent><leader>tn :TestNearest<cr>
nmap <silent><leader>tl :TestLast<cr>
nmap <silent><leader>ts :TestSuite<cr>

" Other plugins
Plug 'j-hui/fidget.nvim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key = '<C-h>'

Plug 'AndrewRadev/tagalong.vim'
let g:tagalong_filetypes = ['xml', 'html', 'php', 'javascript', 'eruby']

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'
let g:winresizer_vert_resize = 5
let g:winresizer_horiz_resize = 3

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

Plug 'stefandtw/quickfix-reflector.vim'
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

" Config Provider
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_python_provider = 0
let g:loaded_ruby_provider = 0
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
let g:ruby_host_prog = expand('$HOME/.asdf/shims/neovim-ruby-host')
call plug#end()

" Customize theme
syntax off
set background=dark

hi clear SignColumn
hi clear VertSplit
hi clear Error

hi NonText              ctermfg=none       ctermbg=none        cterm=none
hi Normal               ctermfg=none       ctermbg=none        cterm=none
hi NormalFloat          ctermfg=none       ctermbg=darkgray    cterm=none
hi Pmenu                ctermfg=white      ctermbg=darkgray    cterm=none
hi PmenuSel             ctermfg=black      ctermbg=blue        cterm=none
hi ColorColumn          ctermfg=none       ctermbg=darkgray

hi DiagnosticError      ctermfg=none       ctermbg=none        cterm=none
hi DiagnosticWarn       ctermfg=none       ctermbg=none        cterm=none
hi DiagnosticInfo       ctermfg=none       ctermbg=none        cterm=none
hi DiagnosticHint       ctermfg=none       ctermbg=none        cterm=none

hi DiagnosticSignError  ctermfg=red        ctermbg=none        cterm=none
hi DiagnosticSignWarn   ctermfg=yellow     ctermbg=none        cterm=none
hi DiagnosticSignInfo   ctermfg=blue       ctermbg=none        cterm=none
hi DiagnosticSignHint   ctermfg=green      ctermbg=none        cterm=none

hi ALEErrorSign         ctermbg=none       ctermfg=red         cterm=none
hi ALEInforSign         ctermbg=none       ctermfg=blue        cterm=none
hi ALEWarningSign       ctermbg=none       ctermfg=yellow      cterm=none

augroup loadFile
  autocmd!
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save position cursor
  autocmd VimResized * wincmd = " auto resize window
  autocmd BufWritePre * :%s/\s\+$//e " trim space when save
  autocmd BufWritePre * call Mkdir() " create file when folder is not exists
augroup end

lua << EOF
  require 'module_lspconfig'
  require 'module_telescope'
  require 'module_treesitter'
  require 'module_fidget'
  require 'module_cmp'
EOF
