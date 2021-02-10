"--- General setting ---"
syntax on
set encoding=utf-8

set nobackup
set noswapfile

set splitbelow
set splitright

set hlsearch

set ruler
set number
set hidden
set scrolloff=3
set laststatus=2
set foldlevel=99

set tabstop=2
set shiftwidth=2
set expandtab
set shiftround
set autoindent

set wrap
set conceallevel=0
" set backspace=indent,eol,start
set list listchars=tab:␣\ ,extends:▶,precedes:◀

set mouse=a
set signcolumn=yes
set completeopt-=preview
set clipboard=unnamed

set updatetime=100
set synmaxcol=320

" Set keymap
let mapleader = ' '

" Customizer mapping
map Y y$
nnoremap j gj
nnoremap k gk
vnoremap p "0P
nnoremap S <C-^>
nnoremap gV `[v`]
nnoremap <silent><leader>l :nohlsearch<cr>

" Better indent
nnoremap < <<
nnoremap > >>
xnoremap < <gv
xnoremap > >gv
xnoremap < <gv
xnoremap > >gv

" Navigate quickfix
nnoremap <silent>gp :cp<cr>
nnoremap <silent>gn :cn<cr>
nnoremap <silent>go :copen<cr>
nnoremap <silent>gx :cclose<cr>

" Disable
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Record repeat in visual mode
vnoremap Q :normal @q<cr>

" Dot repeat in visual mode
vnoremap . :normal .<cr>

" Customize status line
set statusline=\ %f%m%r\ %=%l/%c/%L\ %P\ %y\ |

augroup loadFile
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif
  autocmd FileType qf wincmd J
  autocmd FocusGained * :checktime
augroup END

augroup workingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup END

"--- Customize theme ---"
set background=dark
hi StatusLine               guibg=#000000
hi StatusLineNC             guifg=#808088
hi PmenuSel                 guifg=#000000
hi Pmenu                    guibg=#303030 guifg=NONE
hi SignColumn               guifg=NONE    guibg=NONE
hi Normal                   guifg=NONE    guibg=NONE
hi NonText                  guifg=NONE    guibg=NONE
hi clear SignColumn

