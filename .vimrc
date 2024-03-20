"--- General setting ---"
set nocompatible
set encoding=utf-8
set nobackup noswapfile
set autoread autowrite
set ignorecase smartcase
set hlsearch incsearch shortmess-=S
set list listchars=tab:›\ ,leadmultispace:·\ ,trail:-
set fillchars=stl:\_,stlnc:\_,fold:\ |
set laststatus=2 backspace=0 ruler signcolumn=no
set ttimeout ttimeoutlen=100 timeoutlen=1000
set number relativenumber
set colorcolumn=81
set wildmenu wildmode=list
set completeopt=menu
set hidden autoindent
set diffopt=vertical
set mouse=a ttymouse=xterm2
set nofoldenable nocursorline
set undofile
set undodir=/tmp/.vim-undo-dir
set wildignore=*/.git/*,*/.vscode/*,*/.direnv/*,*/node_modules/*
set grepprg=grep\ -rn\ --exclude-dir={.git,.vscode,.direnv,node_modules}
packadd! matchit

" Use persistent undo history.
if !isdirectory("/tmp/.vim-undo-dir")
  call mkdir("/tmp/.vim-undo-dir", "", 0700)
endif

" Netrw
let g:netrw_banner = 0
let g:netrw_cursor = 0

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab

" Customizer mapping
let mapleader = ' '
nnoremap Y y$
xnoremap p pgvy
nnoremap gV `[v`]
nnoremap <C-l> :noh<cr>
inoremap <C-l> <C-o>:noh<cr>
nnoremap <leader>h yypVr-
nnoremap <leader>o :ls<cr>:b<space>
nnoremap <leader>g :grep!<space>
nnoremap <leader>G :grep! <C-R><C-W>
nnoremap <leader>n :set invrelativenumber<cr>
nnoremap <leader>e :r ~/.dotfiles/snippets/
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

command! Scratch setlocal buftype=nofile bufhidden=hide noswapfile
command! Tab setlocal tabstop=2 shiftwidth=2 noexpandtab
command! Space setlocal tabstop=2 shiftwidth=2 expandtab
command! Spell setlocal invspell
command! Path let @+ = expand("%:h")
command! File let @+ = expand("%")

" Disable autocomplete
inoremap <C-n> <nop>
inoremap <C-p> <nop>
inoremap <C-o> <nop>
inoremap <C-Space> <nop>
inoremap <C-x><C-o> <nop>

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

" Mapping copy clipboard and past
nnoremap <leader>y "+yy
vnoremap <leader>y "+yy
nnoremap <leader>_ vg_"+y
nnoremap <leader>Y :%y+<cr>
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" File manager
nnoremap <leader>ff :JumpFile<cr>
nnoremap <leader>fv :vsp+JumpFile<cr>
nnoremap <leader>fs :sp+JumpFile<cr>
command! Ex :e+JumpFile
command! Sex :sp+JumpFile
command! Vex :vsp+JumpFile

" Open in tab terminal
nnoremap <leader>" :silent exe(':!tmux split-window -v -c '.expand('%:p:h'))<cr>
nnoremap <leader>% :silent exe(':!tmux split-window -h -c '.expand('%:p:h'))<cr>

" Fix conflict git
if &diff
  nnoremap <leader>1 :diffget LOCAL<cr>:diffupdate<cr>
  nnoremap <leader>2 :diffget BASE<cr>:diffupdate<cr>
  nnoremap <leader>3 :diffget REMOTE<cr>:diffupdate<cr>
  nnoremap <leader><cr> :diffupdate<cr>
  vnoremap <leader>= :GremoveMarkers<cr><gv>
endif

"--- Etc ---"
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

function! Command()
  if bufexists(str2nr(bufnr('Command_mode'))) == 1
    exe 'b Command_mode'
    return
  endif

  enew
  setlocal buftype=nofile bufhidden=hide noswapfile
  silent execute 'file Command_mode'
endfunction
nnoremap <silent><leader><cr> :call Command()<cr>

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

function! RunCode()
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

  let save_cursor = getcurpos()
  call s:InsertBlockCode(runner)
  call setpos('.', save_cursor)
endfunction
nnoremap <silent><leader>r :call RunCode()<cr>

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

function! HandleFileNotExist(name)
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

function! MyExplore(command, name)
  let res = split(system(a:command), '\n')

  if bufexists(str2nr(bufnr(a:name))) == 1
    exe('b '.a:name)
    let save_cursor = getcurpos()
    let res = split(system(a:command), '\n')
    let buff = getline(1, '$')
    let buff =  buff[:(len(buff)-2)]
    if len(res)-1 != len(buff)
      setlocal noreadonly modifiable
      exe '%d'
      call append(0, res)
      silent! %s#\($\n\s*\)\+\%$##
      setlocal readonly nomodifiable
    endif
    call setpos('.', save_cursor)
    return
  endif

  enew
  setlocal buftype=nofile bufhidden=hide noswapfile ft=explore
  exe('file '.a:name)
  call append(0, res)
  silent! %s#\($\n\s*\)\+\%$##
  normal! gg
  setlocal readonly nomodifiable
endfunction

let files_command =
  \ 'find -type f
  \ -not -path */.git/*
  \ -not -path */.vscode/*
  \ -not -path */.direnv/*
  \ -not -path */node_modules/*
  \ | sed "s|^./||"
  \ | sort'

let directories_command =
  \ 'find -type d
  \ \(
  \ -path */.git/*
  \ -o
  \ -path */.vscode/*
  \ -o
  \ -path */.direnv/*
  \ -o
  \ -path */node_modules/*
  \ -prune -o -print
  \ \)
  \ | sed "s|^./||"
  \ | sort'

nnoremap <silent> <leader>i
  \ :call MyExplore(files_command, 'explore_files')<cr>
nnoremap <silent> <leader>d
  \ :call MyExplore(directories_command, 'explore_directories')<cr>

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

function! JumpFile()
  let folder = expand('%:h')
  if folder == ''
    e .
    return
  endif

  let file_name = expand('%:t')
  exe 'e '.folder
  call search(file_name)
endfunction
command! JumpFile call JumpFile()

" Make Vim handle line and column numbers in file names
let s:fnameMatcher = ':\d\+\(:.*\)\?$'
function! s:ProcessTrailingLineNum()
  let fname = expand('%')
  if filereadable(fname)
    return
  endif

  if fname =~# s:fnameMatcher
    let oldBufNum = bufnr()
    exec 'edit ' . s:FileNameFrom(fname)
    call cursor(s:LineNumFrom(fname), s:ColNumFrom(fname))
    exec ':bwipe ' . oldBufNum
  endif
endfunction

function! s:LineNumFrom(fnameWithLineNum)
  return substitute(a:fnameWithLineNum, '^.\{-}:\(\d\+\)\(:.*\)\?$', '\1', '')
endfunction

function! s:ColNumFrom(fnameWithColNum)
  return substitute(a:fnameWithColNum, '^.\{-}:\d\+:\(\d\+\)\(:.*\)\?$', '\1', '')
endfunction

function! s:FileNameFrom(fnameWithLineNum)
  return substitute(a:fnameWithLineNum, '^\(.\{-}\):\d\+\(:.*\)\?$', '\1', '')
endfunction

function! MyFoldText()
  let title = getline(v:foldstart)
  let numberlines = v:foldend - v:foldstart
  return title.' --- +'.numberlines
endfunction

function! MyFoldText()
  let title = getline(v:foldstart)
  let numberlines = v:foldend - v:foldstart
  return title.' --- +'.numberlines
endfunction

augroup OpenWithLineCol
  autocmd bufnewfile,bufenter * ++nested call s:ProcessTrailingLineNum()
augroup END

augroup ConfigStyleTabOrSpace
  au FileType text
    \ setlocal foldenable foldmethod=marker foldtext=MyFoldText()
  au FileType
    \ yaml setlocal foldlevel=99 foldmethod=indent foldtext=MyFoldText()
  au FileType go setlocal tabstop=2 shiftwidth=2 noexpandtab
  au FileType rust setlocal tabstop=4 shiftwidth=4 expandtab
  au FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
  au FileType make setlocal tabstop=2 shiftwidth=2 noexpandtab
augroup end

augroup Abbreviation
  iab <expr> snidate strftime("%Y-%m-%d")
  iab sniline --------------------------------------------------------------------------------
augroup end

augroup RelativeWorkingDirectory
  au InsertEnter * let save_cwd = getcwd() | silent! lcd %:h
  au InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup LoadFile
  au VimResized * wincmd =
  au FileType netrw
    \ cnoremap <buffer><expr> %% getcmdtype() == ':' ? b:netrw_curdir.'/' : '%%'
  au FileChangedShell * call HandleFileNotExist(expand("<afile>:p"))
  au FocusGained,BufEnter,CursorMoved,CursorHold *
    \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' |
    \   checktime |
    \ endif
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup end

syntax off
set background=dark
filetype plugin off
filetype indent off

hi clear Error
hi clear VertSplit
hi Folded                            ctermbg=none    cterm=none
hi FoldColumn        ctermfg=none    ctermbg=none    cterm=none
hi SignColumn        ctermfg=none    ctermbg=none    cterm=none
hi Normal            ctermfg=none    ctermbg=none    cterm=none
hi Pmenu             ctermfg=255     ctermbg=234     cterm=none
hi PmenuSel          ctermfg=46      ctermbg=236     cterm=none
hi MatchParen        ctermfg=46      ctermbg=none    cterm=bold
hi Visual            ctermfg=255     ctermbg=242     cterm=none
hi LineNr            ctermfg=240     ctermbg=none    cterm=none
hi LineNrAbove       ctermfg=240     ctermbg=none    cterm=none
hi LineNrBelow       ctermfg=240     ctermbg=none    cterm=none
hi StatusLine        ctermfg=none    ctermbg=none    cterm=bold
hi StatusLineNC      ctermfg=none    ctermbg=none    cterm=none
hi NonText           ctermfg=238     ctermbg=none    cterm=none
hi SpecialKey        ctermfg=238     ctermbg=none    cterm=none
hi ColorColumn       ctermfg=none    ctermbg=233
