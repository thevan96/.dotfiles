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
set smartcase

set list
set listchars=tab:>\ ,trail:-
set fillchars=vert:\|

set number
set norelativenumber

set laststatus=2
set signcolumn=yes

set wildmenu
set wildmode=longest,list

set textwidth=80
set colorcolumn=+1

set cursorline
set cursorlineopt=number

set backspace=indent,eol,start
set completeopt=menu,menuone,noselect

" Other
set mouse=a
set showmatch
set autoindent
set matchtime=0
set nofoldenable
set diffopt=vertical
set ttymouse=sgr
packadd matchit

" Netrw
let g:netrw_banner = 1
let g:netrw_cursor = 0
let g:netrw_keepdir= 0
let g:netrw_localcopydircmd = 'cp -r'

" Disable
nnoremap S <nop>
let html_no_rendering = 1

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
command! BufCurOnly execute '%bdelete|edit#|bdelete#'

nnoremap <silent><leader>D :bd!<cr>
nnoremap <silent><C-l> :noh<cr>:redraw!<cr>
nnoremap <silent><leader>m m`:set norelativenumber!<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
nnoremap <silent><leader>vi :source $MYVIMRC<cr>:echo 'Reload vim done!'<cr>
inoremap <C-d> <esc>:call setline('.',substitute(getline(line('.')),'^\s*',
      \ matchstr(getline(line('.')-1),'^\s*'),''))<cr>I

" File manager netrw
cnoreabbrev silent Explore execute 'JumpFile'
cnoreabbrev silent Vexplore execute 'vsp+JumpFile'
cnoreabbrev silent Sexplore execute 'sp+JumpFile'
command! Root execute 'cd ' fnameescape(g:root_cwd)

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
nnoremap <tab>o :copen<cr>
nnoremap <tab>x :cclose<cr>
nnoremap <tab>k :cprev<cr>
nnoremap <tab>j :cnext<cr>
nnoremap <tab>K :cfirst<cr>
nnoremap <tab>J :clast<cr>

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
filetype plugin indent on

hi clear Error
hi clear SignColumn
hi clear VertSplit

hi NonText                        ctermfg=none     ctermbg=none     cterm=none
hi Normal                         ctermfg=none     ctermbg=none     cterm=none
hi NormalFloat                    ctermfg=none     ctermbg=none     cterm=none
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
  Explore
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

augroup SettingTabSpace
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
  autocmd!
  autocmd FileType vimwiki nnoremap <leader>R :!node %<cr>
  autocmd FileType javascript vnoremap <leader>R :w !node<cr>
  autocmd FileType javascript nnoremap <leader>R :!node %<cr>
  autocmd FileType python vnoremap <leader>R :w !python<cr>
  autocmd FileType python nnoremap <leader>R :!python %<cr>
  autocmd FileType cpp nnoremap <leader>R
        \ :!g++ -std=c++17 -O2 -Wall -Wshadow % -o %:r<cr>
augroup end

augroup LoadFile
  autocmd!
  autocmd FocusGained * redraw!
  autocmd CursorMoved,CursorMovedI * setlocal norelativenumber
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save late position cursor
  autocmd VimResized * wincmd =

  autocmd BufWritePre * silent! :%s/\s\+$//e " trim whitespace
  autocmd BufWritePre * silent! :%s#\($\n\s*\)\+\%$## " trim endlines
  autocmd BufWritePre * silent! :g/^\_$\n\_^$/d " single blank line
  autocmd BufWritePre * call Mkdir() " create file when folder is not exists

  autocmd FileType netrw call NetrwSetting()
augroup end
