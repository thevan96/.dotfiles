"--- General setting ---
set nobackup
set noswapfile
set spelllang=en_us
set encoding=utf-8
set autoread autowrite
set undofile undodir=~/.vim/undo
set list listchars=tab:→\ ,lead:.,trail:\ |
set number norelativenumber
set signcolumn=no
set textwidth=80
set colorcolumn=80
set cursorline cursorlineopt=number
set wildmode=longest,list
set completeopt=menu,menuone,noinsert
set noshowcmd
set backspace=0
set nofoldenable
set guicursor=i:block
set scrolloff=5
set mouse=

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
nnoremap <leader>h yypVr-
nnoremap <leader>H yypVr=
nnoremap <leader>fm :Format<cr>
nnoremap <leader>C :set invspell<cr>
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'
inoremap <C-Space> <C-x><C-o>

" Align table
au BufNewFile,BufRead *.md,*.txt
  \ vnoremap <leader>ft :'<,'>!prettier --parser markdown<cr>
au BufNewFile,BufRead *.md,*.txt
  \ nnoremap <leader>ft vip:'<,'>!prettier --parser markdown<cr>

" Virtual edit
nnoremap <leader>Va :set virtualedit=all nolist<cr>
nnoremap <leader>Vn :set virtualedit=none list<cr>

" Toggle relative number/number
nnoremap <silent><leader>N :set invnumber<cr>
nnoremap <silent><leader>n :set invrelativenumber<cr>
vnoremap <silent><leader>n <esc>:set invrelativenumber<cr>V
xnoremap <silent><leader>n <esc>:set invrelativenumber<cr>gv

" Relativenumber keep jumplist
nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k'
nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j'

" Buffer only
command! BufOnly exe '%bdelete|edit#|bdelete#'

" Current path to clipboard
command! Path let @+ = expand('%')
command! Dpath let @+ = expand('%:h')

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

call plug#begin()

"--- Core plugins ---

" Lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'

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

" Fuzzy search
set rtp+=~/.fzf
Plug 'junegunn/fzf.vim'

let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }
let g:fzf_layout = { 'down': '~40%' }

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
nnoremap <leader>o :Buffers<cr>
nnoremap <leader>d :Directories<cr>
nnoremap <leader>s :Rg<cr>
nnoremap <leader>S :Rg <c-r><c-w><cr>
nnoremap <leader>T :Snippets<cr>
au! FileType fzf set laststatus=0 noshowmode noruler
  \| au BufLeave <buffer> set laststatus=2 showmode ruler

"--- Other plugins ---
Plug 'mattn/emmet-vim'
Plug 'rlue/vim-barbaric'
Plug 'machakann/vim-swap'
Plug 'tommcdo/vim-exchange'
Plug 'kylechui/nvim-surround'
Plug 'stefandtw/quickfix-reflector.vim'
Plug 'j-hui/fidget.nvim', { 'tag': 'legacy' }
Plug 'weirongxu/plantuml-previewer.vim'
Plug 'tyru/open-browser.vim'

Plug 'iamcco/markdown-preview.nvim',
  \ { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
nnoremap <leader>M :MarkdownPreviewToggle<cr>

Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
nmap <silent> <leader>dg <Plug>(doge-generate)

Plug 'simnalamburt/vim-mundo'
let g:mundo_right = 1
nnoremap <leader>md :MundoToggle<cr>

Plug 'lambdalisue/suda.vim'
command! W exe 'SudaWrite'

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

function! SendCommand(command)
  if a:command == ''
    return
  endif
  exe 'VtrSendCommandToRunner '.a:command
endfunction

au FileType go nnoremap <buffer> <leader>vt
  \ :call SendCommand('go test -v '.expand('%:p:h'))<cr>
au FileType go nnoremap <buffer> <leader>vT
  \ :call SendCommand('go test ./...')<cr>

call plug#end()

"--- Function utils ---
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
  elseif index(['html', 'css', 'scss', 'yaml', 'json'], extension) >= 0
    !prettier -w %
  elseif filereadable('package.json')
    if filereadable('node_modules/bin/prettier')
      !npx prettier -w %
    elseif filereadable('node_modules/bin/standard')
      !npx standard --fix %
    elseif filereadable('node_modules/bin/eslint')
      !npx eslint --fix %
    endif
  elseif extension == 'js' || extension == 'jsx'
    !standard --fix %
  elseif extension == 'ts' || extension == 'tsx'
    !ts-standard --fix %
  endif
endfunction
command! Format :call Format()

function! Scratch()
  new
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal noswapfile
  setlocal ft=scratch
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

augroup ConfigStyleTabOrSpace
  au!
  au BufNewFile,BufRead *.go setlocal tabstop=2 shiftwidth=2 noexpandtab
  au BufNewFile,BufRead *.rs setlocal tabstop=4 shiftwidth=4 expandtab
  au BufNewFile,BufRead *.md setlocal tabstop=2 shiftwidth=2 expandtab
  au BufNewFile,BufRead Makefile setlocal tabstop=2 shiftwidth=2 noexpandtab
augroup end

augroup ShowExtraWhitespace
  au!
  au InsertLeave * match ExtraWhitespace /\s\+$/
  au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
augroup end

augroup RelativeWorkingDirectory
  au!
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
  au CursorMoved  *.* checktime
  au BufWritePost * call Trim()
  au FileType oil,qf,markdown,text setlocal nonumber
  au CursorMoved,CursorMovedI * set norelativenumber
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
augroup end

"--- Config Provider ---
let g:loaded_perl_provider = 0
let g:loaded_node_provider = 0
let g:loaded_ruby_provider = 0
let g:loaded_python_provider = 0
let g:python3_host_prog = expand('$HOME/.asdf/shims/python3')

"--- Customize theme ---
syntax off
set background=dark
filetype plugin on
filetype indent off

hi SignColumn                ctermfg=none   ctermbg=none   cterm=none
hi NormalFloat               ctermfg=none   ctermbg=none   cterm=none
hi Pmenu                     ctermfg=15     ctermbg=236    cterm=none
hi PmenuSel                  ctermfg=0      ctermbg=39     cterm=none

hi LineNr                    ctermfg=244    ctermbg=none   cterm=none
hi LineNrAbove               ctermfg=244    ctermbg=none   cterm=none
hi LineNrBelow               ctermfg=244    ctermbg=none   cterm=none
hi CursorLine                ctermfg=244    ctermbg=none   cterm=none
hi CursorLineNr              ctermfg=255    ctermbg=none   cterm=bold,underline

hi SpecialKey                ctermfg=236    ctermbg=none   cterm=none
hi Whitespace                ctermfg=236    ctermbg=none   cterm=none
hi ExtraWhitespace           ctermfg=196    ctermbg=196    cterm=none
hi ColorColumn               ctermfg=none   ctermbg=233    cterm=none

hi DiagnosticError           ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticWarn            ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticInfo            ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticHint            ctermfg=34     ctermbg=none   cterm=none

hi DiagnosticSignError       ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticSignWarn        ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticSignInfo        ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticSignHint        ctermfg=34     ctermbg=none   cterm=none

hi DiagnosticFloatingError   ctermfg=196    ctermbg=none   cterm=none
hi DiagnosticFloatingWarn    ctermfg=226    ctermbg=none   cterm=none
hi DiagnosticFloatingInfo    ctermfg=39     ctermbg=none   cterm=none
hi DiagnosticFloatingHint    ctermfg=34     ctermbg=none   cterm=none

hi DiagnosticUnderlineError  ctermfg=196    ctermbg=none   cterm=underline
hi DiagnosticUnderlineWarn   ctermfg=226    ctermbg=none   cterm=underline
hi DiagnosticUnderlineInfo   ctermfg=39     ctermbg=none   cterm=underline
hi DiagnosticUnderlineHint   ctermfg=34     ctermbg=none   cterm=underline

"--- Load lua---
lua << EOF
  require 'module_lspconfig'
  require 'module_mason'
  require 'module_oil'

  -- Without config
  require 'fidget'.setup()
  require 'nvim-surround'.setup()
EOF
