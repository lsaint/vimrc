"PlugInstall [name ...] [#threads]	Install plugins
"PlugUpdate [name ...] [#threads]	Install or update plugins
"PlugClean[!]	Remove unlisted plugins (bang version will clean without prompt)
"PlugUpgrade	Upgrade vim-plug itself
"PlugStatus	    Check the status of plugins
"PlugDiff	    Examine changes from the previous update and the pending changes
"PlugSnapshot[!] [output path]	Generate script for restoring the current snapshot of the plugins
"
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"curl -fLo ~/.vimrc https://raw.githubusercontent.com/lsaint/vimrc/master/init.vim
":PlugInstall
call plug#begin('~/.vim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'dense-analysis/ale'
Plug 'yssl/QFEnter'
Plug 'editorconfig/editorconfig-vim'
Plug 'markonm/traces.vim'
Plug 'vim-scripts/CmdlineComplete'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'preservim/nerdtree'
Plug 'terryma/vim-smooth-scroll'
Plug 'majutsushi/tagbar'
Plug 'mileszs/ack.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'romainl/vim-qf'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-fugitive'
Plug 'unblevable/quick-scope'
Plug 'wincent/ferret'
" language
Plug 'stephpy/vim-yaml', {'for': 'yaml'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'vim-scripts/java_getset.vim',{'for': 'java'}
Plug 'tbastos/vim-lua', {'for': 'lua'}
Plug 'dearrrfish/vim-applescript'
" front-end
Plug 'prettier/vim-prettier'
Plug 'pangloss/vim-javascript', {'for': ['js', 'jsx']}
Plug 'mxw/vim-jsx', {'for': ['js', 'jsx']}
Plug 'HerringtonDarkholme/yats.vim', {'for': ['js', 'jsx', 'ts', 'tsx']}
" themes
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
call plug#end()

"""""""""""""""""""""""""""""""""""""""

set title " Show file title in terminal tab
set scrolloff=2 " Start scrolling slightly before the cursor reaches an edge
set shortmess=a
set cmdheight=2
set tabstop=4
set shiftwidth=4
set autoindent
set hls
set hidden
set expandtab
set backspace=indent,eol,start
set encoding=utf-8
set nocompatible
filetype plugin indent on
syntax on
colorscheme gruvbox
let mapleader = " "

autocmd bufenter * execute "let g:extension = expand('%:e')"

" delete without copy
nnoremap <leader>d "_d
vnoremap <leader>d "_d

nnoremap <tab>j }
nnoremap <tab>k {

" true color setting
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" quit 
noremap <C-C> <ESC>:q<CR>
" last file
map <leader>` :e#<CR>

" vim-indent-guides
map <leader><tab> :IndentGuidesToggle<CR>

" scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 9, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 9, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 9, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 9, 4)<CR>


" LeaderF
noremap <leader>F :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
noremap <leader>hm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ht :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>hl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>hs :<C-U><C-R>=printf("Leaderf searchHistory %s", "")<CR><CR>
let g:Lf_CommandMap = {'<C-X>': ['<C-S>'], '<C-]>': ['<C-V>'], '<C-P>': ['<C-H>'], '<C-V>': ['<C-P>']}
let g:Lf_WindowPosition = 'popup'
let g:Lf_PopupPosition = [30, 0]
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {'Function': 1, 'BufTag': 1, 'Buffer': 1}
let g:Lf_WildIgnore = {
  \ 'dir': ['.svn','.git','.hg', 'node_modules', 'tmp', 'bin'],
  \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.bson','*.exe','*.swp']
  \}

"surround.vim
let g:surround_83 = "{% static \'\r\' %}"
let g:surround_85 = "{% url \'\r\' %}"


" format
nnoremap <leader>pj :%!python3 -m json.tool<CR>
nnoremap <leader>px :%!xmllint % --format<CR>
nnoremap <leader>pp <Plug>(Prettier)


" NERDTree
"let g:NERDTreeWinPos = "right"
let NERDTreeIgnore=['\~$', '\.pyc$', 'node_modules']
noremap <leader>z :NERDTreeFind<cr>
let g:NERDTreeMapOpenSplit="s"
let g:NERDTreeMapOpenVSplit="v"
" exit vim when nerdtree window only
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif 

" run
map <leader>rp :!python3 %<cr>
map <leader>rg :!go run %<cr>
map <leader>rs :!sh %<cr>


" quifx enter
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>', '<2-LeftMouse>']
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-s>']
let g:qf_shorten_path = 0


" highlight the current line only on the active buffer
augroup CursorLine
    au!
    au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END


" highlight cur word
let g:highlighting = 0
function! Highlighting()
    if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
      let g:highlighting = 0
      return ":silent nohlsearch\<CR>"
    endif
    let @/ = '\<'.expand('<cword>').'\>'
    let g:highlighting = 1
    return ":silent set hlsearch\<CR>"
endfunction

" F
nnoremap <silent> <expr> <F1> Highlighting()
map <F2> :NERDTreeToggle<CR>
let g:maximizer_default_mapping_key = '<F3>'
nnoremap <F4> :UndotreeToggle<cr>
nmap <Leader><F5> <Plug>(qf_loc_toggle)
nmap <F5> <Plug>(qf_qf_toggle)
nmap <F7> <Plug>(qf_shorten_path_toggle)
set pastetoggle=<F6>

" <leader> number
nmap <leader>1 :Ack! --python --ignore "/*test/*" -s -w <C-r><C-w><cr>
nmap <leader>2 :Lack! -s -w <C-r><C-w><cr>
nmap <leader>3 :Ack! --ignore "/*test/*" --ignore-dir "node_modules" -s -w <C-r><C-w>
"autocmd bufenter * execute "nmap <leader>3 :Ack! --ignore '*test*' -s -w --" . g:extension . " "
nmap <leader>4 :AckFile! 

" <leader> F
map <leader><F2> :TagbarToggle<cr> 
nmap <Leader><F5> <Plug>(qf_loc_toggle)
nmap <leader><F10> :bufdo! e<cr>
nnoremap <leader><F11> :vsplit $MYVIMRC<cr>
if has("nvim")
    nmap <leader><F12> :source ~/.config/nvim/init.vim<cr>
else
    nmap <leader><F12> :source ~/.vimrc<cr>
endif


" win style save
noremap <C-S> :update<CR>
vnoremap <C-S> <C-c>:update<CR>
inoremap <C-S> <C-o>:update<CR>

" resize windows
noremap <S-Down>  <C-W>-
noremap <S-Up>    <C-W>+
noremap <S-Left>  <C-W><
noremap <S-Right> <C-W>>

" move windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-H> <C-W>h
noremap <C-L> <C-W>l

" Horizontal to Vertical, vise versa
function! ToggleWindowHorizontalVerticalSplit()
  if !exists('t:splitType')
    let t:splitType = 'vertical'
  endif

  if t:splitType == 'vertical' " is vertical switch to horizontal
    windo wincmd K
    let t:splitType = 'horizontal'

  else " is horizontal switch to vertical
    windo wincmd H
    let t:splitType = 'vertical'
  endif
endfunction
nnoremap <silent> <leader>hv :call ToggleWindowHorizontalVerticalSplit()<cr>


" Swap the position of two windows
function! WinBufSwap()
  let thiswin = winnr()
  let thisbuf = bufnr("%")
  let lastwin = winnr("#")
  let lastbuf = winbufnr(lastwin)

  exec  lastwin . " wincmd w" ."|".
      \ "buffer ". thisbuf ."|".
      \ thiswin ." wincmd w" ."|".
      \ "buffer ". lastbuf
endfunction
command! Wswap :call WinBufSwap()
map <Leader>sw :call WinBufSwap()<CR>


" vim-go
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>doc <Plug>(go-doc)
au FileType go nmap gd <Plug>(go-def)
let g:go_fmt_command = "goimports"

" java getsetter
autocmd FileType java map <Leader>gs :InsertBothGetterSetter<CR>

" ack.vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
"let g:ackhighlight = 1


" vim-airline
"let g:airline_theme='bubblegum'
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
"set t_Co=256


" ale
"let g:ale_enabled = 0
"let g:ale_sign_error = '>'
"let g:ale_sign_warning = '-'
nmap <Leader>qq <Plug>(ale_previous_wrap)
nmap <Leader>ww <Plug>(ale_next_wrap)
nmap <Leader>ad :ALEDetail<CR>
let g:airline#extensions#ale#enabled = 1

autocmd BufWritePre *.py :CocCommand python.sortImports


" coc.nvim
" coc detects acceptable new version of installed extension everyday (by default) the first time it starts. 
" When it finds a new version of an extension, it will update it for you automatically.
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-python',
  \ 'coc-lua',
  \ 'coc-go',
  \ 'coc-java',
  \ 'coc-yaml',
  \ 'coc-json',
  \ 'coc-snippets',
  \ ]
" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
" Better display for messages
set cmdheight=2
" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" navigate diagnostics
nmap <silent> <leader>[ <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>] <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>j <Plug>(coc-definition)
nmap <silent> <leader>r <Plug>(coc-references)
"nmap <silent> <leader>y <Plug>(coc-type-definition)
"nmap <silent> <leader>i <Plug>(coc-implementation)

autocmd FileType json syntax match Comment +\/\/.\+$+

nmap <silent> <leader>cor :CocRestart<cr>
nmap <silent> <leader>coc :CocCommand<cr>
nmap <silent> <leader>col :CocList<cr>
nmap <silent> <leader>cof :CocConfig<cr>
nmap <silent> <leader>coF :CocLocalConfig<cr>
imap <C-l> <Plug>(coc-snippets-expand)


"""""""""""|front-end|""""""""""""

autocmd FileType *.jsx,*.js,*.html,*.css,*.json,*.yaml  set tabstop=2 shiftwidth=2

" Prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml Prettier


"""""""""""|neovim|""""""""""""
let g:python3_host_prog = '/usr/local/opt/python@3.8/bin/python3.8'
if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                       Ethan Vim Function                                     "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


""" fold/unfold python docstring """
function! PyFoldDocString()
    setlocal foldmethod=manual
pythonx << EOF
import vim
import ast

docstring_start_lines = []
lines = vim.current.buffer
root = ast.parse("\n".join(lines))
for node in ast.walk(root):
    if isinstance(node, (ast.FunctionDef, ast.ClassDef, ast.Module)):
        if (node.body and isinstance(node.body[0], ast.Expr) and isinstance(node.body[0].value, ast.Str)):
            start = node.body[0].value.lineno 
            #print(start, node.body[0].value.s)
            docstring_start_lines.append(start)

docstring_end_lines = []
for start_line in docstring_start_lines:
    offset = 0
    for line in lines[start_line:]:
        offset += 1
        if '"""' in line or "'''" in line:
            docstring_end_lines.append(start_line + offset)
            break

docstrings = list(zip(docstring_start_lines, docstring_end_lines))
for start, end in docstrings:
    vim.command("%d,%dfold" % (start, end))
EOF
endfunction

" show nextline in foldtext
function! MarkdownFoldText()
  return getline(v:foldstart+1)
endfunction
setlocal foldtext=MarkdownFoldText()

let g:PyDocString="off"
function! TogglePyDocString()
    if g:PyDocString == "off"
        call PyFoldDocString()
        let g:PyDocString = "on"
    else
        normal! zr
        let g:PyDocString="off"
    endif
endfunction
nnoremap <F9> :call TogglePyDocString()<CR>


""" toggle my tips in preview window """ 
let g:MyVimTips="off"
function! ToggleVimTips()
  if g:MyVimTips == "on"
    let g:MyVimTips="off"
    pclose
  else
    let g:MyVimTips="on"
    pedit ~/Dropbox/vimtips.txt
  endif
endfunction
nnoremap <F8> :call ToggleVimTips()<CR>


""" go to next ([{< in current line """
let g:enclosure = [["(", "[", "{", "<"], [")", "]", "}", ">"]]
function! GotoEnclosure(direction)
    let line=getline('.')
    let colidx = col('.') - 1
    let enc = g:enclosure[0]
    let f = a:direction == 0 ? 'f' : "F"
    let r = a:direction == 0 ? range(1, len(line) - colidx) : map(range(1, colidx), {k, v -> -v})
    for i in r
        let c = line[colidx + i]
        let w = index(enc, c)
        if w != -1
            execute "normal! " . f . enc[w]
            return
        endif
    endfor
endfunction
map <silent> <tab>l :call GotoEnclosure(0)<CR>
map <silent> <tab>h :call GotoEnclosure(1)<CR>
