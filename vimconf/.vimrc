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
set smartindent
set backspace=indent,eol,start
set completeopt=menu,menuone,noselect
set tabstop=2 shiftwidth=2 expandtab | retab
set list listchars=tab:␣\ ,extends:>,precedes:<

set nonumber
set wildmenu
set laststatus=1
set signcolumn=yes
set textwidth=80
set lazyredraw

set showmatch
set matchtime=0

set ttimeout
set ttimeoutlen=100

set mouse=a
set ttymouse=sgr

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
nnoremap <silent><leader>so :source $MYVIMRC<CR>
nnoremap <silent><C-l> :noh<cr>:redraw!<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent><leader>C :execute 'set colorcolumn='
                  \ . (&colorcolumn == '' ? '80' : '')<cr>

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
        \ 'js': ':below term node %',
        \ 'rb': ':below term ruby %',
        \ 'py': ':below term pyton %',
        \ 'cpp': ':below term g++ -std=c++14 % -o %<',
        \ 'rs': ':below term rustc %',
        \ }

  let l:extension = expand('%:e')
  if l:languageSupport->has_key(l:extension)
    execute l:languageSupport[l:extension]
  end
endfunction
nnoremap <silent><leader>R :call ExecuteCode()<cr>

" Open in tmux(tmux/gnome terminal)
function! OpenNewTab()
  let dir = expand('%:p:h')

  let tmuxcommand = ':!tmux new-window -c '.dir
  " ':!gnome-terminal --tab --working-directory='.dir
  if isdirectory(dir)
    silent execute(tmuxcommand)
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

hi Title              ctermfg=none                    cterm=none
hi Underlined         ctermfg=none                    cterm=none
hi Pmenu               ctermfg=white      ctermbg=darkgray    cterm=none
hi PmenuSel            ctermfg=black      ctermbg=blue        cterm=none
hi Normal              ctermfg=none       ctermbg=none        cterm=none

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

