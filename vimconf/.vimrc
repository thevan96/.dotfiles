" General setting
set nocompatible
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

set ruler
set hidden
set nonumber
set wildmenu

set showmatch
set matchtime=0

set ttimeout
set ttimeoutlen=100

set mouse=a
set signcolumn=yes
set ttymouse=sgr
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

" Disable split
nnoremap <c-w>v <nop>
nnoremap <c-w>s <nop>

" Execute code
augroup executeCode
  autocmd FileType c nnoremap <leader>e
        \ :term gcc % -o %< && ./%<<cr>
  autocmd FileType java nnoremap <leader>e
        \ :term javac % && java %<<cr>
  autocmd FileType cpp nnoremap <leader>e
        \ :term g++ -std=c++17 % -o %< && ./%<<cr>
  autocmd FileType python nnoremap <leader>e
        \ :term python %<cr>
  autocmd FileType javascript nnoremap <leader>e
        \ :term node %<cr>
  autocmd FileType ruby nnoremap <leader>e
        \ :term ruby %<cr>
augroup END

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

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
call plug#end()

" Customize theme
syntax on
set background=dark
hi clear LineNr
hi clear SignColumn
hi NormalFloat ctermbg=gray
hi Visual ctermfg=black ctermbg=white
hi Pmenu ctermfg=black ctermbg=gray
hi PmenuSel ctermfg=white ctermbg=darkgray

" Run when load file
augroup loadFile
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save late position cursor
  autocmd FileType qf wincmd J " set position quickfix
  autocmd VimResized * wincmd = " resize window
  autocmd BufWritePre * :%s/\s\+$//e " trim space when save
  autocmd BufWritePre * call s:Mkdir() " create file when folder is not exists
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
  autocmd FileType * set syntax= " Turn off color
augroup end
