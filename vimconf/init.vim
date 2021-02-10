"--- General setting ---"
if exists('+termguicolors')
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

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

set autoindent
set shiftwidth=2
set expandtab
set shiftround

set wrap
set conceallevel=0
set backspace=indent,eol,start
set list listchars=tab:␣\ ,extends:▶,precedes:◀

set ttyfast
set mouse=a
set signcolumn=yes
set inccommand=nosplit
set completeopt-=preview

set updatetime=100
set colorcolumn=+1
set textwidth=79
set synmaxcol=320

" Set keymap
let mapleader = ' '

" Customizer mapping
map Y y$
vnoremap p "0P
nnoremap gV `[v`]
nnoremap S <C-^>
nnoremap <silent><leader>l :nohlsearch<cr>
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

" Mapping copy clipboard
nnoremap <leader>y "*yy
vnoremap <leader>y "*y
nnoremap <leader>Y "*yG

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

" Move line
nnoremap <A-n> :m .+1<cr>==
nnoremap <A-p> :m .-2<cr>==
inoremap <A-n> <esc>:m .+1<cr>==gi
inoremap <A-p> <esc>:m .-2<cr>==gi
vnoremap <A-n> :m '>+1<cr>gv=gv
vnoremap <A-p> :m '<-2<cr>gv=gv

" Disable
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Record repeat in visual mode width q
xnoremap Q :normal @q<cr>

" Dot repeat in visual mode
xnoremap . :normal .<cr>

" Customize status line
set statusline=\ %f%m%r\ %=%l/%c/%L\ %P\ %{FugitiveStatusline()}\ %y\ |

augroup loadFile
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$")
        \ | exe "normal! g'\"" | endif
  autocmd FileType qf wincmd J
  autocmd FocusGained * :checktime
augroup END

augroup changeWorkingDirectory
  autocmd InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  autocmd InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup END

" Config format
function! QuickFormat()
  silent! wall
  let fullpath = expand('%:p')
  let listExtension = split(expand('%t'), '\.')
  let prettier = "prettier"
  let phpcsfixer = "php-cs-fixer"
  let blade = "blade-formatter"
  let extension = listExtension[len(listExtension) - 1]
  if extension == "php"
    let isBlade = listExtension[len(listExtension) - 2]
    if isBlade =="blade"
      execute ":! ".prettier." --write --single-quote ".fullpath." && "
            \ .blade." --write ".fullpath
    else
      execute ":! ".prettier." --write --single-quote ".fullpath." && "
            \ .phpcsfixer." fix --rules=@PSR2 ".fullpath." && rm .php_cs.cache"
    endif
  else
    execute ":! ".prettier." --write --single-quote ".fullpath
  endif
endfunction
nnoremap <silent><leader>p :call QuickFormat()<cr>

call plug#begin()

"--- Navigate explore ---"
Plug 'preservim/nerdtree'
Plug 'PhilRunninger/nerdtree-visual-selection'
let NERDTreeWinPos = "right"
let NERDTreeWinSize = 35
let NERDTreeMinimalUI = 1
let NERDTreeShowHidden = 1
let NERDTreeQuitOnOpen =  0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeCascadeSingleChildDir = 0
nnoremap <silent><leader>f :NERDTreeRefreshRoot<cr>:NERDTreeFocus<cr>
nnoremap <silent><leader>F :NERDTreeRefreshRoot<cr>:NERDTreeFind<cr>

"--- Autocomplete ---"
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" let g:coc_global_extensions = [
"       \ 'coc-css',
"       \ 'coc-json',
"       \ 'coc-html',
"       \ 'coc-phpls',
"       \ 'coc-pyright',
"       \ 'coc-tsserver',
"       \ 'coc-snippets',
"       \ 'coc-cssmodules',
"       \ 'coc-html-css-support',
"       \ ]

" " Make <CR> auto-select the first completion item and notify coc.nvim to
" " format on enter, <cr> could be remapped by other vim plugin
" inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
"       \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" " Use <c-space> to trigger completion.
" imap <silent><expr> <c-space> coc#refresh()

" " Remap keys for gotos, refresh
" nmap <silent>gk <Plug>(coc-diagnostic-prev)
" nmap <silent>gj <Plug>(coc-diagnostic-next)
" nmap <silent>gd <Plug>(coc-definition)
" nmap <silent>gr <Plug>(coc-references)

" " Coc search.
" nnoremap <leader>/ :CocSearch<space>

" " Symbol renaming.
" nmap <leader>C <Plug>(coc-rename)

" " Use K to show documentation in preview window
" nnoremap <silent>K :call <SID>show_documentation()<cr>
" function! s:show_documentation()
"   if (index(['vim','help'], &filetype) >= 0)
"     execute 'h '.expand('<cword>')
"   elseif (coc#rpc#ready())
"     call CocActionAsync('doHover')
"   else
"     execute '!' . &keywordprg . " " . expand('<cword>')
"   endif
" endfunction

"--- Git ---"
Plug 'tpope/vim-fugitive'
nnoremap <silent><leader>G :Git<cr>
nnoremap <silent><leader>gcc :Git commit<cr>
nnoremap <silent><leader>gca :Git commit --amend<cr>
nnoremap <silent><leader>gpp :Git push<cr>
nnoremap <silent><leader>gpf :Git push --force<cr>
nnoremap <silent><leader>gd :Gdiffsplit<cr>
nnoremap <silent><leader>gb :Git blame<cr>

"--- Debug ---"
Plug 'puremourning/vimspector'
let g:vimspector_install_gadgets = []

"--- Snippet ---"
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

"--- Theme ---"
Plug 'nanotech/jellybeans.vim'

"--- Other utils ---"
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'michaeljsmith/vim-indent-object'

Plug 'pechorin/any-jump.vim'
let g:any_jump_disable_default_keybindings = 1
nnoremap <silent>gd :AnyJump<cr>
xnoremap <silent>gd :AnyJumpVisual<cr>

Plug 'pseewald/vim-anyfold'
autocmd Filetype * AnyFoldActivate

Plug 'szw/vim-maximizer'
let g:maximizer_set_default_mapping = 0
nnoremap <silent><leader>z :MaximizerToggle<cr>

Plug 'machakann/vim-swap'
omap is <Plug>(swap-textobject-i)
xmap is <Plug>(swap-textobject-i)
omap as <Plug>(swap-textobject-a)
xmap as <Plug>(swap-textobject-a)

Plug 'voldikss/vim-floaterm'
let g:floaterm_width = 0.8
let g:floaterm_height = 0.7
nnoremap <silent><C-t><C-c> :FloatermNew<cr>
tnoremap <silent><C-t><C-c> <C-\><C-n>:FloatermNew<cr>
tnoremap <silent><C-t><C-t> <C-\><C-n>:FloatermToggle<cr>
nnoremap <silent><C-t><C-t> :FloatermToggle<cr>
tnoremap <silent><C-t><C-d> <C-\><C-n>:FloatermKill<cr>
nnoremap <silent><C-t><C-d> :FloatermKill<cr>
nnoremap <silent><C-h> :FloatermPrev<cr>
tnoremap <silent><C-h> <C-\><C-n>:FloatermPrev<cr>
nnoremap <silent><C-l> :FloatermNext<cr>
tnoremap <silent><C-l> <C-\><C-n>:FloatermNext<cr>
autocmd filetype javascript nnoremap <C-t><C-r> :FloatermNew  --autoclose=0 node %<cr>
autocmd filetype python nnoremap <C-t><C-r> :FloatermNew  --autoclose=0 python %<cr>
autocmd filetype c nnoremap <C-t><C-r> :FloatermNew  --autoclose=0 gcc % -o %< && ./%<<cr>
autocmd filetype cpp nnoremap <C-t><C-r> :FloatermNew  --autoclose=0 g++ % -o %< && ./%<<cr>

Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['markdown', 'php']

Plug 'vimwiki/vimwiki'
let g:vimwiki_auto_header = 1
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_list = [
      \ {
      \   'path': '~/workspace/notes',
      \   'syntax': 'markdown', 'ext': '.md',
      \   'links_space_char': '-',
      \ }]

let g:vimwiki_key_mappings =
      \ {
      \   'all_maps': 1,
      \   'global': 1,
      \   'headers': 1,
      \   'text_objs': 1,
      \   'table_format': 1,
      \   'table_mappings': 1,
      \   'lists': 1,
      \   'links': 1,
      \   'html': 0,
      \   'mouse': 0,
      \ }

Plug 'AndrewRadev/tagalong.vim'
let g:tagalong_filetypes = ['xml', 'html', 'php', 'javascript']

Plug 'simeji/winresizer'
let g:winresizer_start_key = "<leader>w"
let g:winresizer_vert_resize = 3
let g:winresizer_horiz_resize = 3

Plug 'editorconfig/editorconfig-vim'
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

Plug 'junegunn/fzf.vim'
set rtp+=/usr/local/opt/fzf
nnoremap <silent><leader>i :Files<cr>
nnoremap <silent><leader>o :Buffers<cr>
nnoremap <silent><leader>r :Rg<cr>
nnoremap <silent><leader>R :Rg <c-r><c-w><cr>
autocmd! FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

"--- Provider ---"
let g:loaded_perl_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')
let g:loaded_node_provider = 0
call plug#end()

"--- Customize theme ---"
set background=dark
colorscheme jellybeans
hi LineNr       guibg=NONE
hi ColorColumn  guibg=#222222
hi CursorLineNr guibg=NONE     guifg=NONE
hi SignColumn   guifg=NONE     guibg=NONE
hi Normal       guifg=NONE     guibg=NONE
hi NormalFloat  guifg=NONE     guibg=#222222
hi NonText      guifg=NONE     guibg=NONE
hi VertSplit    guifg=NONE     guibg=NONE
hi CocUnderline cterm=underline

