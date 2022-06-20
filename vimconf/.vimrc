" General setting
set nobackup
set noswapfile
set nocompatible
set encoding=utf-8

set autoread
set autowrite

set hlsearch
set incsearch
set ignorecase
set smartcase

set autoindent
set backspace=indent,eol,start
set completeopt=menu,menuone
set tabstop=2 shiftwidth=2 expandtab | retab

set list
set listchars=tab:>\ ,trail:-,nbsp:+

set number
set laststatus=2
set signcolumn=yes
set textwidth=80
set colorcolumn=+1

set showmatch
set matchtime=0

set ttimeout
set ttimeoutlen=100

set mouse=a
set ttymouse=sgr

" Set keymap
let mapleader = ' '

" Customizer mapping
nnoremap Y y$
nnoremap gm `[v`]
nnoremap <silent><leader>D :bd!<cr>
nnoremap <silent><leader>L :set number!<cr>
nnoremap <silent><C-l> :noh<cr>:redraw!<cr>
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

" Relative path(insert mode)
augroup changeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

" Customize theme
syntax off
set background=dark

hi clear SignColumn
hi clear VertSplit
hi clear Error

filetype on
filetype indent on

hi NonText                        ctermfg=none     ctermbg=none     cterm=none
hi Normal                         ctermfg=none     ctermbg=none     cterm=none
hi Pmenu                          ctermfg=white    ctermbg=black    cterm=none
hi PmenuSel                       ctermfg=black    ctermbg=blue     cterm=none

hi LineNr                         ctermfg=darkgray ctermbg=none     cterm=none
hi LineNrAbove                    ctermfg=darkgray ctermbg=none     cterm=none
hi LineNrBelow                    ctermfg=darkgray ctermbg=none     cterm=none

hi ColorColumn                    ctermfg=none     ctermbg=black
hi SpecialKey                     ctermfg=darkgray ctermbg=none     cterm=none
hi Whitespace                     ctermfg=darkgray ctermbg=none     cterm=none

" Run when load file
augroup loadFile
  autocmd!
  runtime macros/matchit.vim " load matchit
  autocmd FocusGained * checktime
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save late position cursor
  autocmd VimResized * wincmd = " resize window

  autocmd BufWritePre * :%s/\s\+$//e " trim space when save
  autocmd BufWritePre * call Mkdir() " create file when folder is not exists
augroup end
