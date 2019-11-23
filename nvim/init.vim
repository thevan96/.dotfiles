call plug#begin()
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
syntax on
set t_Co=256
set colorcolumn=80
set encoding=UTF-8
set ff=unix
filetype plugin on
filetype indent on
set number relativenumber
set autoread autowrite
set signcolumn=yes
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
set hidden
set incsearch hlsearch ignorecase smartcase
set clipboard +=unnamedplus
set nobackup noswapfile nowritebackup
set list listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:·
set splitbelow splitright
set autoindent smartindent
set mouse=a
set re=1
set updatetime=150
set lazyredraw
set nowrap
set synmaxcol=128
syntax sync minlines=256

set tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
autocmd FileType javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
autocmd FileType php        setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab shiftround
autocmd FileType md        setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab shiftround
autocmd BufEnter * :syntax sync fromstart

let mapleader = ' '
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
vnoremap <up> <nop>
vnoremap <down> <nop>
vnoremap <left> <nop>
vnoremap <right> <nop>
nnoremap j gj
nnoremap k gk
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>
nnoremap <c-h> <c-w><c-h>
nnoremap <esc><esc> :nohlsearch<cr>
nnoremap gj :bfirst<cr>
nnoremap gk :blast<cr>
nnoremap gs :new<cr>
nnoremap gv :vnew<cr>
nnoremap gh :bprevious<cr>
nnoremap gl :bnext<cr>
nnoremap gx :Bdelete<cr>
nnoremap jl :tabnext<cr>
nnoremap th :tabprevious<cr>
nnoremap tj :tabfirst<cr>
nnoremap tk :tablast<cr>
nnoremap tx :tabclose<cr>
nnoremap <leader>so :so ~/dotfiles/nvim/init.vim<cr>
nnoremap <leader>vi :e ~/dotfiles/nvim/init.vim<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>qq :q<cr>
nnoremap <leader>qa :qa<cr>
nnoremap <leader>y :registers<cr>
nnoremap <leader>Y :Cr<cr>
tnoremap <esc> <c-\><c-n>
tnoremap <c-h> <c-\><c-n><c-w>h
tnoremap <c-j> <c-\><c-n><c-k>j
tnoremap <c-k> <c-\><c-n><c-w>k
tnoremap <c-l> <c-\><c-n><c-w>l
nnoremap <c-a-k> :resize +2<cr>
nnoremap <c-a-j> :resize -2<cr>
nnoremap <c-a-l> :vertical resize +2<cr>
nnoremap <c-a-h> :vertical resize -2<cr>

"replace the word under cursor
nnoremap <leader>* :%s/\<<c-r><c-w>\>//g<left><left>

" Auto remove trailing spaces
autocmd BufWritePre * %s/\s\+$//e

" Clear register
command! Cr for i in range(34,122) | silent! call setreg(nr2char(i), []) | endfor

" Floating Term
let s:float_term_border_win = 0
let s:float_term_win = 0
function! FloatTerm(...)
  " Configuration
  let height = float2nr((&lines - 2) * 0.6)
  let row = float2nr((&lines - height) / 2)
  let width = float2nr(&columns * 0.6)
  let col = float2nr((&columns - width) / 2)
  " Border Window
  let border_opts = {
        \ 'relative': 'editor',
        \ 'row': row - 1,
        \ 'col': col - 2,
        \ 'width': width + 4,
        \ 'height': height + 2,
        \ 'style': 'minimal'
        \ }
  " Terminal Window
  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }
  let top = "╭" . repeat("─", width + 2) . "╮"
  let mid = "│" . repeat(" ", width + 2) . "│"
  let bot = "╰" . repeat("─", width + 2) . "╯"
  let lines = [top] + repeat([mid], height) + [bot]
  let bbuf = nvim_create_buf(v:false, v:true)
  call nvim_buf_set_lines(bbuf, 0, -1, v:true, lines)
  let s:float_term_border_win = nvim_open_win(bbuf, v:true, border_opts)
  let buf = nvim_create_buf(v:false, v:true)
  let s:float_term_win = nvim_open_win(buf, v:true, opts)
  " Styling
  call setwinvar(s:float_term_border_win, '&winhl', 'Normal:Normal')
  call setwinvar(s:float_term_win, '&winhl', 'Normal:Normal')
  if a:0 == 0
    terminal
  else
    call termopen(a:1)
  endif
  startinsert
  " Close border window when terminal window close
  autocmd TermClose * ++once :bd! | call nvim_win_close(s:float_term_border_win, v:true)
endfunction
nnoremap <leader>at :call FloatTerm()<cr>
nnoremap <leader>an :call FloatTerm('"node"')<cr>
nnoremap <leader>ag :call FloatTerm('"tig"')<cr>

function! QuickFormat()
  silent! wall
  let file_name = expand('%:t:r')
  let extension = expand('%:e')
  let runner1 ="prettier"
  if extension == "js"
    let runner2 ="semistandard"
    execute ":! ".runner1." --write ".file_name.".".extension." && ".runner2." --fix ".file_name.".".extension." | snazzy"
  elseif extension == "php"
    let runner2 ="php-cs-fixer"
    execute ":! ".runner1." --write ".file_name.".".extension." && ".runner2." fix --rules=@PSR2 ".file_name.".".extension." && rm .php_cs.cache"
  elseif extension == "html"
    execute ":! ".runner1." --write ".file_name.".".extension
  elseif extension == "css"
    execute ":! ".runner1." --write ".file_name.".".extension
  elseif extension == "scss"
    execute ":! ".runner1." --write ".file_name.".".extension
  elseif extension == "json"
    execute ":! ".runner1." --write ".file_name.".".extension
  elseif extension == "md"
    execute ":! ".runner1." --write ".file_name.".".extension
  elseif extension == "py"
    execute ":! ".runner1." --write ".file_name.".".extension
  else
    echoerr "File type not supported!"
  endif
  execute ":e!"
endfunction
nnoremap <leader>e :call QuickFormat()<cr>

" Setup colorscheme
Plug 'laggardkernel/vim-one'
set background=dark

Plug 'ryanoasis/vim-devicons'
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

Plug 'christoomey/vim-tmux-navigator'

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.\*', 'scp://.\*']

Plug 'jiangmiao/auto-pairs'

Plug 'Yggdroot/indentLine'
let g:indentLine_char_list = ['┊']

Plug 'andymass/vim-matchup'
let g:loaded_matchit = 1

Plug 'tpope/vim-repeat'
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)

Plug 'tpope/vim-surround'

Plug 'tpope/vim-commentary'

Plug 'sickill/vim-pasta'
let g:pasta_enabled_filetypes = ['ruby', 'javascript', 'php', 'vim', 'html', 'css', 'scss', 'sh']

Plug 'matze/vim-move'

Plug 'mattn/emmet-vim'
let g:user_emmet_leader_key=','

Plug 'mileszs/ack.vim'
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
cnoreabbrev Ack Ack!
nnoremap <Leader>a :Ack!<Space>

Plug 'moll/vim-bbye'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
nnoremap <leader>ggn :GitGutterNextHunk<CR>
nnoremap <leader>ggp :GitGutterPrevHunk<CR>

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'ctrlpvim/ctrlp.vim'
nmap <leader>p :CtrlPBuffer<cr>
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(git|hg|svn)$',
      \ 'file': '\v\.(exe|so|dll)$',
      \ 'link': 'some_bad_symbolic_links',
      \ }

Plug 't9md/vim-choosewin'
nmap <leader>cw :ChooseWin<cr>
nmap <leader>cs :ChooseWinSwap<cr>

Plug 'haya14busa/incsearch.vim'
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

Plug 'benmills/vimux'
map <leader>vp :VimuxPromptCommand<CR>
map <leader>vq :VimuxCloseRunner<CR>
let g:VimuxHeight = "20"

Plug 'pbrisbin/vim-mkdir'

Plug 'terryma/vim-multiple-cursors'
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<C-n>'
let g:multi_cursor_select_all_word_key = '<A-n>'
let g:multi_cursor_start_key           = 'g<C-n>'
let g:multi_cursor_select_all_key      = 'g<A-n>'
let g:multi_cursor_next_key            = '<C-n>'
let g:multi_cursor_prev_key            = '<C-p>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
nnoremap <leader>js :e ~/dotfiles/UltiSnips/javascript.snippets<cr>
nnoremap <leader>php :e ~/dotfiles/UltiSnips/php.snippets<cr>
nnoremap <leader>html :e ~/dotfiles/UltiSnips/html.snippets<cr>

Plug 'easymotion/vim-easymotion'
nmap s <Plug>(easymotion-overwin-f)
map <leader>l <Plug>(easymotion-bd-jk)

Plug 'neoclide/coc.nvim'
let g:coc_global_extensions =
      \ [
      \ 'coc-json',
      \ 'coc-tsserver',
      \ 'coc-css',
      \ 'coc-phpls',
      \ 'coc-python',
      \ 'coc-vimlsp'
      \ ]
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for gotos
nmap gd <Plug>(coc-definition)
nmap gy <Plug>(coc-type-definition)
nmap gi <Plug>(coc-implementation)
nmap gr <Plug>(coc-references)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

Plug 'mengelbrecht/lightline-bufferline'
Plug 'itchyny/lightline.vim'
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename', 'absolutepath'] ],
      \ },
      \ 'component_function': {
      \   'readonly': 'LightlineReadonly',
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename'
      \ }
      \ }

set showtabline=2
let g:lightline.tabline          = {'left': [['buffers']], 'right': [['close']]}
let g:lightline.component_expand = {'buffers': 'lightline#bufferline#buffers'}
let g:lightline.component_type   = {'buffers': 'tabsel'}

function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ''.branch : ''
  endif
  return ''
endfunction
function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction
function! LightlineModified()
  return &ft =~ 'help\|vimfiler' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineFilename()
  return ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_autoclose=0

Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'scrooloose/nerdtree'
let NERDTreeIgnore = ['^\.git$','^node_modules$',]
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1
let NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeWinSize=25
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeCascadeSingleChildDir = 0
let g:NERDTreeMapJumpNextSibling = '<Nop>'
let g:NERDTreeMapJumpPrevSibling = '<Nop>'
let NERDTreeChDirMode=2
set autochdir
highlight! link NERDTreeFlags NERDTreeDir
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
nnoremap tt :NERDTreeToggle<cr>
nnoremap rr :NERDTreeRefreshRoot<cr>
nnoremap <leader>fc :NERDTreeFocus<cr>
nnoremap <leader>ff :NERDTreeFind<cr>
let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "✹",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "✗",
      \ "Clean"     : "✔︎",
      \ 'Ignored'   : '☒',
      \ "Unknown"   : "?"
      \ }

" Syntax all language programe
Plug 'sheerun/vim-polyglot'

" Python
let g:loaded_python_provider = 0
let g:python3_host_prog = '~/.pyenv/shims/python3'

" Node
let g:node_host_prog='/home/thevan96/.nvm/versions/node/v10.16.3/bin/neovim-node-host'
let g:coc_node_path='/home/thevan96/.nvm/versions/node/v10.16.3/bin/node'

" Ruby
let g:ruby_host_prog ='~/.rbenv/versions/2.6.5/bin/neovim-ruby-host'

" PHP
Plug 'stephpy/vim-php-cs-fixer'
nnoremap <leader>pcd :call PhpCsFixerFixDirectory()<cr>
nnoremap <leader>pcf :call PhpCsFixerFixFile()<cr>
let g:php_cs_fixer_rules = "@PSR2"
let g:php_cs_fixer_php_path = "php"
let g:php_cs_fixer_path = "/usr/local/bin/php-cs-fixer"

"HTML, CSS
Plug 'lilydjwg/colorizer'
Plug 'othree/html5.vim'
Plug 'ap/vim-css-color'

" Javascript
Plug 'jelera/vim-javascript-syntax'
Plug 'thinca/vim-textobj-function-javascript'

" Markdown
Plug 'plasticboy/vim-markdown'
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_conceal_code_blocks = 0
call plug#end()

colorscheme one
