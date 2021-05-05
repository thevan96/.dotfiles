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
set backspace=2
set list listchars=tab:␣\ ,extends:▶,precedes:◀

set paste
set mouse=a
set signcolumn=yes
set completeopt-=preview
syntax sync minlines=256

set updatetime=100
set colorcolumn=+1
set textwidth=79
set synmaxcol=320

set ttyfast
set nocursorline
set lazyredraw

" Set keymap
let mapleader = ' '

" Customizer mapping
vnoremap p "0P
nnoremap gV `[v`]
nnoremap <tab> <C-^>
nnoremap <silent><leader>l :nohlsearch<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Mapping copy clipboard
nnoremap <leader>y "*y
vnoremap <leader>y "*y

" Better indent
nnoremap < <<
nnoremap > >>
xnoremap < <gv
xnoremap > >gv

" Disable
" let g:loaded_netrw = 1
" let g:loaded_netrwPlugin = 1

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
colorscheme peachpuff
hi StatusLine               guibg=#000000
hi StatusLineNC             guifg=#808088
hi PmenuSel                 guifg=#000000
hi Pmenu                    guibg=#303030 guifg=NONE
hi SignColumn               guifg=NONE    guibg=NONE
hi Normal                   guifg=NONE    guibg=NONE
hi NonText                  guifg=NONE    guibg=NONE
hi VertSplit                guifg=NONE    guibg=NONE
hi clear SignColumn

