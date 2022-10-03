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
set mouse-=a
set showmatch
set autoindent
set scrolloff=3
set matchtime=0
set nofoldenable
set diffopt=vertical
set ttymouse=sgr
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

" Set keymap
let mapleader = ' '
let g:root_cwd = getcwd()

" Customizer mapping
nnoremap Y y$
nnoremap gp `[v`]
nnoremap <leader>o :ls<cr>:b<space>
nnoremap <silent><C-l> :noh<cr>:redraw!<cr>
nnoremap <silent><leader>n :set relativenumber!<cr>

command! Root execute 'cd ' fnameescape(g:root_cwd)
command! BufCurOnly execute '%bdelete|edit#|bdelete#'
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
inoremap <C-d> <esc>:call setline('.',substitute(getline(line('.')),'^\s*',
      \ matchstr(getline(line('.')-1),'^\s*'),''))<cr>I

" Navigate wrap
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Store relative line number jumps in the jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" File manager netrw
nnoremap <leader>ff :JumpFile<cr>
nnoremap <leader>fv :vsp+JumpFile<cr>
nnoremap <leader>fs :sp+JumpFile<cr>
nnoremap <leader>fr :e `=g:root_cwd`<cr>

" Mapping copy clipboard and past
nnoremap <leader>y "+yy
vnoremap <leader>y "+y
nnoremap <leader>Y vg_"+y
nnoremap <leader>gy :%y+<cr>
nnoremap <leader>p o<esc>"+p
nnoremap <leader>P O<esc>"+p
vnoremap <leader>p "+p

" Better indent, move
xnoremap < <gv
xnoremap > >gv

" Navigate quickfix/loclist
nnoremap go :copen<cr>
nnoremap gx :cclose<cr>
nnoremap gh :cprev<cr>
nnoremap gl :cnext<cr>
nnoremap gH :cfirst<cr>
nnoremap gL :clast<cr>

nnoremap zo :lopen<cr>
nnoremap zx :lclose<cr>
nnoremap zh :lprev<cr>
nnoremap zl :lnext<cr>
nnoremap zH :lfirst<cr>
nnoremap zL :llast<cr>

" Fix conflict git
if &diff
  nnoremap <leader>1 :diffget LOCAL<cr>:diffupdate<cr>
  nnoremap <leader>2 :diffget BASE<cr>:diffupdate<cr>
  nnoremap <leader>3 :diffget REMOTE<cr>:diffupdate<cr>
  nnoremap <leader><cr> :diffupdate<cr>:diffupdate<cr>

  function! GRemoveMarkers() range
    " echom a:firstline.'-'.a:lastline
    execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
  endfunction
  command! -range=% GremoveMarkers <line1>,<line2>call GRemoveMarkers()
endif

" Open in tab terminal
nnoremap <leader>" :silent
      \ exe(':!tmux split-window -v -p 40 -c '.expand('%:p:h'))<cr>
nnoremap <leader>% :silent
      \ exe(':!tmux split-window -h -p 50 -c '.expand('%:p:h'))<cr>
nnoremap <leader>c :silent
      \ exe(':!tmux new-window -c '. expand('%:p:h').' -a')<cr>

"--- Customize theme ---"

syntax off
set background=dark
filetype plugin indent on

hi clear Error
hi clear SignColumn
hi clear VertSplit

hi NonText                        ctermfg=none     ctermbg=none     cterm=none
hi Normal                         ctermfg=none     ctermbg=none     cterm=none
hi NormalFloat                    ctermfg=none     ctermbg=234      cterm=none
hi Pmenu                          ctermfg=15       ctermbg=236      cterm=none
hi PmenuSel                       ctermfg=0        ctermbg=39       cterm=none

hi LineNr                         ctermfg=240      ctermbg=none     cterm=none
hi LineNrAbove                    ctermfg=240      ctermbg=none     cterm=none
hi LineNrBelow                    ctermfg=240      ctermbg=none     cterm=none
hi CursorLine                     ctermfg=yellow   ctermbg=none     cterm=none
hi CursorLineNr                   ctermfg=yellow   ctermbg=none     cterm=none

hi ColorColumn                    ctermfg=none     ctermbg=233
hi SpecialKey                     ctermfg=234      ctermbg=none     cterm=none
hi Whitespace                     ctermfg=234      ctermbg=none     cterm=none

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

function! Trim()
  let pwd = getcwd()
  let file = expand('%:p:h')
  if stridx(file, pwd) >= 0
    silent! %s#\($\n\s*\)\+\%$## " trim endlines
    silent! %s/\s\+$//e " trim whitespace
    silent! g/^\_$\n\_^$/d " single blank line
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

augroup ChangeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup RunFile
  autocmd!
  autocmd FileType javascript vnoremap <leader>vf :w !node<cr>
  autocmd FileType python vnoremap <leader>vf :w !python<cr>
  autocmd FileType python nnoremap <leader>vf :!clear && python %<cr>
  autocmd FileType javascript nnoremap <leader>vf :!clear && node %<cr>
  autocmd FileType go nnoremap <leader>vf :!clear && gofmt -w % && go run %<cr>
augroup end

augroup LoadFile
  autocmd!
  autocmd VimResized * wincmd =
  autocmd FocusGained * redraw!

  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save late position cursor

  autocmd BufWritePre * call Trim()
  autocmd BufWritePre * call Mkdir()
  autocmd FileType netrw call NetrwSetting()
augroup end
