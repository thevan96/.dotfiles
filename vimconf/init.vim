" General setting
syntax on
set termguicolors
set hlsearch
set nobackup noswapfile
set splitbelow splitright
set number relativenumber
set nowrap
set autoindent
set mouse-=a
set tabstop=2 shiftwidth=2 expandtab
set showmode ruler
set encoding=utf-8
set updatetime=100 synmaxcol=200
set clipboard+=unnamedplus
set list listchars=tab:␣\ ,extends:▶,precedes:◀
set fillchars+=vert:\|
set signcolumn=yes:2
set conceallevel=0
set foldlevel=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set colorcolumn=80

" Set leader key
let mapleader = ' '

" Fast keymap
nnoremap <silent><leader><cr> <c-^>
nnoremap <silent><leader>q :q<cr>
nnoremap <silent><leader>w :w<cr>
nnoremap <silent><leader>Q :qa!<cr>
nnoremap <silent><leader>D :bd!<cr>

" Delete without yank
nmap <leader>dd "_dd
nmap <leader>x "_x

" Disable highlight search
nnoremap <silent><leader>l :nohlsearch<cr>

" Scaner command-line history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Change behavior mapping
nnoremap Y y$
vnoremap p "0P

" Fix missing block or select all
nnoremap gv `[v`]

" Better indent
nnoremap < <<
nnoremap > >>
xnoremap < <gv
xnoremap > >gv

" Build status line
set laststatus=2
set statusline=\ %f%m%r%=%l/%c/%L\ %P\ %{FugitiveStatusline()}\ %y |

if has("autocmd")
  " Save position cursor
  augroup saveposition
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
          \ | exe "normal! g'\"" | endif
  augroup end

  " Load file
  augroup loadfile
    autocmd FocusGained * :checktime
  augroup end

  " Toggle line number
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
  augroup end
endif

" Config format
function! QuickFormat()
  silent! wall
  let fullpath = expand('%:p')
  let listExtension = split(expand('%t'), '\.')
  let runner1 = "prettier" " List format tool
  let runner2 = "semistandard"
  let runner3 = "php-cs-fixer"
  let runner4 = "blade-formatter"
  let extension = listExtension[len(listExtension) - 1]
  if extension == "php"
    let isBlade = listExtension[len(listExtension) - 2]
    if isBlade =='blade'
      execute ":! ".runner1." --write ".fullpath." && "
            \ .runner4." --write ".fullpath
    else
      execute ":! ".runner1." --write ".fullpath." && "
            \ .runner3." fix --rules=@PSR2 ".fullpath." && rm .php_cs.cache"
    endif
  else
    execute ":! ".runner1." --write ".fullpath
  endif
  execute ":e!"
endfunction
nnoremap <silent><leader>p :call QuickFormat()<cr>

" Text object indent
onoremap <silent>ai :<C-U>cal <sid>IndTxtObj(0)<cr>
onoremap <silent>ii :<C-U>cal <sid>IndTxtObj(1)<cr>
vnoremap <silent>ai :<C-U>cal <sid>IndTxtObj(0)<cr><esc>gv
vnoremap <silent>ii :<C-U>cal <sid>IndTxtObj(1)<cr><esc>gv
function! s:IndTxtObj(inner)
  let curline = line(".")
  let lastline = line("$")
  let i = indent(line(".")) - &shiftwidth * (v:count1 - 1)
  let i = i < 0 ? 0 : i
  if getline(".") !~ "^\\s*$"
    let p = line(".") - 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p > 0 && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i
          \ &&  !(nextblank && a:inner)) || (nextblank && !a:inner))))
      -
      let p = line(".") - 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! 0V
    call cursor(curline, 0)
    let p = line(".") + 1
    let nextblank = getline(p) =~ "^\\s*$"
    while p <= lastline && ((i == 0 && !nextblank) || (i > 0 && ((indent(p) >= i
          \ && !(nextblank && a:inner)) || (nextblank && !a:inner))))
      +
      let p = line(".") + 1
      let nextblank = getline(p) =~ "^\\s*$"
    endwhile
    normal! $
  endif
endfunction

" Disable
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
nnoremap <F1> <nop>

call plug#begin()

" Text object
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Utils
Plug 'tpope/vim-sleuth'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'ntpeters/vim-better-whitespace'
Plug 'christoomey/vim-tmux-navigator'
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-fugitive'
Plug 'puremourning/vimspector'

Plug 'mhinz/vim-signify'
nmap <silent>gl <plug>(signify-next-hunk)
nmap <silent>gh <plug>(signify-prev-hunk)
let g:signify_sign_add = '+'
let g:signify_sign_delete = '-'
let g:signify_sign_change = '~'

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'

Plug 't9md/vim-choosewin'
let g:choosewin_overlay_enable = 0
let g:choosewin_blink_on_land = 0
nmap <leader>cc :ChooseWin<cr>
nmap <leader>cs :ChooseWinSwapStay<cr>

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 3

Plug 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf
nnoremap <silent><leader>i :Files<cr>
nnoremap <silent><leader>I :GFiles<cr>
nnoremap <silent><leader>o :Buffers<cr>
nnoremap <silent><leader>s :Rg<cr>
nnoremap <silent><leader>S :Rg <c-r><c-w><cr>
autocmd! FileType fzf set noshowmode noruler
      \| autocmd BufLeave <buffer> set showmode ruler

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions =
      \ [
      \ 'coc-styled-components',
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-python',
      \ 'coc-phpls',
      \ ]

" Remap keys for gotos, refresh
imap <silent><expr> <c-space> coc#refresh()
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gj <Plug>(coc-diagnostic-next)
nmap <silent>gk <Plug>(coc-diagnostic-prev

" Use K to show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
nnoremap <silent>K :call <SID>show_documentation()<cr>

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
Plug 'kristijanhusak/defx-git'
autocmd FileType defx set nobuflisted
autocmd BufWritePost * call defx#redraw()
autocmd FileType defx call s:defx_my_settings()
nnoremap <silent><leader>f :Defx -search=`expand('%:p')`
      \ -columns=space:indent:icon:mark:git:filename
      \ -show-ignored-files
      \ -resume -listed <cr>
nnoremap <silent><leader>F :Defx
      \ -columns=space:indent:icon:mark:git:filename
      \ -show-ignored-files
      \ -resume -listed <cr>

function! s:defx_my_settings() abort
  call defx#custom#column('icon', {
        \ 'directory_icon': '●',
        \ 'opened_icon': '○',
        \ })
  call defx#custom#column('filename', {
        \ 'min_width': 50,
        \ 'max_width': 50,
        \ })
  nnoremap <silent><buffer><expr> <cr>
        \ defx#do_action('open')
  nnoremap <silent><buffer><expr> u
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> o
        \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> dd
        \ defx#do_action('remove_trash')
  nnoremap <silent><buffer><expr> yy
        \ defx#do_action('copy')
  nnoremap <silent><buffer><expr> mv
        \ defx#do_action('move')
  nnoremap <silent><buffer><expr> p
        \ defx#do_action('paste')
  nnoremap <silent><buffer><expr> mk
        \ defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> t
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> T
        \ defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> rn
        \ defx#do_action('rename')
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> a
        \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> A
        \ defx#do_action('toggle_select_visual')
  nnoremap <silent><buffer><expr> cl
        \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> yp
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> i
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> R
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> <esc>
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> j 'j'
  nnoremap <silent><buffer><expr> k 'k'
endfunction

" Provider
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
let g:coc_node_path = expand('$HOME/.asdf/shims/node')
let g:node_host_prog = expand('$HOME/.asdf/shims/neovim-node-host')
call plug#end()

" Customize colorscheme
colorscheme default
set background=dark
highlight SignifySignAdd    guifg=#00ff00
highlight SignifySignDelete guifg=#ff0000
highlight SignifySignChange guifg=#ffff00
highlight comment           guifg=#346406
highlight Pmenu             guibg=#222222
highlight LineNr            guifg=#707070   guibg=NONE
highlight SignColumn        ctermbg=NONE    guibg=NONE
highlight Normal            ctermbg=NONE    guibg=NONE
highlight PmenuSel          guibg=#ffffff   guifg=#000000
highlight Visual            guibg=#ffffff   guifg=#000000
highlight StatusLine        guibg=#ffffff   guifg=#222222
highlight StatusLineNC      guibg=#707070   guifg=#222222
highlight VertSplit         guibg=#ffffff   guifg=#111111
highlight ColorColumn       guibg=#222222

" Treesitter config lua
lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = { enable = true },
  }
EOF

