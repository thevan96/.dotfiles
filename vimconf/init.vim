"--- General setting ---"
syntax on
set encoding=utf-8
set termguicolors
set nobackup
set noswapfile
set splitbelow
set splitright

set hlsearch
set incsearch

set ruler
set number
set hidden
set scrolloff=3
set laststatus=2

set foldlevel=99
set foldmethod=indent

set wrap
set conceallevel=0
set backspace=2
set tabstop=2 shiftwidth=2 expandtab | retab
set list listchars=tab:␣\ ,extends:▶,precedes:◀
set fillchars=stl:-,stlnc:-

set mouse=a
set signcolumn=yes:2
set completeopt-=preview

set updatetime=100
set colorcolumn=+1
set textwidth=79
set synmaxcol=320

set ttyfast
set nocursorline
set lazyredraw

set diffopt+=vertical
set diffopt+=iwhite
set diffopt+=vertical
nnoremap <leader>2 :diffget //2<cr>:diffupdate<cr>
nnoremap <leader>3 :diffget //3<cr>:diffupdate<cr>

" Set keymap
let mapleader = ' '

" Customizer mapping
vnoremap p "0P
nnoremap gV `[v`]
nnoremap <tab> <C-^>
nnoremap <silent><leader>d :bd<cr>
nnoremap <silent><leader>l :nohlsearch<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Mapping copy clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y :%y+<cr>

" Better indent
nnoremap < <<
nnoremap > >>
xnoremap < <gv
xnoremap > >gv

" Navigation split
nnoremap <A-j> <C-w><C-j>
nnoremap <A-k> <C-w><C-k>
nnoremap <A-l> <C-w><C-l>
nnoremap <A-h> <C-w><C-h>
nnoremap <A-i> <C-w><C-v>
nnoremap <A-m> <C-w><C-s>

" Move line
nnoremap <silent><A-n> :m .+1<cr>==
nnoremap <silent><A-p> :m .-2<cr>==
vnoremap <silent><A-n> :m '>+1<cr>gv=gv
vnoremap <silent><A-p> :m '<-2<cr>gv=gv

" Navigate quickfix
nnoremap <silent>gp :cp<cr>
nnoremap <silent>gn :cn<cr>
nnoremap <silent>go :copen<cr>
nnoremap <silent>gx :cclose<cr>

" Disable
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Record repeat in visual mode width q
xnoremap Q :normal @q<cr>

" Dot repeat in visual mode
xnoremap . :normal .<cr>

" Customize status line
set statusline=\ %f%m%r\ %=\ %y%{FugitiveStatusline()}\ |

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>R :call RenameFile()<cr>

if filereadable('config/routes.rb')
  " This looks like a Rails app, add Rails specific mappings here.
  nnoremap <silent><leader>c :Files app/controllers<cr>
  nnoremap <silent><leader>m :Files app/models<cr>
  nnoremap <silent><leader>v :Files app/views<cr>
  nnoremap <silent><leader>t :Files app/test<cr>
elseif filereadable('src/index.js')
  " This looks like a React app, add React specific mappings here.
endif

augroup loadFile
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif
  autocmd FileType qf wincmd J
  autocmd FocusGained * :checktime
  autocmd VimResized * wincmd =
augroup END

augroup changeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup END

augroup executeCode
  autocmd FileType c nnoremap <leader>e
        \ :sp<cr>:term gcc % -o %< && ./%<<cr> :startinsert<cr>
  autocmd FileType cpp nnoremap <leader>e
        \ :sp<cr>:term g++ -std=c++17 % -o %< && ./%<<cr> :startinsert<cr>
  autocmd FileType python nnoremap <leader>e
        \ :sp<cr>:term python %<cr> :startinsert<cr>
  autocmd FileType javascript nnoremap <leader>e
        \ :sp<cr>:term node %<cr> :startinsert<cr>
  autocmd FileType ruby nnoremap <leader>e
        \ :sp<cr>:term ruby %<cr> :startinsert<cr>
augroup END

" Config format
function! QuickFormat()
  silent! wall
  let fullpath = expand('%:p')
  let listExtension = split(expand('%t'), '\.')
  let extension = listExtension[len(listExtension) - 1]
  if extension == "rb"
    if filereadable("Gemfile")
      execute ":!bundle exec rubocop -a %"
    else
      execute ":!rubocop -a %"
    endif
  elseif extension == "erb"
    execute ":!htmlbeautifier %"
  else
    execute ":!prettier --write %"
  endif
endfunction
nnoremap <silent><leader>p :call QuickFormat()<cr>

call plug#begin()

"--- Navigate explore ---"
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
augroup defxConfig
  autocmd FileType defx set nobuflisted
  autocmd BufWritePost * call defx#redraw()
  autocmd FileType defx call s:defx_my_settings()
augroup end
nnoremap <silent><leader>f :Defx
      \ -split=vertical -winwidth=35 -direction=topleft
      \ -columns=indent:icon:mark:filename
      \ -show-ignored-files
      \ -resume -listed<cr><C-w>=
nnoremap <silent><leader>F :Defx -search=`expand('%:p')`
      \ -split=vertical -winwidth=35 -direction=topleft
      \ -columns=indent:icon:mark:filename
      \ -show-ignored-files
      \ -resume -listed<cr><C-w>=
function! s:defx_my_settings() abort
  call defx#custom#column('icon', {
        \ 'directory_icon': '▷',
        \ 'opened_icon': '▼',
        \ })
  call defx#custom#column('filename', {
        \ 'min_width': 50,
        \ 'max_width': 50,
        \ })
  nnoremap <silent><buffer><expr> <cr>
        \ defx#is_binary() ?
        \ defx#do_action('execute_system') :
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> ss
        \ defx#do_action('drop', 'split')
  nnoremap <silent><buffer><expr> sv
        \ defx#do_action('drop', 'vsplit')
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
  nnoremap <silent><buffer><expr> f
        \ defx#do_action('new_file')
  nnoremap <silent><buffer><expr> F
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
  nnoremap <silent><buffer><expr> q
        \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> rr
        \ defx#do_action('redraw')
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('repeat')
  nnoremap <silent><buffer><expr> P defx#do_action('search',
        \ fnamemodify(defx#get_candidate().action__path, ':h'))
  nnoremap <silent><buffer><expr> j 'j'
  nnoremap <silent><buffer><expr> k 'k'
endfunction

"--- Autocomplete ---"
Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-json',
      \ 'coc-html',
      \ 'coc-phpls',
      \ 'coc-clangd',
      \ 'coc-pyright',
      \ 'coc-tsserver',
      \ 'coc-snippets',
      \ 'coc-cssmodules',
      \ 'coc-solargraph',
      \ 'coc-html-css-support',
      \ ]

" Submit select
inoremap <silent> <CR> <C-r>=<SID>coc_confirm()<CR>
function! s:coc_confirm() abort
  if pumvisible()
    return coc#_select_confirm()
  else
    return "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
  endif
endfunction

" Use <c-space> to trigger completion.
imap <silent><expr> <c-space> coc#refresh()

" Remap <C-u> and <C-d> for scroll float windows/popups.
nnoremap <silent><nowait><expr>
      \ <C-d> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
nnoremap <silent><nowait><expr><C-u>
      \ coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"
inoremap <silent><nowait><expr><C-d>
      \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr><C-u>
      \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr><C-d>
      \ coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-d>"
vnoremap <silent><nowait><expr><C-u>
      \ coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-u>"

" Remap keys for gotos, refresh
nmap <silent>gk <Plug>(coc-diagnostic-prev)
nmap <silent>gj <Plug>(coc-diagnostic-next)
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gr <Plug>(coc-references)
nmap <silent>gJ <Plug>(coc-float-jump)
nmap <silent>gH <Plug>(coc-float-hide)

" Symbol renaming.
nmap <leader>r <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent>K :call <SID>show_documentation()<cr>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

"--- Git ---"
Plug 'tpope/vim-fugitive'
nnoremap <silent><leader>gs :Git<cr>
nnoremap <silent><leader>gc :Git commit<cr>
nnoremap <silent><leader>gC :Git commit --amend<cr>
nnoremap <silent><leader>gp :Git push<cr>
nnoremap <silent><leader>gP :Git push -f<cr>
nnoremap <silent><leader>gf :Git fetch<cr>
nnoremap <silent><leader>gd :Gdiffsplit<cr>
nnoremap <silent><leader>gD :Gdiffsplit!<cr>
nnoremap <silent><leader>gb :Git blame<cr>

"--- Snippet ---"
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"--- Text object ---"
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

Plug 'machakann/vim-swap'
omap is <Plug>(swap-textobject-i)
xmap is <Plug>(swap-textobject-i)
omap as <Plug>(swap-textobject-a)
xmap as <Plug>(swap-textobject-a)

"--- Other utils ---"
Plug 'tpope/vim-rails'
Plug 'mattn/emmet-vim'
Plug 'ayu-theme/ayu-vim'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-endwise'
Plug 'wakatime/vim-wakatime'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'vim-test/vim-test'
nmap <silent>tt :TestNearest<CR>
nmap <silent>tf :TestFile<CR>
nmap <silent>ts :TestSuite<CR>
nmap <silent>tl :TestLast<CR>
nmap <silent>tv :TestVisit<CR>

Plug 'simeji/winresizer'
let g:winresizer_vert_resize = 5
let g:winresizer_horiz_resize = 3

Plug 'stefandtw/quickfix-reflector.vim'
if executable('rg')
  set grepprg=rg\ --vimgrep\ --hidden\
        \ --glob\ '!.git'\
        \ --glob\ '!.idea'\
        \ --glob\ '!.vscode'\
        \ --glob\ '!node_modules'\
        \ --glob\ '!vendor'\
        \ --glob\ '!composer'
endif

Plug 'ntpeters/vim-better-whitespace'
nnoremap <silent><leader>T :StripWhitespace<cr>
let g:better_whitespace_filetypes_blacklist =
      \ ['diff', 'gitcommit', 'qf', 'help']

Plug 'AndrewRadev/tagalong.vim'
let g:tagalong_filetypes = ['xml', 'html', 'php', 'javascript', 'eruby']

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

Plug 'junegunn/fzf.vim'
set rtp+=~/.fzf
nnoremap <silent><leader>i :Files<cr>
nnoremap <silent><leader>b :Buffers<cr>
nnoremap <silent><leader>s :Rg<cr>
nnoremap <silent><leader>S :Rg <c-r><c-w><cr>
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

"--- Provider ---"
let g:loaded_perl_provider = 0
let g:loaded_python_provider = 0
let g:ruby_host_prog = expand('/home/thevan96/.asdf/shims/ruby')
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
let g:loaded_node_provider = 0
call plug#end()

"--- Customize theme ---"
colorscheme ayu
let ayucolor="mirage"
set background=dark
hi LineNr            guibg=NONE
hi CursorLineNr      guibg=NONE    guifg=NONE
hi SignColumn        guifg=NONE    guibg=NONE
hi Normal            guifg=NONE    guibg=NONE
hi NonText           guifg=NONE    guibg=NONE
hi VertSplit         guifg=NONE    guibg=NONE gui=NONE
hi CocUnderline      cterm=underline
hi StatusLine        guifg=white guibg=NONE gui=bold
hi StatusLineNC      guifg=white guibg=NONE gui=NONE

lua <<EOF
  require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    highlight = { enable = true },
  }
EOF

