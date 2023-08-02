"--- General setting ---
set nobackup
set noswapfile
set encoding=utf-8
set autoread
set autowrite
set ignorecase
set list
set listchars=tab:→\ ,lead:.,trail:\ |
set signcolumn=no
set textwidth=80
set colorcolumn=+1
set cursorline
set cursorlineopt=number
set wildmode=longest,list
set completeopt=menu,menuone
set mouse=
set showmatch
set backspace=0
set matchtime=0
set nofoldenable
set statusline=%<%f\ %h%m%r%{GitBranch()}%=%y%-14.([%l/%L],%c%V%)%P

" Netrw
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab

" Set keymap
let mapleader = ' '

" Customizer mapping
xnoremap p pgvy
nnoremap gp `[v`]
nnoremap <C-l> :noh<cr>
inoremap <C-l> <C-o>:noh<cr>
nnoremap <leader>h yypVr=
nnoremap <leader>x :bd<cr>
nnoremap <leader>C :set invspell<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:p:h').'/' : '%%'
inoremap <C-n> <nop>
inoremap <C-p> <nop>

" Virtual edit
nnoremap <leader>va :set virtualedit=all nolist<cr>
nnoremap <leader>vn :set virtualedit=none list<cr>

" Better relative number
nnoremap <silent><leader>n m':set relativenumber!<cr>
vnoremap <silent><leader>n <esc>m':set relativenumber!<cr>V
xnoremap <silent><leader>n <esc>m':set relativenumber!<cr>gv
nnoremap <silent><leader>N :set invnumber<cr>
vnoremap <silent><leader>N <esc>:set invnumber<cr>V
xnoremap <silent><leader>N <esc>:set invnumber<cr>gv

" Buffer only
command! BufOnly exe '%bdelete|edit#|bdelete#'

" Current path to clipboard
command! CopyPath let @+ = expand('%')

" Navigate wrap
nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')

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

" Mapping copy clipboard and past
nnoremap <leader>y "+yy
vnoremap <leader>y "+y
nnoremap <leader>_ vg_"+y
nnoremap <leader>Y :%y+<cr>
nnoremap <leader>p o<esc>"+p
nnoremap <leader>P O<esc>"+p
vnoremap <leader>p "+p

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
  \ exe(':!tmux split-window -v -p 50 -c '.expand('%:p:h'))<cr>
nnoremap <leader>% :silent
  \ exe(':!tmux split-window -h -p 50 -c '.expand('%:p:h'))<cr>

call plug#begin()

"--- Core plugins ---

" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

" Autocomplete
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'

" Snippets
Plug 'SirVer/ultisnips'
let g:UltiSnipsExpandTrigger='<C-j>'
let g:UltiSnipsJumpForwardTrigger='<C-j>'
let g:UltiSnipsJumpBackwardTrigger='<C-k>'

" File manager
Plug 'stevearc/oil.nvim'
nnoremap <leader>ff :Oil<cr>
nnoremap <leader>fv :vsp+Oil<cr>
nnoremap <leader>fs :sp+Oil<cr>

Plug 'obaland/vfiler.vim'
nnoremap <leader>vv :VFiler<cr>
nnoremap <leader>vf :VFiler -find-file<cr>

" Fuzzy search
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'

" Send to quickfix
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

let rgIgnoreDirectories = "
  \ -g '!{**/.git/**,**/.idea/**, **/.vscode/**}'
  \ -g '!{**/node_modules/**,**/vendor/**, **/composer/**,**/gems/**}'"

let fdIgnoreDirectories = '
  \ --exclude .git
  \ --exclude .idea
  \ --exclude .vscode
  \ --exclude node_modules
  \ --exclude vendor
  \ --exclude composer
  \ --exclude gems '

let $FZF_DEFAULT_COMMAND = 'fd --type f -H '.fdIgnoreDirectories

command! Directories call fzf#run(fzf#wrap({
  \   'source': 'fd --type d -H '.fdIgnoreDirectories,
  \ }))

command! -bang -nargs=* Rg call fzf#vim#grep(
  \  'rg --hidden --column --line-number --no-heading --color=always
  \  --smart-case '.rgIgnoreDirectories.' '.shellescape(<q-args>),
  \  1, fzf#vim#with_preview(), <bang>0
  \ )

nnoremap <leader>i :Files<cr>
nnoremap <leader>d :Directories<cr>
nnoremap <leader>o :Buffers<cr>
nnoremap <leader>s :Rg<cr>
nnoremap <leader>S :Rg <c-r><c-w><cr>
au! FileType fzf set laststatus=0 noshowmode noruler
  \| au BufLeave <buffer> set laststatus=2 showmode ruler

"--- Other plugins ---
Plug 'mattn/emmet-vim'
Plug 'rlue/vim-barbaric'
Plug 'itchyny/vim-gitbranch'
Plug 'nvim-lua/plenary.nvim'
Plug 'kylechui/nvim-surround'
Plug 'AndrewRadev/tagalong.vim'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }

Plug 'simeji/winresizer'
let g:winresizer_vert_resize=3
let g:winresizer_horiz_resize=3

Plug 'takac/vim-hardtime'
let g:hardtime_maxcount = 9
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_motion_with_count_resets = 1
let g:hardtime_ignore_buffer_patterns = ["txt", "oil"]
let g:list_of_normal_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_visual_keys = ["h", "j", "k", "l", "-", "+", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
let g:list_of_disabled_keys = []

Plug 'lambdalisue/suda.vim'
let g:suda_smart_edit = 1

Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'

Plug 'wellle/tmux-complete.vim'
let g:tmuxcomplete#trigger = 'omnifunc'

Plug 'dhruvasagar/vim-table-mode'
let g:table_mode_corner='|'

Plug 'christoomey/vim-tmux-runner'
let g:VtrPercentage = 30
let g:VtrStripLeadingWhitespace = 0
let g:VtrClearEmptyLines = 0
let g:VtrAppendNewline = 1
nnoremap <leader>ra :VtrAttachToPane<cr>
nnoremap <leader>rA :VtrUnsetRunnerPane<cr>
nnoremap <leader>rs :VtrSendCommandToRunner<cr>
nnoremap <leader>rl :VtrSendLinesToRunner<cr>
vnoremap <leader>rl :VtrSendLinesToRunner<cr>gv
nnoremap <leader>ro :VtrOpenRunner<cr>
nnoremap <leader>rx :VtrKillRunner<cr>
nnoremap <leader>rz :VtrFocusRunner<cr>
nnoremap <leader>rc :VtrClearRunner<cr>
nnoremap <leader>rC :VtrFlushCommand<cr>
nnoremap <leader>rd :VtrSendCtrlD<cr>

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }
let g:mkdp_theme = 'light'
nnoremap <leader>mp :MarkdownPreviewToggle<cr>

call plug#end()

"--- Config Provider ---
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')

"--- Customize theme ---
syntax off
set background=dark
filetype plugin indent off

hi clear Error
hi clear SignColumn
hi clear VertSplit

hi NonText                   ctermfg=none     ctermbg=none     cterm=none
hi Normal                    ctermfg=none     ctermbg=none     cterm=none
hi NormalFloat               ctermfg=none     ctermbg=none     cterm=none
hi Pmenu                     ctermfg=15       ctermbg=236      cterm=none
hi PmenuSel                  ctermfg=0        ctermbg=39       cterm=none

hi LineNr                    ctermfg=240      ctermbg=none     cterm=none
hi LineNrAbove               ctermfg=240      ctermbg=none     cterm=none
hi LineNrBelow               ctermfg=240      ctermbg=none     cterm=none
hi CursorLine                ctermfg=240      ctermbg=none     cterm=none
hi CursorLineNr              ctermfg=255      ctermbg=none     cterm=bold

hi ColorColumn               ctermfg=none     ctermbg=233      cterm=none
hi SpecialKey                ctermfg=235      ctermbg=none     cterm=none
hi Whitespace                ctermfg=235      ctermbg=none     cterm=none
hi ExtraWhitespace           ctermfg=196      ctermbg=196

hi DiagnosticError           ctermfg=196      ctermbg=none     cterm=none
hi DiagnosticWarn            ctermfg=226      ctermbg=none     cterm=none
hi DiagnosticInfo            ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticHint            ctermfg=34       ctermbg=none     cterm=none

hi DiagnosticSignError       ctermfg=196      ctermbg=none     cterm=none
hi DiagnosticSignWarn        ctermfg=226      ctermbg=none     cterm=none
hi DiagnosticSignInfo        ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticSignHint        ctermfg=34       ctermbg=none     cterm=none

hi DiagnosticFloatingError   ctermfg=196      ctermbg=none     cterm=none
hi DiagnosticFloatingWarn    ctermfg=226      ctermbg=none     cterm=none
hi DiagnosticFloatingInfo    ctermfg=39       ctermbg=none     cterm=none
hi DiagnosticFloatingHint    ctermfg=34       ctermbg=none     cterm=none

hi DiagnosticUnderlineError  ctermfg=none     ctermbg=none     cterm=underline
hi DiagnosticUnderlineWarn   ctermfg=none     ctermbg=none     cterm=underline
hi DiagnosticUnderlineInfo   ctermfg=none     ctermbg=none     cterm=underline
hi DiagnosticUnderlineHint   ctermfg=none     ctermbg=none     cterm=underline

"--- Function utils ---
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

function! GitBranch()
  let branchname = gitbranch#name()

  if branchname != ""
    return '[Git('.branchname.')]'
  endif

  return ""
endfunction

function! GRemoveMarkers() range
  execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction
command! -range=% GremoveMarkers <line1>,<line2>call GRemoveMarkers()

function! IsInCurrentProject()
  let pwd = getcwd()
  let file = expand('%:p:h')

  return stridx(file, pwd) >= 0
endfunction

function! Trim()
  silent! %s#\($\n\s*\)\+\%$## " trim end newlines
  silent! %s/\s\+$//e " trim whitespace
  silent! g/^\_$\n\_^$/d " single blank line
endfunction
command! Trim :call Trim()

function! Format()
  if !IsInCurrentProject()
    return
  endif

  if filereadable('Makefile')
    make
    return
  endif

  let extension = expand('%:e')
  call Trim()
  if extension == 'go'
	  !goimports -w . && golines -m 80 -w .
  elseif extension == 'rs'
    !rufmt %
  elseif extension == 'lua'
    !stylua %
  elseif extension == 'sql'
    !sqlfluff fix --dialect postgres -f %
  elseif extension == 'md'
    !prettier --prose-wrap always -w %
  elseif index(['css', 'scss', 'html', 'js'], extension) >= 0
    !prettier -w %
  endif
endfunction
command! Format :call Format()

augroup ConfigStyleTabOrSpace
  au!
  au BufNewFile,BufReadPost *.go setlocal tabstop=2 shiftwidth=2 noexpandtab
  au BufNewFile,BufReadPost *.md setlocal tabstop=2 shiftwidth=2 expandtab
augroup end

augroup RunFile
  au!
  au FileType javascript vnoremap <leader>rr :w !node<cr>
  au FileType python vnoremap <leader>rr :w !python<cr>
augroup end

augroup ShowExtraWhitespace
  au!
  au InsertLeave * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
augroup end

augroup RelativeWorkingDirectory
  au!
  au InsertEnter * let save_cwd = getcwd() | silent! lcd %:p:h
  au InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup DisableNoiseLSP
  au InsertEnter *.* lua vim.diagnostic.disable()
  au BufWritePost *.* lua vim.diagnostic.enable()
augroup end

augroup LoadFile
  au!
  au VimResized * wincmd =
  au BufWritePost * call Mkdir()
  au BufWritePost * if IsInCurrentProject() |  exe "Trim" | endif
  au CursorMoved,CursorMovedI * set norelativenumber
  au BufReadPost *.* if line("'\"") > 1 && line("'\"") <= line("$")
    \ | exe "normal! g'\"" | endif
augroup end

"--- Load lua---
lua << EOF
  require 'module_lspconfig'
  require 'module_vfiler'
  require 'module_mason'
  require 'module_oil'
  require 'module_cmp'

  -- Without config
  require 'fidget'.setup()
  require 'nvim-surround'.setup()
EOF
