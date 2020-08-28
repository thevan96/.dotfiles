" General setting
syntax on
set nocompatible
set fillchars+=vert:\|
set mouse=a
set termguicolors
set hlsearch
set nobackup noswapfile
set splitbelow splitright
set autoindent
set hidden number nowrap
set lazyredraw
set cmdheight=1
set updatetime=100
set signcolumn=yes:2
set encoding=utf-8
set clipboard=unnamed
set lazyredraw
set list listchars=tab:␣\ ,extends:▶,precedes:◀
set conceallevel=2
set foldlevel=99
set shortmess+=c

" Setting default tab/space
set tabstop=2 shiftwidth=2 expandtab

" Sync file another open
autocmd FocusGained * :checktime

" Save position cursor
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif
endif

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Mapping leader
let mapleader = ' '

" Fast mapping
map S <c-^>
nnoremap <leader>q :q<cr>
nnoremap <leader>Q :qa!<cr>

" Remap
map * *N
vnoremap p "0P
nnoremap < <<
nnoremap > >>

"Find and replace
map <leader>r :%s///<left><left>

" Fix missing visual block
nnoremap gv `[v`]
xnoremap < <gv
xnoremap > >gv
xnoremap < <gv
xnoremap > >gv

" Disable highlight search, clear
nnoremap <silent><esc> :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Scaner command-line history
cnoremap <c-n> <down>
cnoremap <c-p> <up>

" Disable
nnoremap Q <nop>
nnoremap <F1> <nop>

" Split window
nnoremap <silent>sv :vsplit<cr>
nnoremap <silent>ss :split<cr>

" Format
function! QuickFormat()
  silent! wall
  let fullpath = expand('%:p')
  let listExtension = split(expand('%t'), '\.')
  let prettier = "prettier"
  let semistandard = "semistandard"
  let phpCsFixer = "php-cs-fixer"
  let bladeFormat = "blade-formatter"
  let extension = listExtension[len(listExtension) - 1]
  if extension == "js"
    execute ":! ".prettier." --write ".fullpath ." && "
          \ .runner2." --fix ".fullpath." | snazzy"
  elseif extension == "ts"
    execute ":! ".prettier." --write ".fullpath
  elseif extension == "php"
    let isBlade = listExtension[len(listExtension) - 2]
    if isBlade =='blade'
      execute ":! ".prettier." --write ".fullpath." && "
            \ .bladeFormat." --write ".fullpath
    else
      execute ":! ".prettier." --write ".fullpath." && "
            \ .phpCsFixer." fix --rules=@PSR2 ".fullpath." && rm .php_cs.cache"
    endif
  else
    execute ":! ".prettier." --write ".fullpath
  endif
  execute ":e!"
endfunction
" nnoremap <leader>p :call QuickFormat()<cr>

call plug#begin()
Plug 'christoomey/vim-tmux-navigator'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-fugitive'

Plug 't9md/vim-choosewin'
let g:choosewin_overlay_enable = 1
let g:choosewin_statusline_replace = 0
nnoremap <silent><leader>cc :ChooseWin<cr>
nnoremap <silent><leader>cs :ChooseWinSwapStay<cr>

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','
let g:user_emmet_mode='i'

Plug 'liuchengxu/vista.vim'
nnoremap <silent><leader>v :Vista coc<cr>
nnoremap <silent><leader>V :Vista!!<cr>
let g:vista_sidebar_width = 40

Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [
      \ {'path': '~/thevan96/Dropbox/4-Note/', 'syntax': 'markdown', 'ext': '.md'}
      \ ]

Plug 'pseewald/vim-anyfold'
autocmd Filetype * AnyFoldActivate

Plug 'Galooshi/vim-import-js'
nnoremap <leader>J :ImportJSFix<cr>

Plug 'puremourning/vimspector'
let g:vimspector_enable_mappings = 'HUMAN'

Plug 'Valloric/MatchTagAlways'
Plug 'AndrewRadev/tagalong.vim'
let g:tagalong_filetypes = [
      \ 'javascript', 'html',
      \ 'xml', 'jsx',
      \ 'eruby', 'php',
      \ 'javascriptreact',
      \ 'typescriptreact']

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

Plug 'simeji/winresizer'
let g:winresizer_start_key = '<leader>e'
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 3

Plug 'tpope/vim-repeat'
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

Plug 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf
let g:fzf_action = {
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit'
      \ }
nnoremap <silent><leader>i :Files<cr>
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, {'options': ['--layout=reverse']}, <bang>0)

nnoremap <silent><leader>o :Buffers<cr>
command! -bang -nargs=? -complete=dir Buffers
      \ call fzf#vim#buffers({'options': ['--layout=reverse']}, <bang>0)

nnoremap <silent><leader>S :Rg <c-r><c-w><cr>
nnoremap <silent><leader>s :Rg<cr>
command! -bang -nargs=* Rg
      \ call fzf#vim#grep(
      \ 'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>),
      \ 1,
      \ fzf#vim#with_preview({'options': ['--layout=reverse']}), <bang>0)

tnoremap <expr> <esc> (&filetype == "fzf") ? "<esc>" : "<c-\><c-n>"
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

Plug 'neoclide/coc.nvim', {'branch': 'release'}
let g:diagnostic_insert_delay = 1
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
imap <silent><expr> <c-n> coc#refresh()
nmap <silent>gd <Plug>(coc-definition)
nmap <silent>gt <Plug>(coc-type-definition)
nmap <silent>gi <Plug>(coc-implementation)
nmap <silent>gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent>K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Navigate error
map <silent>gl <Plug>(coc-diagnostic-next)
map <silent>gk <Plug>(coc-diagnostic-prev

Plug 'airblade/vim-gitgutter'
nmap gj <Plug>(GitGutterNextHunk)
nmap gk <Plug>(GitGutterPrevHunk)

Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins'  }
Plug 'kristijanhusak/defx-git'
let g:defx_icons_enable_syntax_highlight = 1
autocmd BufWritePost * call defx#redraw()
autocmd FileType defx call s:defx_my_settings()

nnoremap <silent><leader>f :Defx -search=`expand('%:p')`
      \ -split=vertical -winwidth=40 -direction=topleft
      \ -columns=indent:icon:mark:git:filename
      \ -show-ignored-files -listed
      \ -resume -listed <cr>
nnoremap <silent><leader>F :Defx
      \ -split=vertical -winwidth=40 -direction=topleft
      \ -columns=indent:icon:mark:git:filename
      \ -show-ignored-files -listed
      \ -toggle -resume -listed <cr>

function! s:defx_my_settings() abort
  call defx#custom#column('icon', {
        \ 'directory_icon': ' ▸',
        \ 'opened_icon': ' ▾',
        \ 'root_icon': 'R',
        \ })
  call defx#custom#column('mark', {
        \ 'readonly_icon': '✗',
        \ 'selected_icon': '✓',
        \ })
  call defx#custom#column('filename', {
        \ 'min_width': 30,
        \ 'max_width': 50,
        \})
  nnoremap <silent><buffer><expr> <cr>
        \ defx#do_action('drop')
  nnoremap <silent><buffer><expr> u
        \ defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> o
        \ defx#do_action('open_or_close_tree')
  nnoremap <silent><buffer><expr> ss
        \ defx#do_action('drop','split')
  nnoremap <silent><buffer><expr> sv
        \ defx#do_action('drop', 'vsplit')
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
  nnoremap <silent><buffer><expr> .
        \ defx#do_action('toggle_select')
  nnoremap <silent><buffer><expr> *
        \ defx#do_action('toggle_select_all')
  nnoremap <silent><buffer><expr> a
        \ defx#do_action('toggle_select_visual')
  nnoremap <silent><buffer><expr> cl
        \ defx#do_action('clear_select_all')
  nnoremap <silent><buffer><expr> j 'j'
  nnoremap <silent><buffer><expr> k 'k'
  nnoremap <silent><buffer><expr> yp
        \ defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> i
        \ defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> cd
        \ defx#do_action('change_vim_cwd')
  nnoremap <silent><buffer><expr> rr
        \ defx#do_action('redraw')
endfunction

Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }

Plug 'jelera/vim-javascript-syntax'
Plug 'maxmellon/vim-jsx-pretty'
let g:vim_jsx_pretty_highlight_close_tag = 1


function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release --locked
    else
      !cargo build --release --locked --no-default-features --features json-rpc
    endif
  endif
endfunction
Plug 'tpope/vim-markdown'
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }
let g:markdown_composer_autostart = 0

Plug 'elzr/vim-json'
let g:vim_json_syntax_conceal = 0

" Provider
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:vimtex_compiler_progname = 'nvr'
let g:python_host_prog = expand('$HOME/.asdf/shims/python2')
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
let g:coc_node_path =  expand('$HOME/.asdf/shims/node')
let g:node_host_prog = expand('$HOME/.asdf/shims/neovim-node-host')

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_theme = 'solarized'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-line'
Plug 'sgur/vim-textobj-parameter'
Plug 'whatyouhide/vim-textobj-xmlattr'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-entire'
let g:vim_textobj_parameter_mapping = 's'

Plug 'lifepillar/vim-solarized8'
let g:solarized_termtrans = 1
set background=dark

call plug#end()

colorscheme solarized8
highlight Normal      ctermbg=NONE guibg=NONE
highlight LineNr      ctermbg=NONE guibg=NONE
highlight SignColumn  ctermbg=NONE guibg=NONE
highlight VertSplit   guibg=NONE guifg=NONE
highlight Cursor      guibg=#839496
