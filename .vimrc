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

set number
set norelativenumber

set ruler
set laststatus=2
set signcolumn=yes

set textwidth=80
set colorcolumn=+1

set cursorline
set cursorlineopt=number

set wildmenu
set wildmode=longest,list
set completeopt=menu,menuone

" Other
set mouse=a
set showmatch
set autoindent
set backspace=0
set matchtime=1
set nofoldenable
set diffopt=vertical
set ttymouse=sgr
set clipboard=unnamed,unnamedplus
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
nnoremap <leader>y :%y<cr>
nnoremap <leader>n :set number!<cr>
nnoremap <leader>o :ls<cr>:b<space>
nnoremap <leader>f :call Trim()<cr>
nnoremap <silent><C-l> :noh<cr>:redraw!<cr>

command! Root execute 'cd ' fnameescape(g:root_cwd)
command! BufOnly execute '%bdelete|edit#|bdelete#'
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'

" Navigate wrap
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" File manager netrw
nnoremap <leader>E :JumpFile<cr>
nnoremap <leader>e :e `=g:root_cwd`<cr>

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
  nnoremap <leader><cr> :diffupdate<cr>
  vnoremap <leader>= :GremoveMarkers<cr><gv>
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
hi NormalFloat                    ctermfg=none     ctermbg=none     cterm=none
hi Pmenu                          ctermfg=15       ctermbg=236      cterm=none
hi PmenuSel                       ctermfg=0        ctermbg=39       cterm=none

hi LineNr                         ctermfg=240      ctermbg=none     cterm=none
hi LineNrAbove                    ctermfg=240      ctermbg=none     cterm=none
hi LineNrBelow                    ctermfg=240      ctermbg=none     cterm=none
hi CursorLine                     ctermfg=11       ctermbg=none     cterm=none
hi CursorLineNr                   ctermfg=11       ctermbg=none     cterm=none

hi ColorColumn                    ctermfg=none     ctermbg=233
hi SpecialKey                     ctermfg=236      ctermbg=none     cterm=none
hi Whitespace                     ctermfg=236      ctermbg=none     cterm=none

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

function! GRemoveMarkers() range
  " echom a:firstline.'-'.a:lastline
  execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction
command! -range=% GremoveMarkers <line1>,<line2>call GRemoveMarkers()

function! Trim()
  let pwd = getcwd()
  let file = expand('%:p:h')
  if stridx(file, pwd) >= 0
    silent! %s#\($\n\s*\)\+\%$## " trim end newlines
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

augroup ConfigStyleTabOrSpace
  autocmd!
  autocmd BufNewFile,BufRead,BufWrite *.go
        \ setlocal tabstop=2 shiftwidth=2 noexpandtab | retab
  autocmd BufNewFile,BufRead,Bufwrite *.md
        \ setlocal tabstop=2 shiftwidth=2 expandtab | retab
augroup end

augroup ChangeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup LoadFile
  autocmd!
  autocmd VimResized * wincmd =
  autocmd FocusGained * redraw!

  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif " save late position cursor

  autocmd BufWritePre * call Mkdir()
  autocmd FileType netrw call NetrwSetting()
augroup end
