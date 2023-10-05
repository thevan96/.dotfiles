"--- General setting ---"
set nobackup
set noswapfile
set nocompatible
set encoding=utf-8
set autoread autowrite
set hlsearch incsearch
set ignorecase
set list listchars=tab:→\ ,lead:.,trail:\ |
set fillchars=vert:\|
set laststatus=2 ruler
set number
set signcolumn=no
set textwidth=80
set colorcolumn=+1
set cursorline
set cursorlineopt=number
set wildmenu
set wildmode=longest,list
set completeopt=menu,menuone
set mouse=a
set showmatch
set autoindent
set backspace=0
set matchtime=1
set nofoldenable
set diffopt=vertical
set ttymouse=sgr

packadd matchit

" Netrw
let g:netrw_banner = 0
let g:netrw_keepdir = 0
let g:netrw_cursor = 0
let g:root_cwd = getcwd()

" Setting tab/space
set tabstop=2 shiftwidth=2 expandtab

" Set keymap
let mapleader = ' '

" Customizer mapping
nnoremap Y y$
xnoremap p pgvy
nnoremap gV `[v`]
nnoremap <C-l> :noh<cr>
inoremap <C-l> <C-o>:noh<cr>
nnoremap <leader>i :FZF<cr>
nnoremap <leader>o :ls<cr>:b<space>
nnoremap <leader>C :set invspell<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Buffer only
command! BufOnly exe '%bdelete|edit#|bdelete#'

" Align table
au BufNewFile,BufRead *.md,*.txt
  \ vnoremap <leader>ft :'<,'>!prettier --parser markdown<cr>
au BufNewFile,BufRead *.md,*.txt
  \ nnoremap <leader>ft vip:'<,'>!prettier --parser markdown<cr>

" Current path to clipboard
command! Path let @+ = expand('%')
command! Dpath let @+ = expand('%:h')

" Toggle relative number/number
nnoremap <silent><leader>N :set invnumber<cr>
nnoremap <silent><leader>n :set invrelativenumber<cr>
vnoremap <silent><leader>n <esc>:set invrelativenumber<cr>V
xnoremap <silent><leader>n <esc>:set invrelativenumber<cr>gv

" Relativenumber keep jumplist and navigate wrap lines
nnoremap <expr> k (v:count > 1  && &relativenumber ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count > 1  && &relativenumber ? "m'" . v:count : '') . 'gj'

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

" File manager
nnoremap <leader>ff :JumpFile<cr>
nnoremap <leader>fv :vsp+JumpFile<cr>
nnoremap <leader>fs :sp+JumpFile<cr>
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
  " echom a:firstline.'-'.a:lastline
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

function! Format()
  if !IsInCurrentProject()
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
  elseif index(
    \ [
    \   'html', 'css', 'scss', 'yaml', 'json',
    \   'js', 'jsx', 'ts', 'tsx'
    \ ], extension) >= 0
    !prettier -w %
  endif
endfunction
command! Format :call Format()

function! FZF()
  let command =
    \ 'find -type f
    \ -not -path */\.git/*
    \ -not -path */node_modules/*
    \ | sed "s|^./||"
    \ | sort '

  let res = split(system(command), '\n')

  if bufexists(str2nr(bufnr('fzf'))) == 1
    b fzf
    let save_cursor = getcurpos()
    let res = split(system(command), '\n')
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
  setlocal nonumber buftype=nofile bufhidden=hide noswapfile ft=fzf
  execute 'file fzf'
  call append(0, res)
  normal! gg
  setlocal readonly nomodifiable
endfunction
command! FZF :call FZF()

function! Scratch()
  enew
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal ft=scratch
  execute 'file scratch'
endfunction
command! Scratch :call Scratch()

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
  silent exe '!chmod +x '.tmp
  let res = system(a:runner.language.' '.tmp)

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
  nnoremap <buffer> % :!touch<space>
  nnoremap <buffer> d :!mkdir -p<space>
  nnoremap <silent><buffer> D :call NetrwDelete()<cr>
  nnoremap <silent><buffer> g? :h netrw-quickhelp<cr>
  nnoremap <silent><buffer> mL :echo join(
    \ netrw#Expose('netrwmarkfilelist'), "\n")<cr>
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
  au!
  au BufNewFile,BufRead,BufWrite *.go setlocal tabstop=2 shiftwidth=2 noexpandtab
  au BufNewFile,BufRead,BufWrite *.rs setlocal tabstop=4 shiftwidth=4 expandtab
  au BufNewFile,BufRead,BufWrite *.md setlocal tabstop=2 shiftwidth=2 expandtab
  au BufNewFile,BufRead,BufWrite Makefile setlocal tabstop=2 shiftwidth=2 noexpandtab
augroup end

augroup RelativeWorkingDirectory
  au InsertEnter * let save_cwd = getcwd() | silent! lcd %:h
  au InsertLeave * silent execute 'lcd' fnameescape(save_cwd)
augroup end

augroup ShowExtraWhitespace
  au!
  au InsertEnter * hi ExtraWhitespace ctermbg=none
  au InsertLeave * hi ExtraWhitespace ctermbg=196
augroup end

augroup JumpQuickfx
  au QuickFixCmdPost [^l]* nested cwindow
  au QuickFixCmdPost    l* nested lwindow
augroup end

augroup LoadFile
  au!
  au VimResized * wincmd =
  au FocusGained * redraw!
  au CursorMoved *.* checktime
  au BufWritePost * call Trim()
  au FileType netrw call NetrwSetting()
  au FileType qf,markdown,text setlocal nonumber
  au CursorMoved,CursorMovedI * set norelativenumber
  au FileChangedShell * call HandleFileNotExist(expand("<afile>:p"))
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
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
hi Pmenu                          ctermfg=15       ctermbg=236      cterm=none
hi PmenuSel                       ctermfg=46       ctermbg=0       cterm=none

hi LineNr                         ctermfg=244      ctermbg=none     cterm=none
hi LineNrAbove                    ctermfg=244      ctermbg=none     cterm=none
hi LineNrBelow                    ctermfg=244      ctermbg=none     cterm=none
hi CursorLine                     ctermfg=244      ctermbg=none     cterm=none
hi CursorLineNr                   ctermfg=46       ctermbg=none     cterm=none

hi ColorColumn                    ctermfg=none     ctermbg=233
hi SpecialKey                     ctermfg=238      ctermbg=none     cterm=none
hi Whitespace                     ctermfg=238      ctermbg=none     cterm=none
