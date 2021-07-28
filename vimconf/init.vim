"--- General setting ---"
set termguicolors
set encoding=utf-8

filetype indent on
filetype plugin on

set autoread
set autoindent

set nobackup
set noswapfile

set hlsearch
set incsearch

set tabstop=2 shiftwidth=2 expandtab | retab
set list listchars=tab:␣\ ,extends:>,precedes:<
set fillchars=vert:\|

set hidden
set nonumber
set laststatus=1

set showmatch
set matchtime=0

set mouse=a
set signcolumn=yes
set diffopt+=vertical

" Set keymap
let mapleader = ' '

" Disable netrw
let g:netrw_localcopydircmd = 'cp -r'

" Customizer mapping
nnoremap Y y$
nnoremap gV `[v`]
nnoremap <tab> <C-^>
nnoremap <silent><C-l> :noh<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Mapping copy clipboard
nnoremap <leader>y "+yy
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>

" Navigate quickfix
nnoremap <silent>qp :cp<cr>
nnoremap <silent>qn :cn<cr>
nnoremap <silent>qo :copen<cr>
nnoremap <silent>qx :cclose<cr>

" Shifting blocks
xnoremap > >gv
xnoremap < <gv

" ExecuteCode
augroup executeCode
  autocmd FileType c nnoremap <leader>e
        \ :sp<cr>:term gcc % -o %< && ./%<<cr> :startinsert<cr>
  autocmd FileType java nnoremap <leader>e
        \ :sp<cr>:term javac % && java %<<cr> :startinsert<cr>
  autocmd FileType cpp nnoremap <leader>e
        \ :sp<cr>:term g++ -std=c++17 % -o %< && ./%<<cr> :startinsert<cr>
  autocmd FileType python nnoremap <leader>e
        \ :sp<cr>:term python %<cr> :startinsert<cr>
  autocmd FileType javascript nnoremap <leader>e
        \ :sp<cr>:term node %<cr> :startinsert<cr>
  autocmd FileType ruby nnoremap <leader>e
        \ :sp<cr>:term ruby %<cr> :startinsert<cr>
augroup END

" Disable split
nnoremap <c-w>v <nop>
nnoremap <c-w>s <nop>

" Auto create folder in path
function s:Mkdir()
  let dir = expand('%:p:h')

  if dir =~ '://'
    return
  endif

  if !isdirectory(dir)
    call mkdir(dir, 'p')
    echo 'Created non-existing directory: '.dir
  endif
endfunction

" Relative path(insert mode)
augroup changeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

call plug#begin()
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-commentary'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'AndrewRadev/tagalong.vim'
let g:tagalong_filetypes = ['xml', 'html', 'php', 'javascript', 'eruby']

Plug 'dense-analysis/ale'
let g:ale_disable_lsp = 1
let g:ale_set_highlights = 0
let g:ale_linters_explicit = 1
let g:ale_linters = {
      \   'ruby': ['rubocop'],
      \}
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \   'html': ['prettier'],
      \   'css': ['prettier'],
      \   'scss': ['prettier'],
      \   'ruby': ['rubocop'],
      \   'javascript': ['prettier'],
      \}
if filereadable('Gemfile') && match(readfile('Gemfile'), 'rubocop') > 0
  let g:ale_ruby_rubocop_executable = 'bundle'
endif

if filereadable('.prettierrc') && match(readfile('package.json'), 'prettier') > 0
  let g:ale_javascript_prettier_executable = 'prettier'
  let g:ale_javascript_prettier_use_global = 1
endif

nmap <silent>gk <Plug>(ale_previous_wrap)
nmap <silent>gj <Plug>(ale_next_wrap)
nnoremap <silent><leader>p :ALEFix<cr>

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
augroup defxConfig
  autocmd FileType defx set nobuflisted
  autocmd FocusGained * call defx#redraw()
  autocmd FileType defx call s:defx_my_settings()
augroup end
nnoremap <silent><leader>f :Defx
      \ -split=vertical -winwidth=42 -direction=botright
      \ -columns=indent:indent:icon:mark:filename
      \ -show-ignored-files
      \ -resume -listed<cr><C-w>=
nnoremap <silent><leader>F :Defx -search=`expand('%:p')`
      \ -split=vertical -winwidth=42 -direction=topleft
      \ -columns=indent:indent:icon:mark:filename
      \ -show-ignored-files
      \ -resume -listed<cr><C-w>=
function! s:defx_my_settings() abort
  call defx#custom#column('filename', {
        \ 'min_width': 50,
        \ 'max_width': 50,
        \ })
  nnoremap <silent><buffer><expr> <cr>
        \ defx#is_binary() ?
        \ defx#do_action('execute_system') :
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> ss
        \ defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> sv
        \ defx#do_action('drop', 'vsplit')
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
  nnoremap <silent><buffer><expr> f
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> F
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> rn
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> *
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
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> rr
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> P defx#do_action('search',
        \ fnamemodify(defx#get_candidate().action__path, ':h'))
  nnoremap <silent><buffer><expr> j 'j'
  nnoremap <silent><buffer><expr> k 'k'
endfunction

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-pyright',
      \ 'coc-tsserver',
      \ 'coc-cssmodules',
      \ 'coc-html-css-support',
      \ ]

" Trigger completion.
imap <silent><expr> <c-x><c-o> coc#refresh()
imap <silent><expr> <c-space> coc#refresh()

" Remap <C-u> and <C-d> for scroll float windows/popups.
nnoremap <silent><nowait><expr>
      \ <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr><C-u>
      \ coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr><C-d>
      \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr><C-u>
      \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr><C-d>
      \ coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
vnoremap <silent><nowait><expr><C-u>
      \ coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"

" Remap keys for gotos, refresh
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>gJ <Plug>(coc-float-jump)
nmap <silent>gH <Plug>(coc-float-hide)
" nmap <silent>gk <Plug>(coc-diagnostic-prev)
" nmap <silent>gj <Plug>(coc-diagnostic-next)

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent>K :call <SID>show_documentation()<cr>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

Plug 'junegunn/fzf.vim'
set rtp+=~/.fzf
let g:fzf_layout = { 'down': '50%' }
nnoremap <silent><leader>i :Files<cr>
nnoremap <silent><leader>b :Buffers<cr>
nnoremap <silent><leader>n :Rg<cr>
nnoremap <silent><leader>N :Rg <c-r><c-w><cr>
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=1 showmode ruler

"--- Provider ---"
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:ruby_host_prog = expand('$HOME/.asdf/shims/neovim-ruby-host')
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
let g:loaded_node_provider = 0
call plug#end()

"--- Customize theme ---"
syntax on
set background=dark
hi clear LineNr
hi clear SignColumn
hi NormalFloat guibg=gray
hi Pmenu guifg=black guibg=gray
hi PmenuSel guifg=white guibg=darkgray gui=bold
hi Visual guifg=black guibg=white
hi CocUnderline cterm=underline

" Run when load file
augroup loadFile
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save position cursor
  autocmd FileType qf wincmd J " set position quickfix
  autocmd VimResized * wincmd = " resize window
  autocmd BufWritePre * :%s/\s\+$//e " trim space when save
  autocmd BufWritePre * call s:Mkdir() " create file when folder is not exists
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd FileType * set syntax= " Turn off color
augroup end

lua << EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = { enable = off },
    additional_vim_regex_highlighting = true
  }
EOF
