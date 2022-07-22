"--- General setting ---"
set nobackup
set noswapfile
set nocompatible
set encoding=utf-8

set autoread
set autowrite

set hlsearch
set incsearch
set ignorecase

set showmatch
set autoindent
set smartindent

set backspace=indent,eol,start
set completeopt=menu,menuone,noselect

set list
set listchars=tab:»\ ,trail:-,nbsp:+
set fillchars=vert:\|

set wildmenu
set wildmode=longest,list

set number
set norelativenumber

set laststatus=2
set signcolumn=yes
set textwidth=80
set colorcolumn=+1

set ttimeout
set ttimeoutlen=100

" Other
set mouse=a
set matchtime=0
set nofoldenable
set cursorline
set cursorlineopt=number
set ttymouse=sgr
set diffopt=vertical
set pumheight=30
set updatetime=100
packadd matchit

" Netrw
let g:netrw_banner = 0
let g:netrw_cursor = 0
let g:netrw_keepdir= 0
let g:netrw_localcopydircmd = 'cp -r'

" Disable
let html_no_rendering = 1
nnoremap S <nop>
inoremap <C-n> <nop>
inoremap <C-p> <nop>

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab | retab

" Set keymap
let mapleader = ' '
let g:root_cwd = getcwd()

" Float terminal
if has('nvim')
  tmap <Esc> <C-\><C-n>
endif

" Customizer mapping
nnoremap Y y$
nnoremap gp `[v`]
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

nnoremap <silent><leader>D :bd!<cr>
nnoremap <silent><C-l> :noh<cr>:redraw!<cr>
nnoremap <silent><leader>L :set norelativenumber!<cr>

nnoremap <leader>C :cd `=g:root_cwd`<cr>:echo 'Root: '.g:root_cwd<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
inoremap <C-D> <Esc>:call setline(".",substitute(getline(line(".")),'^\s*',
      \ matchstr(getline(line(".")-1),'^\s*'),''))<cr>I
nnoremap <silent><leader>vi
      \ :source $MYVIMRC<cr>
      \ :echo 'Reload vim config done!'<cr>

" File manager
nnoremap <leader>f :e .<cr>
nnoremap <leader>F :JumpFile<cr>

" Mapping copy clipboard and past
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>
nnoremap <leader>p o<esc>"+p
nnoremap <leader>P O<esc>"+p
vnoremap <leader>p "+p

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

" Open in tab terminal
nnoremap <leader>"
      \ :silent exe(':!tmux split-window -v -p 40 -c '.expand('%:p:h'))<cr>
nnoremap <leader>%
      \ :silent exe(':!tmux split-window -h -p 50 -c '.expand('%:p:h'))<cr>
nnoremap <leader>c
      \ :silent exe(':!tmux new-window -c '. expand('%:p:h').' -a')<cr>

"--- Customize theme ---"

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
hi CursorLineNr                   ctermfg=none     ctermbg=none     cterm=none

hi StatusLine                     ctermfg=white    ctermbg=black    cterm=bold
hi StatusLineNC                   ctermfg=white    ctermbg=black    cterm=none

hi ColorColumn                    ctermfg=none     ctermbg=black
hi SpecialKey                     ctermfg=darkgray ctermbg=none     cterm=none
hi Whitespace                     ctermfg=darkgray ctermbg=none     cterm=none

"--- Etc ---"
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

function! JumpFile()
  let file_name = expand('%:t')
  e %:p:h
  call search(file_name)
endfunction
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

augroup settingTabSpace
  autocmd!
  autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab | retab
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 expandtab | retab
  autocmd FileType snippets setlocal tabstop=2 shiftwidth=2 expandtab | retab
augroup end

augroup ChangeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup RunFile
  autocmd FileType javascript vnoremap <leader>R :w !node<cr>
  autocmd FileType javascript nnoremap <leader>R :!node %<cr>
  autocmd FileType javascriptreact vnoremap <leader>R :w !node<cr>
  autocmd FileType javascriptreact nnoremap <leader>R :!node %<cr>
  autocmd FileType python vnoremap <leader>R :w !python<cr>
  autocmd FileType python nnoremap <leader>R :!python %<cr>
  autocmd FileType cpp nnoremap <leader>R :!g++ % -o %:r && ./%:r<cr>
augroup end

" Run when load file
augroup loadFile
  autocmd!
  autocmd FocusGained * redraw!
  autocmd CursorMoved,CursorMovedI * setlocal norelativenumber
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save late position cursor
  autocmd VimResized * wincmd =

  autocmd BufWritePre * :%s/\s\+$//e " trim space when save
  autocmd BufWritePre * call Mkdir() " create file when folder is not exists

  autocmd FileType netrw call NetrwSetting()
augroup end
