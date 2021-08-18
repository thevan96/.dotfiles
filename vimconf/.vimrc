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

" Set keymap
let mapleader = ' '

" Disable netrw
" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1

" Customizer mapping
nnoremap Y y$
nnoremap gV `[v`]
nnoremap <silent><C-l> :noh<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Mapping copy clipboard
nnoremap <leader>y "+yy
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>

" Navigate quickfix
nnoremap <silent>gp :cp<cr>
nnoremap <silent>gn :cn<cr>
nnoremap <silent>go :copen<cr>
nnoremap <silent>gx :cclose<cr>

" Shifting blocks
xnoremap > >gv
xnoremap < <gv

" Execute code
augroup executeCode
  autocmd FileType c nnoremap <silent><leader>e
        \ :term gcc % -o %< && ./%<<cr>
  autocmd FileType java nnoremap <silent><leader>e
        \ :term javac % && java %<<cr>
  autocmd FileType cpp nnoremap <silent><leader>e
        \ :term g++ -std=c++17 % -o %< && ./%<<cr>
  autocmd FileType python nnoremap <silent><leader>e
        \ :term python %<cr>
  autocmd FileType javascript nnoremap <silent><leader>e
        \ :term node %<cr>
  autocmd FileType ruby nnoremap <silent><leader>e
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

" Auto paste
augroup changeWorkingDirectory
  autocmd InsertEnter * silent set paste
  autocmd InsertLeave * silent set nopaste
augroup end

" Relative path(insert mode)
augroup changeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

" Customize theme
syntax off
set background=dark
hi clear LineNr
hi clear SignColumn
hi NormalFloat ctermbg=gray
hi Visual ctermfg=black ctermbg=white
hi Pmenu ctermfg=black ctermbg=gray
hi PmenuSel ctermfg=white ctermbg=darkgray

" Run when load file
augroup loadFile
  autocmd!
  runtime macros/matchit.vim " load matchit
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save late position cursor
  autocmd FileType qf wincmd J " set position quickfix bottom
  autocmd FileType ruby setlocal suffixesadd+=.rb " gf open file require ruby
  autocmd VimResized * wincmd = " resize window
  autocmd BufWritePre * :%s/\s\+$//e " trim space when save
  autocmd BufWritePre * call s:Mkdir() " create file when folder is not exists
  autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup end
