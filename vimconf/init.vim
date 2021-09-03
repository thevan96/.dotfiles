" General setting
set nobackup
set noswapfile
set encoding=utf-8

set hlsearch
set incsearch
set ignorecase
set smartcase

set autoindent
set completeopt=menu,preview
set tabstop=2 shiftwidth=2 expandtab | retab
set list listchars=tab:␣\ ,extends:>,precedes:<

set laststatus=2
set signcolumn=yes
set textwidth=80

set showmatch
set matchtime=0

set mouse=a
set diffopt+=vertical

" Set keymap
let mapleader = ' '

" Float terminal
if has('nvim')
  tmap <Esc> <C-\><C-n>
endif

" Customizer mapping
nnoremap Y y$
nnoremap gm `[v`]
nnoremap <silent><leader>X :bd<cr>
nnoremap <silent><leader>L :set number!<cr>
nnoremap <silent><C-l> :noh<cr>:redraw!<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Mapping copy clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>

" Navigate quickfix
nnoremap <silent>gp :cprev<cr>
nnoremap <silent>gn :cnext<cr>
nnoremap <silent>gN :cfirst<cr>
nnoremap <silent>gP :clast<cr>
nnoremap <silent>go :copen<cr>
nnoremap <silent>gx :cclose<cr>

" Execute Code
function! ExecuteCode()
  let l:languageSupport = {
        \ 'js': ':below sp | term node %',
        \ 'rb': ':below sp | term ruby %',
        \ 'py': ':below sp | term pyton %',
        \ 'cpp': ':below sp | term g++ -std=c++14 % -o %<',
        \ 'rs': ':below sp | term rustc %',
        \ }

  let l:extension = expand('%:e')
  if l:languageSupport->has_key(l:extension)
    execute l:languageSupport[l:extension]
  end
endfunction
nnoremap <silent><leader>R :call ExecuteCode()<cr>

" Open in tab terminal(tmux/gnome terminal)
function! OpenNewTab()
  let dir = expand('%:p:h')

  let command = ':!tmux new-window -c '.dir.' -a'
  "Gnome terminal ':!gnome-terminal --tab --working-directory='.dir

  if isdirectory(dir)
    silent execute(command)
  endif
endfunction
nnoremap <silent><leader>T :call OpenNewTab()<cr>

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
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'quangnguyen30192/cmp-nvim-ultisnips'

Plug 'neovim/nvim-lspconfig'

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
augroup defxConfig
  autocmd FileType defx set nobuflisted nonumber
  autocmd FileType defx call s:defx_my_settings()
  autocmd BufWritePost * call defx#redraw()
augroup end
nnoremap <silent><leader>f :Defx
      \ -split=vertical
      \ -winwidth=35
      \ -direction=botright
      \ -sort=extension:filename
      \ -columns=indent:indent:icon:mark:filename
      \ -show-ignored-files
      \ -resume -listed<cr><C-w>=
nnoremap <silent><leader>F :Defx -search-recursive=`expand('%:p')`
      \ -split=vertical
      \ -winwidth=35
      \ -direction=botright
      \ -sort=extension:filename
      \ -columns=indent:indent:icon:mark:filename
      \ -show-ignored-files
      \ -resume -listed<cr><C-w>=
function! s:defx_my_settings() abort
  call defx#custom#column('icon', {
        \ 'directory_icon': '+',
        \ 'opened_icon': '-',
        \ 'file_icon': ' ',
        \ 'root_icon': '',
        \ })
  nnoremap <silent><buffer><expr> <cr>
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> sv
        \ defx#do_action('drop', 'vsplit')
  nnoremap <silent><buffer><expr> ss
        \ defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> u
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> o
        \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> dd
        \ defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> mv
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> mk
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> t
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> T
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> rn
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> L
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> a
        \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> A
        \ defx#do_action('toggle_select_visual')
  nnoremap <silent><buffer><expr> cl
        \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> yp
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> i
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> R
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> P defx#do_action('search',
        \ fnamemodify(defx#get_candidate().action__path, ':h'))
  nnoremap <silent><buffer><expr> j 'j'
  nnoremap <silent><buffer><expr> k 'k'
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

let g:ale_cpp_cpplint_options = '--filter=-build/c++11'

if filereadable('Gemfile') && match(readfile('Gemfile'), 'rubocop')
  let g:ale_ruby_rubocop_executable = 'bundle'
  echo 'Rubocop bundle active!'
endif

if filereadable('.prettierrc.json')
  if match(readfile('package.json'), 'prettier')
    let g:ale_javascript_prettier_executable = 'npx prettier'
    echo 'Prettier local active!'
  else
    echo 'Prettier local not found'
  end
endif

let g:ale_linters = {
      \ 'ruby': ['rubocop'],
      \ 'cpp': ['cpplint'],
      \ }
let g:ale_fixers = {
      \ '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'javascript': ['prettier'],
      \ 'javascriptreact': ['prettier'],
      \ 'ruby': ['rubocop'],
      \ 'html': ['prettier'],
      \ 'json': ['prettier'],
      \ 'css': ['prettier'],
      \ 'scss': ['prettier'],
      \ 'yaml': ['prettier'],
      \ 'markdown': ['prettier'],
      \ }

nmap <silent><c-k> <Plug>(ale_previous_wrap)
nmap <silent><c-j> <Plug>(ale_next_wrap)
nnoremap <silent><leader>p :ALEFix<cr>

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
nnoremap <leader>i <cmd>lua require('telescope.builtin').find_files{
      \ find_command = { 'fdfind', '--type', 'f', '--hidden', '--no-ignore' }
      \ }<cr>
nnoremap <leader>o <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>n <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>N <cmd>lua require('telescope.builtin').grep_string()<cr>
nnoremap <leader>s <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>
nnoremap <leader>S <cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>

Plug 'tpope/vim-fugitive'
nnoremap <silent><leader>G :ToggleGStatus<cr>
nnoremap <silent><leader>gd :Gdiffsplit<cr>
nnoremap <silent><leader>gD :Gdiffsplit!<cr>
function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Git
    endif
endfunction
command ToggleGStatus :call ToggleGStatus()

Plug 'vim-test/vim-test'
let test#strategy = 'basic'
nmap <silent><leader>tf :TestFile<cr>
nmap <silent><leader>tn :TestNearest<cr>
nmap <silent><leader>tl :TestLast<cr>
nmap <silent><leader>ts :TestSuite<cr>

Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }

" Other plugins
Plug 'tpope/vim-rails'
Plug 'MaxMEllon/vim-jsx-pretty'

Plug 'ferrine/md-img-paste.vim'
let g:mdip_imgdir = 'images'
autocmd FileType markdown nmap <buffer><silent><leader>m
      \ :call mdip#MarkdownClipboardImage()<cr>

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key='<c-h>'

Plug 'AndrewRadev/tagalong.vim'
let g:tagalong_filetypes = ['xml', 'html', 'php', 'javascript', 'eruby']

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>w'
let g:winresizer_vert_resize = 5
let g:winresizer_horiz_resize = 3

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
augroup editorconfig
  autocmd!
  autocmd BufRead,BufNewFile,BufWrite .editorconf EditorConfigReload
augroup end

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
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
let g:ruby_host_prog = expand('$HOME/.asdf/shims/neovim-ruby-host')
call plug#end()

" Customize theme
syntax on
set background=dark
hi clear               SignColumn
hi clear               VertSplit
hi Underlined          ctermfg=none                           cterm=none
hi Pmenu               ctermfg=white      ctermbg=darkgray    cterm=none
hi PmenuSel            ctermfg=black      ctermbg=blue        cterm=none
hi Normal              ctermfg=none       ctermbg=none        cterm=none

hi Comment             ctermfg=none       ctermbg=none        cterm=none
hi Constant            ctermfg=none       ctermbg=none        cterm=none
hi String              ctermfg=none       ctermbg=none        cterm=none
hi Character           ctermfg=none       ctermbg=none        cterm=none
hi Number              ctermfg=none       ctermbg=none        cterm=none
hi Boolean             ctermfg=none       ctermbg=none        cterm=none
hi Float               ctermfg=none       ctermbg=none        cterm=none
hi Identifier          ctermfg=none       ctermbg=none        cterm=none
hi Function            ctermfg=none       ctermbg=none        cterm=none
hi Statement           ctermfg=none       ctermbg=none        cterm=none
hi Conditional         ctermfg=none       ctermbg=none        cterm=none
hi Repeat              ctermfg=none       ctermbg=none        cterm=none
hi Label               ctermfg=none       ctermbg=none        cterm=none
hi Keyword             ctermfg=none       ctermbg=none        cterm=none
hi Exception           ctermfg=none       ctermbg=none        cterm=none
hi PreProc             ctermfg=none       ctermbg=none        cterm=none
hi Include             ctermfg=none       ctermbg=none        cterm=none
hi Define              ctermfg=none       ctermbg=none        cterm=none
hi Macro               ctermfg=none       ctermbg=none        cterm=none
hi PreCondit           ctermfg=none       ctermbg=none        cterm=none
hi Type                ctermfg=none       ctermbg=none        cterm=none
hi StorageClass        ctermfg=none       ctermbg=none        cterm=none
hi Structure           ctermfg=none       ctermbg=none        cterm=none
hi Typedef             ctermfg=none       ctermbg=none        cterm=none
hi Special             ctermfg=none       ctermbg=none        cterm=none
hi SpecialChar         ctermfg=none       ctermbg=none        cterm=none
hi Tag                 ctermfg=none       ctermbg=none        cterm=none
hi SpecialComment      ctermfg=none       ctermbg=none        cterm=none
hi Debug               ctermfg=none       ctermbg=none        cterm=none

hi DiagnosticError     ctermfg=none       ctermbg=none        cterm=none
hi DiagnosticWarn      ctermfg=none       ctermbg=none        cterm=none
hi DiagnosticInfo      ctermfg=none       ctermbg=none        cterm=none
hi DiagnosticHint      ctermfg=none       ctermbg=none        cterm=none

hi DiagnosticSignError ctermfg=red        ctermbg=none        cterm=none
hi DiagnosticSignWarn  ctermfg=yellow     ctermbg=none        cterm=none
hi DiagnosticSignInfo  ctermfg=blue       ctermbg=none        cterm=none
hi DiagnosticSignHint  ctermfg=green      ctermbg=none        cterm=none

hi ALEErrorSign        ctermbg=none       ctermfg=red         cterm=none
hi ALEInforSign        ctermbg=none       ctermfg=blue        cterm=none
hi ALEWarningSign      ctermbg=none       ctermfg=yellow      cterm=none

hi OverLength          ctermbg=darkgray   ctermfg=none        cterm=none
match OverLength /\%81v.\+/

" Run when load file
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
  require 'module_cmp'
EOF
