"--- General setting ---
set nobackup
set noswapfile
set spelllang=en_us
set encoding=utf-8
set autoread autowrite
set list listchars=tab:»\ ,lead:.,trail:\ |
set noshowmode noshowcmd
set number relativenumber
set ignorecase smartcase
set signcolumn=no
set textwidth=80
set colorcolumn=+1
set cursorline cursorlineopt=number
set wildmenu wildmode=list
set completeopt=menu,menuone,noinsert
set backspace=0
set nofoldenable
set guicursor=i:block
set mouse=a
set grepprg=grep\ -rn\ --exclude-dir={.git,node_modules}
set wildignore=*/.git/*,*/node_modules/*
packadd! matchit

" Use persistent undo history.
if !isdirectory("/tmp/.nvim-undo-dir")
  call mkdir("/tmp/.nvim-undo-dir", "", 0700)
endif
set undofile
set undodir=/tmp/.nvim-undo-dir

" vim use alias bash
let $ROOT=getcwd()
let $BASH_ENV = $HOME.'/.bash_aliases'

" Netrw
let g:loaded_netrw = 0
let g:loaded_netrwPlugin = 0

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab

" Set keymap
let mapleader = ' '

" Customizer mapping
xnoremap p pgvy
nnoremap gV `[v`]
nnoremap <C-j> <C-e>j
nnoremap <C-k> <C-y>k
nnoremap <C-l> :noh<cr>
inoremap <C-l> <C-o>:noh<cr>
nnoremap <leader>h1 I= <esc>A =<esc>
nnoremap <leader>h2 I== <esc>A ==<esc>
nnoremap <leader>n :set invrelativenumber<cr>
nnoremap <leader>s :grep<space>
nnoremap <leader>S :grep -r <C-R><C-W><space>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
command! Spell set invspell
command! BufOnly exe '%bdelete|edit#|bdelete#'

" Better jump tags/intellisense
nnoremap <C-]> g<C-]>
inoremap <C-Space> <C-x><C-o>

" Relativenumber keep jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'

" Navigate quickfix/loclist
nnoremap <leader>qo :copen<cr>
nnoremap <leader>qx :cclose<cr>
nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>

nnoremap <leader>wo :lopen<cr>
nnoremap <leader>wx :lclose<cr>
nnoremap [w :lprev<cr>
nnoremap ]w :lnext<cr>
nnoremap [W :lfirst<cr>
nnoremap ]W :llast<cr>

nnoremap <leader>ao :args<cr>
nnoremap <leader>aa :argadd %<cr>:argdedupe<cr>
nnoremap <leader>ax :args<cr>:argdelete<space>
nnoremap <leader>aX :argdelete *<cr>:echo 'clear args list'<cr>
nnoremap [a :previous<cr>:args<cr>
nnoremap ]a :next<cr>:args<cr>
nnoremap [A :first<cr>:args<cr>
nnoremap ]A :last<cr>:args<cr>

" Mapping copy clipboard and past
nnoremap <leader>y "+yy
vnoremap <leader>y "+yy
nnoremap <leader>_ vg_"+y
nnoremap <leader>Y :%y+<cr>
nnoremap <leader>p "+p
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

" Automatic install vimplug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  let lk =
    \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs '.lk
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

"--- Core plugins ---

" Lsp
Plug 'neovim/nvim-lspconfig'

" File manager
Plug 'stevearc/oil.nvim'
nnoremap <leader>ff :Oil<cr>
nnoremap <leader>fv :vsp+Oil<cr>
nnoremap <leader>fs :sp+Oil<cr>

" Fuzzy search
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'

let g:fzf_action = {
  \   'ctrl-s': 'split',
  \   'ctrl-v': 'vsplit'
  \ }
let g:fzf_layout = { 'down': '40%' }

command! Directories call fzf#run(fzf#wrap({
  \   'source': $FZF_ALT_C_COMMAND
  \ }))

command! -bang -nargs=* Grep
  \ call fzf#vim#grep(
  \  'grep -rn --exclude-dir={.git,node_modules} --color=always  -- '
  \    .fzf#shellescape(<q-args>),
  \  fzf#vim#with_preview({
  \    'dir': systemlist('git rev-parse --show-toplevel')[0]
  \  }),
  \  <bang>0)

nnoremap <leader>o :Buffers<cr>
nnoremap <leader>i :Files<cr>
nnoremap <leader>d :Directories<cr>
nnoremap <leader>g :Grep<space>
nnoremap <leader>G :Grep <C-R><C-W><cr>

"--- Other plugins ---
Plug 'j-hui/fidget.nvim'
Plug 'tommcdo/vim-exchange'
Plug 'kylechui/nvim-surround'
Plug 'stefandtw/quickfix-reflector.vim'

Plug 'tyru/open-browser.vim'
Plug 'weirongxu/plantuml-previewer.vim'

Plug 'mattn/emmet-vim'
let g:user_emmet_settings = {
  \  'html': {
  \    'snippets': {
  \      'html:5': "<!DOCTYPE html>\n"
  \              ."<html lang=\"en\">\n"
  \              ."<head>\n"
  \              ."\t<meta charset=\"utf-8\">\n"
  \              ."\t<title></title>\n"
  \              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
  \              ."</head>\n"
  \              ."<body>\n\t${child}|\n</body>\n"
  \              ."</html>",
  \    },
  \  },
  \}

Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
nnoremap <leader>mp :MarkdownPreviewToggle<cr>

Plug 'tpope/vim-speeddating'

Plug 'takac/vim-hardtime'
let g:hardtime_maxcount = 9
let g:hardtime_default_on = 1
let g:hardtime_ignore_quickfix = 1
let g:hardtime_allow_different_key = 1
let g:hardtime_motion_with_count_resets = 0
let g:hardtime_ignore_buffer_patterns = [ 'oil']

Plug 'christoomey/vim-tmux-runner'
let g:VtrPercentage = 50
let g:VtrOrientation = 'h'
nnoremap <leader>va :VtrAttachToPane<cr>
nnoremap <leader>vA :VtrUnsetRunnerPane<cr>
nnoremap <leader>vs :VtrSendCommandToRunner<cr>
nnoremap <leader>vl :VtrSendLinesToRunner<cr>
vnoremap <leader>vl :VtrSendLinesToRunner<cr>gv
nnoremap <leader>vo :VtrOpenRunner<cr>
nnoremap <leader>vx :VtrKillRunner<cr>
nnoremap <leader>vz :VtrFocusRunner<cr>
nnoremap <leader>vf :VtrFlushCommand<cr>
nnoremap <leader>vd :VtrSendCtrlD<cr>
nnoremap <leader>vc :VtrSendCtrlC<cr>
nnoremap <leader>vC :VtrClearRunner<cr>

call plug#end()

"--- Function utils ---
function! GRemoveMarkers() range
  execute a:firstline.','.a:lastline . ' g/^<\{7}\|^|\{7}\|^=\{7}\|^>\{7}/d'
endfunction
command! -range=% GremoveMarkers <line1>,<line2>call GRemoveMarkers()

function! Trim()
  if !&binary
    silent! %s#\($\n\s*\)\+\%$## " trim end newlines
    silent! %s/\s\+$//e " trim whitespace
    silent! g/^\_$\n\_^$/d " single blank line
    silent! w
  endif
endfunction
command! Trim :call Trim()

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    exec ':bd '.old_name
    redraw!
  endif
endfunction
command! Rename :call RenameFile()

function! s:ParseCodeBlock() abort
  let result = {}

  if match(getline("."), '```') != -1
    return result
  endif

  let start_i = search('```', 'bnW')
  if start_i == 0
    return result
  endif

  let end_i = search('```', 'nW')
  if end_i == 0
    return {}
  endif

  let lines = getline(start_i, end_i)
  if len(lines) < 3
    return {}
  endif

  let result.src = lines[1:-2]
  let result.language = lines[0][3:]
  let result.start = start_i
  let result.end = end_i
  let result.result = ''

  return result
endfunction

function! s:RunJs(runner)
  let tmp = tempname().'.js'
  let src = a:runner.src

  call writefile(src, tmp)
  let res = system('node ' . tmp)

  let a:runner.result = res
  call delete(tmp)
  return a:runner
endfunction

function! s:RunShell(runner)
  let tmp = tempname(). '.sh'
  let src = a:runner.src

  call writefile(src, tmp)
  let res = system('chmod +x '.tmp.' && '.a:runner.language.' '.tmp)

  let a:runner.result = res
  call delete(tmp)
  return a:runner
endfunction

function! s:RunGo(runner)
  let tmp = tempname().'.go'
  let src = a:runner.src

  call writefile(src, tmp)
  let res = system('go run ' . tmp)

  let a:runner.result = res
  call delete(tmp)
  return a:runner
endfunction

function! s:InsertBlockCode(runner)
  let runner = a:runner

  if getline(runner.end + 2) == '```result'
    call cursor(runner.end + 3, 0)
    let end_result_block_line = search('```', 'cW')
    call deletebufline(bufname("%"), runner.end + 2, end_result_block_line)
  endif

  let result_lines = split(runner.result, '\n')
  call append(runner.end, '')
  call append(runner.end + 1, '```result')
  call append(runner.end + 2, result_lines)
  call append(runner.end + len(result_lines) + 2, '```')
  silent! w
endfunction

function! RunCode(type)
  let runner = s:ParseCodeBlock()
  if runner == {}
    return
  endif

  if runner.language == 'result' || runner.language == ''
    return
  elseif index(['sh', 'bash', 'zsh'], runner.language) >= 0
    let runner = s:RunShell(runner)
  elseif runner.language == 'go'
    let runner = s:RunGo(runner)
  elseif runner.language == 'js'
    let runner = s:RunJs(runner)
  endif

  if a:type == 'insert'
    let save_cursor = getcurpos()
    call s:InsertBlockCode(runner)
    call setpos('.', save_cursor)
  elseif a:type == 'echo'
    echo runner.result
  endif
endfunction
nnoremap <silent><leader>rr :call RunCode('insert')<cr>
nnoremap <silent><leader>re :call RunCode('echo')<cr>

function HandleFileNotExist(name)
  let msg = 'File "'.a:name.'"'
  let v:fcs_choice = ''
  if v:fcs_reason == "deleted"
    let msg .= " no longer available"
    call setbufvar(expand(a:name), '&modified', '1')
    call setbufvar(expand(a:name), '&readonly', '1')
    echohl WarningMsg
  endif
  echomsg msg
endfunction

function! InCodeFence()
  call search('^```.*$', 'bceW')
  normal! j
  normal! 0v
  call search("```", 'ceW')
  normal! kg_
endfunction

function! AroundCodeFence()
  call search('^```.*$', 'bcW')
  normal! v$
  call search('```', 'eW')
endfunction

xnoremap <silent> if :call InCodeFence()<cr>
onoremap <silent> if :call InCodeFence()<cr>
xnoremap <silent> af :call AroundCodeFence()<cr>
onoremap <silent> af :call AroundCodeFence()<cr>

function! Scratch()
  enew
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal ft=scratch
  execute 'file scratch'
endfunction
command! Scratch :call Scratch()

xnoremap <silent> gs <esc>:call <sid>SwapVisualWithCut()<cr>
xnoremap <silent> gS <esc>:call <sid>SwapVisualWithCut2()<cr>

augroup Aligntable
  au FileType markdown,text
    \ vnoremap <buffer> <leader>ft !prettier --parser markdown<cr>
  au FileType markdown,text
    \ nnoremap <buffer> <leader>ft vip!prettier --parser markdown<cr>
augroup end

augroup ConfigStyleTabOrSpace
  au FileType go setlocal tabstop=2 shiftwidth=2 noexpandtab
  au FileType rust setlocal tabstop=4 shiftwidth=4 expandtab
  au FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
  au FileType make setlocal tabstop=2 shiftwidth=2 noexpandtab
augroup end

augroup snippet
  iab <expr> date@@ strftime("%Y-%m-%d")
augroup end

augroup ShowExtraWhitespace
  au InsertEnter * hi ExtraWhitespace ctermbg=none
  au InsertLeave * hi ExtraWhitespace ctermbg=196
augroup end

augroup RelativeWorkingDirectory
  au InsertEnter * let save_cwd = getcwd() | silent! lcd %:h
  au InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup LoadFile
  au VimResized * wincmd =
  au BufWritePost * call Trim()
  au FileType fzf setlocal laststatus=0
    \| au BufLeave <buffer> setlocal laststatus=2
  au FileType oil,fzf setlocal nonumber norelativenumber
  au FileChangedShell * call HandleFileNotExist(expand("<afile>:p"))
  au FocusGained,BufEnter,CursorMoved,CursorHold *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' |
    \   checktime |
    \ endif
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup end

"--- Config Provider ---
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:loaded_python3_provider = 0

"--- Customize theme ---
syntax off
set background=dark
filetype plugin on
filetype indent off

match ExtraWhitespace /\s\+$/
hi ExtraWhitespace           ctermbg=196

hi SignColumn                ctermfg=none   ctermbg=none   cterm=none
hi NormalFloat               ctermfg=none   ctermbg=none   cterm=none
hi Search                    ctermfg=0      ctermbg=43     cterm=none
hi Pmenu                     ctermfg=255    ctermbg=236    cterm=none
hi PmenuSel                  ctermfg=178    ctermbg=238    cterm=none

hi LineNr                    ctermfg=244    ctermbg=none   cterm=none
hi LineNrAbove               ctermfg=244    ctermbg=none   cterm=none
hi LineNrBelow               ctermfg=244    ctermbg=none   cterm=none
hi CursorLine                ctermfg=244    ctermbg=none   cterm=none
hi CursorLineNr              ctermfg=178    ctermbg=none   cterm=none

hi SpecialKey                ctermfg=238    ctermbg=none   cterm=none
hi Whitespace                ctermfg=238    ctermbg=none   cterm=none
hi ColorColumn               ctermfg=none   ctermbg=233    cterm=none

hi DiagnosticError           ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticWarn            ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticInfo            ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticHint            ctermfg=46     ctermbg=none   cterm=none

hi DiagnosticUnderlineError  ctermfg=196    ctermbg=none   cterm=underline
hi DiagnosticUnderlineWarn   ctermfg=226    ctermbg=none   cterm=underline
hi DiagnosticUnderlineInfo   ctermfg=39     ctermbg=none   cterm=underline
hi DiagnosticUnderlineHint   ctermfg=46     ctermbg=none   cterm=underline

hi DiagnosticSignError       ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticSignWarn        ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticSignInfo        ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticSignHint        ctermfg=46     ctermbg=none   cterm=none

hi DiagnosticFloatingError   ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticFloatingWarn    ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticFloatingInfo    ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticFloatingHint    ctermfg=46     ctermbg=none   cterm=none

lua << EOF
  require 'module_oil'
  require 'module_lsp'
  require 'fidget'.setup()
  require 'nvim-surround'.setup()
EOF
