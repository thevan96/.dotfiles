"--- General setting ---
set nobackup
set noswapfile
set spelllang=en_us
set encoding=utf-8
set autoread autowrite
set list listchars=tab:»\ ,lead:.,trail:\ |
set number relativenumber
set ignorecase smartcase
set signcolumn=no
set textwidth=80
set colorcolumn=+1
set cursorline cursorlineopt=number
set wildmenu wildmode=list
set completeopt=menu,menuone,noinsert
set noshowcmd
set backspace=0
set nofoldenable
set guicursor=i:block
set mouse=a
set wildignore=*/.git/*,*/node_modules/*

" Use persistent undo history.
if !isdirectory("/tmp/.nvim-undo-dir")
  call mkdir("/tmp/.nvim-undo-dir", "", 0700)
endif
set undofile
set undodir=/tmp/.nvim-undo-dir

" vim use alias bash
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
nnoremap <C-l> :noh<cr>
inoremap <C-l> <C-o>:noh<cr>
nnoremap <leader>n :set invrelativenumber<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
command! Spell set invspell

" Better jump tags/intellisense
nnoremap <C-]> g<C-]>
inoremap <C-x><C-o> <C-Space>

" Relativenumber keep jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'gj'

" Buffer only
command! BufOnly exe '%bdelete|edit#|bdelete#'

" Navigate quickfix/loclist
nnoremap <leader>qo :copen<cr>
nnoremap <leader>qx :cclose<cr>
nnoremap [q :cprev<cr>
nnoremap ]q :cnext<cr>
nnoremap [Q :cfirst<cr>
nnoremap ]Q :clast<cr>

nnoremap <leader>zo :lopen<cr>
nnoremap <leader>zx :lclose<cr>
nnoremap [z :lprev<cr>
nnoremap ]z :lnext<cr>
nnoremap [Z :lfirst<cr>
nnoremap ]Z :llast<cr>

nnoremap <leader>ao :args<cr>
nnoremap <leader>aa :argadd %<cr>:argdedupe<cr>
nnoremap <leader>ax :args<cr>:argdelete<space>
nnoremap <leader>aX :argdelete *<cr>:echo 'clear args list'<cr>
nnoremap [a :previous<cr>:args<cr>
nnoremap ]a :next<cr>:args<cr>
nnoremap [A :first<cr>:args<cr>
nnoremap ]A :last<cr>:args<cr>

" Mapping copy clipboard and past
noremap <leader>y "+yy
vnoremap <leader>p "+p
nnoremap <leader>p :put +<cr>
nnoremap <leader>P :put! +<cr>
nnoremap <leader>_ vg_"+y
nnoremap <leader>Y :%y+<cr>

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
nnoremap <leader>fo :e .<cr>

" Fuzzy search
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'

let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }
let g:fzf_layout = { 'down': '40%' }

let rgIgnoreDirectories = "
  \ -g '!{**/.git/**,**/.idea/**, **/.vscode/**, **/.direnv/**}'
  \ -g '!{**/node_modules/**,**/vendor/**, **/composer/**,**/gems/**}'"

let fdIgnoreDirectories = '
  \ --exclude .git
  \ --exclude .idea
  \ --exclude .vscode
  \ --exclude .direnv
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

nnoremap <leader>o :Buffers<cr>
nnoremap <leader>i :Files<cr>
nnoremap <leader>d :Directories<cr>
nnoremap <leader>s :Rg<space>
nnoremap <leader>S :Rg <C-R><C-W><cr>
au! FileType fzf setlocal laststatus=0 noshowmode noruler
  \| au BufLeave <buffer> set laststatus=2 showmode ruler

"--- Other plugins ---
Plug 'j-hui/fidget.nvim'
Plug 'rlue/vim-barbaric'
Plug 'tommcdo/vim-exchange'
Plug 'kylechui/nvim-surround'

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

function! IsInCurrentProject()
  let pwd = getcwd()
  let file = expand('%:p:h')

  if stridx(file, 'node_modules') >= 0
    return
  endif

  return stridx(file, pwd) >= 0
endfunction

function! Trim()
  if !&binary && IsInCurrentProject()
    silent! %s#\($\n\s*\)\+\%$## " trim end newlines
    silent! %s/\s\+$//e " trim whitespace
    silent! g/^\_$\n\_^$/d " single blank line
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

  if match(getline("."), '^```') != -1
    return result
  endif

  let start_i = search('^```', 'bnW')
  if start_i == 0
    return result
  endif

  let end_i = search('^```', 'nW')
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
  try
    let runner = a:runner

    if getline(runner.end + 2) ==# '```result'
      let save_cursor = getcurpos()
      call cursor(runner.end + 3, 0)
      let end_result_block_line = search('```', 'cW')
      if end_result_block_line
        if getline(end_result_block_line + 1) ==# ''
          call deletebufline(bufname("%"), runner.end + 2, end_result_block_line + 1)
        else
          call deletebufline(bufname("%"), runner.end + 2, end_result_block_line)
        endif
      endif
      call setpos('.', save_cursor)
    endif

    let result_lines = split(runner.result, '\n')
    call append(runner.end, '')
    call append(runner.end + 1, '```result')
    call append(runner.end + 2, result_lines)
    call append(runner.end + len(result_lines) + 2, '```')

  catch  /.*/
    call s:error(v:exception)
  endtry
endfunction

function! s:error(error)
  execute 'normal! \<Esc>'
  echohl ErrorMsg
  echo 'Markdown error: ' . a:error
  echohl None
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
    call s:InsertBlockCode(runner)
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
  au FileType * iab <buffer><expr> date@@ strftime("%Y-%m-%d")
augroup end

augroup ShowExtraWhitespace
  au InsertEnter * hi ExtraWhitespace ctermbg=none
  au InsertLeave * hi ExtraWhitespace ctermbg=196
augroup end

augroup RelativeWorkingDirectory
  au InsertEnter * let save_cwd = getcwd() | silent! lcd %:h
  au InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup JumpQuickfx
  au QuickFixCmdPost [^l]* nested cwindow
  au QuickFixCmdPost    l* nested lwindow
augroup end

augroup LoadFile
  au!
  au VimResized * wincmd =
  au BufWritePost * call Trim()
  au FileType fzf setlocal nonumber norelativenumber
  au BufEnter * if !IsInCurrentProject() | setlocal nomodifiable | endif
  au FileChangedShell * call HandleFileNotExist(expand("<afile>:p"))
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
hi Search                    ctermfg=0      ctermbg=255    cterm=none
hi Pmenu                     ctermfg=255    ctermbg=236    cterm=none
hi PmenuSel                  ctermfg=178    ctermbg=238    cterm=none

hi StatusLine                ctermfg=none   ctermbg=236    cterm=bold
hi StatusLineNC              ctermfg=none   ctermbg=236    cterm=none

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

hi DiagnosticSignError       ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticSignWarn        ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticSignInfo        ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticSignHint        ctermfg=46     ctermbg=none   cterm=none

hi DiagnosticFloatingError   ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticFloatingWarn    ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticFloatingInfo    ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticFloatingHint    ctermfg=46     ctermbg=none   cterm=none

"--- Load lua---
lua << EOF
  require 'module_oil'
  require 'module_lspconfig'

  -- Without config
  require 'fidget'.setup()
  require 'nvim-surround'.setup()
EOF
