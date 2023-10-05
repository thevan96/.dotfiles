"--- General setting ---"
set nocompatible
set encoding=utf-8
set nobackup noswapfile
set autoread autowrite
set hlsearch incsearch
set list listchars=tab:»\ ,lead:.,trail:\ |
set laststatus=2 ruler
set nonumber
set signcolumn=no
set textwidth=80
set colorcolumn=+1
set cursorline cursorlineopt=number
set wildmenu wildmode=list:lastused
set completeopt=menu,menuone,noinsert
set backspace=0
set mouse=a
set autoindent
set nofoldenable
set diffopt=vertical
set ttyfast
set wildignore+=**/.git/**,**/node_modules/**

" Netrw
let g:netrw_banner = 0
let g:netrw_keepdir = 0
let g:netrw_cursor = 0
let g:root_cwd = getcwd()

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab

" Customizer mapping
let mapleader = ' '
nnoremap Y y$
xnoremap p pgvy
nnoremap gV `[v`]
nnoremap <C-l> :noh<cr>:redraw!<cr>
inoremap <C-l> <C-o>:noh<cr>:redraw!<cr>
nnoremap <leader>o :ls<cr>:b<space>
nnoremap <leader>s :grep! -r<space>
nnoremap <leader>S :grep! -r <cword><space>
nnoremap <leader>v :vim<space>
nnoremap <leader>V :vim <cword><space>
nnoremap <leader>n :set invnu<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
command! Spell set invspell

" Disable
inoremap <C-n> <nop>
inoremap <C-p> <nop>
inoremap <C-x><C-o> <nop>

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

" Mapping copy clipboard and past
noremap <leader>y "+yy
vnoremap <leader>p "+p
nnoremap <leader>p :put +<cr>
nnoremap <leader>P :put! +<cr>
nnoremap <leader>_ vg_"+y
nnoremap <leader>Y :%y+<cr>

" File manager
nnoremap <leader>ff :JumpFile<cr>
nnoremap <leader>fv :vsp+JumpFile<cr>
nnoremap <leader>fs :sp+JumpFile<cr>
command! RR :cd `=g:root_cwd`
command! Ro :e `=g:root_cwd`
command! Ex :e+JumpFile
command! Se :sp+JumpFile
command! Ve :vsp+JumpFile

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
  \ exe(':!tmux split-window -v -p 40 -c '.expand('%:p:h'))<cr>
nnoremap <leader>% :silent
  \ exe(':!tmux split-window -h -p 50 -c '.expand('%:p:h'))<cr>

"--- Etc ---"
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

function! MyExplore(command, name)
  let res = split(system(a:command), '\n')

  if bufexists(str2nr(bufnr(a:name))) == 1
    exe('b '.a:name)
    let save_cursor = getcurpos()
    let res = split(system(a:command), '\n')
    let buff = getline(1, '$')
    let buff =  buff[:(len(buff)-2)]
    if len(res) != len(buff)
      setlocal noreadonly modifiable
      exe '%d'
      call append(0, res)
      setlocal readonly nomodifiable
    endif
    call setpos('.', save_cursor)

    return
  endif

  enew
  setlocal nonumber buftype=nofile bufhidden=hide noswapfile ft=explore
  exe('file '.a:name)
  call append(0, res)
  normal! gg
  setlocal readonly nomodifiable
endfunction

let files_command =
  \ 'find -type f
  \ -not -path "*/.git/*"
  \ -not -path "*/node_modules/*"
  \ | sed "s|^./||"
  \ | sort '

let directories_command =
  \ 'find -type d
  \ \( -path "*/.git*"
  \ -o
  \ -path "*/node_modules*"
  \ \)
  \ -print -prune -o -print
  \ | sed "s|^./||"
  \ | sort '
nnoremap <silent> <leader>i :call MyExplore(files_command, 'explore_files')<cr>
nnoremap <silent> <leader>d :call MyExplore(directories_command, 'explore_directories')<cr>

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

function! NetrwSetting()
  au BufLeave <buffer> cd `=g:root_cwd`
  nnoremap <silent><buffer> Q :bd<cr>
  nnoremap <buffer> % :call CreateFile()<cr>
  nnoremap <silent><buffer> D :call NetrwDelete()<cr>
  nnoremap <silent><buffer> g? :h netrw-quickhelp<cr>
  nnoremap <silent><buffer> mL :echo join(
    \ netrw#Expose('netrwmarkfilelist'), "\n")<cr>
endfunction

function! CreateFile()
  let name = input('Enter file name: ')
  if name == ''
    return
  endif

  redraw
  exe '!touch '.name
  e .
endfunction

function! NetrwDelete()
  let target =  netrw#Call('NetrwFile', netrw#Call('NetrwGetWord'))
  if target == ''
    return
  endif

  let name = input('Delete '.getcwd().'/'.target.'? y/n: ')
  if name == 'y'
    redraw
    exe '!rm -rf '.getcwd().'/'.target
    e .
  endif
endfunction

augroup ConfigStyleTabOrSpace
  au FileType go setlocal tabstop=2 shiftwidth=2 noexpandtab
  au FileType rust setlocal tabstop=4 shiftwidth=4 expandtab
  au FileType markdown setlocal tabstop=2 shiftwidth=2 expandtab
  au FileType make setlocal tabstop=2 shiftwidth=2 noexpandtab
augroup end

augroup snippet
  au FileType * iab <buffer><expr> __date strftime("%Y-%m-%d")
augroup end

augroup RelativeWorkingDirectory
  au InsertEnter * let save_cwd = getcwd() | silent! lcd %:h
  au InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup ShowExtraWhitespace
  au InsertEnter * hi ExtraWhitespace ctermbg=none
  au InsertLeave * hi ExtraWhitespace ctermbg=196
augroup end

augroup JumpQuickfx
  au QuickFixCmdPost [^l]* nested cwindow
  au QuickFixCmdPost    l* nested lwindow
augroup end

augroup LoadFile
  au VimResized * wincmd =
  au BufWritePost * call Trim()
  au FileType netrw call NetrwSetting()
  au CursorMoved,CursorHold *.* checktime
  au FileChangedShell * call HandleFileNotExist(expand("<afile>:p"))
  au FileType explore nnoremap <silent><buffer> <CR> gf
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup end

"--- Customize theme ---"
syntax off
set background=dark
filetype plugin on
filetype indent off

hi clear Error
hi clear SignColumn
hi clear VertSplit

hi ExtraWhitespace                ctermbg=196
match ExtraWhitespace /\s\+$/

hi NonText                        ctermfg=none     ctermbg=none     cterm=none
hi Normal                         ctermfg=none     ctermbg=none     cterm=none
hi NormalFloat                    ctermfg=none     ctermbg=none     cterm=none
hi Pmenu                          ctermfg=255      ctermbg=236      cterm=none
hi PmenuSel                       ctermfg=46       ctermbg=238      cterm=none

hi LineNr                         ctermfg=244      ctermbg=none     cterm=none
hi LineNrAbove                    ctermfg=244      ctermbg=none     cterm=none
hi LineNrBelow                    ctermfg=244      ctermbg=none     cterm=none
hi CursorLine                     ctermfg=244      ctermbg=none     cterm=none
hi CursorLineNr                   ctermfg=178      ctermbg=none     cterm=none

hi ColorColumn                    ctermfg=none     ctermbg=233
hi SpecialKey                     ctermfg=238      ctermbg=none     cterm=none
hi Whitespace                     ctermfg=238      ctermbg=none     cterm=none
