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
set matchtime=0
set autoindent
set smartindent

set backspace=indent,eol,start
set completeopt=menu,preview

set list
set listchars=tab:>\ ,trail:-,nbsp:+
set wildmenu
set wildmode=full
set diffopt=vertical

set nonumber
set laststatus=2
set signcolumn=yes
set textwidth=80
set colorcolumn=+1

set ttimeout
set ttimeoutlen=100

" Other
set mouse=a
set ttymouse=sgr
packadd termdebug
packadd matchit

" Netrw
let g:netrw_banner = 0
let g:netrw_cursor = 0
let g:netrw_keepdir= 0
let g:netrw_localcopydircmd = 'cp -r'

" Disable
let html_no_rendering = 1

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab | retab
augroup settingTabSpace
  autocmd!
  autocmd FileType go setlocal tabstop=4 shiftwidth=4 noexpandtab | retab
  autocmd FileType vim setlocal tabstop=2 shiftwidth=2 expandtab | retab
  autocmd FileType snippets setlocal tabstop=2 shiftwidth=2 expandtab | retab
augroup end

" Set keymap
let mapleader = ' '

" Float terminal
if has('nvim')
  tmap <Esc> <C-\><C-n>
endif

" Customizer mapping
nnoremap Y y$
nnoremap gp `[v`]
nnoremap <silent><C-l> :noh<cr>:redraw!<cr>
nnoremap <silent><leader>L :set number!<cr>
nnoremap <silent><leader>vi
      \ :source $MYVIMRC<cr>
      \ :echo 'Reload vim config done!'<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
nnoremap <leader>o :ls<cr>:echo '----------------------------'<cr>:b<Space>
inoremap <C-D> <Esc>:call setline(".",substitute(getline(line(".")),'^\s*',
      \ matchstr(getline(line(".")-1),'^\s*'),''))<cr>I

" Mapping copy clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>
nnoremap <leader>p "+p
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

hi StatusLine                     ctermfg=white    ctermbg=black    cterm=bold
hi StatusLineNC                   ctermfg=white    ctermbg=black    cterm=none

hi LineNr                         ctermfg=darkgray ctermbg=none     cterm=none
hi LineNrAbove                    ctermfg=darkgray ctermbg=none     cterm=none
hi LineNrBelow                    ctermfg=darkgray ctermbg=none     cterm=none

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

function! NetrwSetting()
  nnoremap <silent><buffer> u <nop>
  nnoremap <silent><buffer> U <nop>
  nnoremap <silent><buffer> <C-l> :nohl<cr>:e .<cr>
  nnoremap <silent><buffer> mL :echo join(
        \ netrw#Expose('netrwmarkfilelist'), "\n")<cr>
endfunction

augroup changeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

" Run when load file
augroup loadFile
  autocmd!
  autocmd FocusGained * redraw
  autocmd BufEnter * silent! cd `=root_cwd`
  autocmd QuickFixCmdPost [^l]* cwindow
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save late position cursor
  autocmd VimResized * wincmd = " resize window

  autocmd BufWritePre * :%s/\s\+$//e " trim space when save
  autocmd BufWritePre * call Mkdir() " create file when folder is not exists

  autocmd FileType netrw call NetrwSetting()
augroup end
