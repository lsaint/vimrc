"===============================================================================
"
" start from 0
"
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
"curl -fLo ~/.vimrc https://raw.githubusercontent.com/lsaint/vimrc/master/init.vim
":PlugInstall
"===============================================================================


"===============================================================================
" 
" vim-plug
"
" PlugInstall [name ...] [#threads]	Install plugins
" PlugUpdate [name ...] [#threads]	Install or update plugins
" PlugClean[!]	Remove unlisted plugins (bang version will clean without prompt)
" PlugUpgrade	Upgrade vim-plug itself
" PlugStatus	    Check the status of plugins
" PlugDiff	    Examine changes from the previous update and the pending changes
" PlugSnapshot[!] [output path]	Generate script for restoring the current snapshot of the plugins
"===============================================================================
call plug#begin('~/.vim/plugged')
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nathanaelkane/vim-indent-guides'
Plug 'dense-analysis/ale'
Plug 'yssl/QFEnter'
Plug 'editorconfig/editorconfig-vim'
Plug 'markonm/traces.vim'
Plug 'vim-scripts/CmdlineComplete'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'preservim/nerdtree'
Plug 'terryma/vim-smooth-scroll'
Plug 'liuchengxu/vista.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'romainl/vim-qf'
Plug 'szw/vim-maximizer'
Plug 'tpope/vim-fugitive'
Plug 'unblevable/quick-scope'
Plug 'wincent/ferret'
Plug 'skywind3000/vim-quickui'
Plug 'andymass/vim-matchup'
" language
Plug 'stephpy/vim-yaml', {'for': 'yaml'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'tbastos/vim-lua', {'for': 'lua'}
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'mracos/mermaid.vim'
Plug 'dart-lang/dart-vim-plugin'
" front-end
Plug 'prettier/vim-prettier', { 'do': 'yarn install --frozen-lockfile --production' }
Plug 'pangloss/vim-javascript', {'for': ['js', 'jsx']}
Plug 'maxmellon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim', {'for': ['js', 'jsx', 'ts', 'tsx']}
" themes
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
call plug#end()


colorscheme gruvbox
highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight VertSplit  ctermbg=NONE guibg=NONE
"highlight Pmenu     ctermbg=NONE guibg=NONE


"===============================================================================
" mapping
"===============================================================================
set title " Show file title in terminal tab
set scrolloff=2 " Start scrolling slightly before the cursor reaches an edge
set shortmess=a
set cmdheight=2
set tabstop=4
set shiftwidth=4
set autoindent
set hlsearch
set hidden
set expandtab
set backspace=indent,eol,start
set encoding=utf-8
set nocompatible
set splitright
set splitbelow
"set fillchars=eob:▒
set fillchars=eob:\ 
"set fillchars+=vert:║
syntax on
filetype plugin indent on
let mapleader = "\<Space>"

autocmd bufenter * execute "let g:extension = expand('%:e')"

" delete without copy
nnoremap <leader>d "_d
vnoremap <leader>d "_d
" copy to system clipboard
vnoremap <leader>y "*y

nnoremap <tab>j }
nnoremap <tab>k {


" true color setting
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" quit 
noremap <C-C> <ESC>:q!<CR>
" go to last file pos
map <leader>` :e#<CR>

" vim-indent-guides
map <leader>t :IndentGuidesToggle<CR>

" scroll
noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 9, 2)<CR>
noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 9, 2)<CR>
noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 9, 4)<CR>
noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 9, 4)<CR>


" F
nnoremap <silent> <expr> <F1> Highlighting()
noremap <F2> :NERDTreeToggle<CR>
let g:maximizer_default_mapping_key = '<F3>'
nnoremap <F4> :CtrlSFToggle<CR>
nmap <Leader><F5> <Plug>(qf_loc_toggle)
nmap <F5> :NERDTreeClose<CR>\|<Plug>(qf_qf_toggle)
nmap <F7> <Plug>(qf_shorten_path_toggle)
set pastetoggle=<F6>

" Vita
let g:vista_default_executive = "coc"

" <leader> number
nmap <leader>1 :Ack! --python --ignore tests -s -w <C-r><C-w><cr>
nmap <leader>2 :CtrlSF -S -W <C-r><C-w>
nmap <leader>4 :Ack! --ignore tests --ignore static/ --ignore node_modules --ignore builds -s -w <C-r><C-w>

"nmap <leader>kk :K 
"nmap <leader>kj :Rej test
"nmap <leader>kl :Res<cr>


" <leader> F
nmap <leader><F2> :Vista!!<cr> 
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
noremap <C-P> <C-W>p


"" highlight the current line only on the active buffer
augroup CursorLine
    au!
    "au VimEnter,WinEnter,BufWinEnter * setlocal cursorline 
    au WinLeave * setlocal nocursorline nocursorcolumn
augroup END

" highlight the current column & line when cursor is moved
function! SetCursorCross()
    if exists('s:cursor_timer')
        call timer_stop(s:cursor_timer)
    endif
    setlocal cursorcolumn cursorline
    let s:cursor_timer = timer_start(2000, 'UnsetCursorCross')
endfunction

function! UnsetCursorCross(timer)
    setlocal nocursorcolumn nocursorline
endfunction

augroup CursorColumn
    au!
    au CursorMoved * call SetCursorCross()
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


"-------------------------------------------------------------------------------
" github copilot
"-------------------------------------------------------------------------------
imap <C-l> <Plug>(copilot-next)
imap <C-h> <Plug>(copilot-previous)
imap <C-;> <Plug>(copilot-dismiss)
let g:copilot_filetypes = {
    \ 'gitcommit': v:true,
    \ 'markdown': v:true,
    \ 'yaml': v:true
    \ }
" disables Copilot for files larger than 200KB
autocmd BufReadPre *
    \ let f=getfsize(expand("<afile>"))
    \ | if f > 200000 || f == -2
    \ | let b:copilot_enabled = v:false
    \ | endif
" complete next word
function! CompleteOneWord()
    let suggestion = copilot#Accept("")
    let bar = copilot#TextQueuedForInsertion()
    return split(bar, '[ .]\zs')[0]
endfunction

imap <script><expr> <C-k> CompleteOneWord()


"-------------------------------------------------------------------------------
" markdown-preview
"-------------------------------------------------------------------------------
nmap <C-m> <Plug>MarkdownPreviewToggle



"-------------------------------------------------------------------------------
" preservim/vim-markdown
"-------------------------------------------------------------------------------
let g:vim_markdown_folding_disabled = 1


"-------------------------------------------------------------------------------
" vim-matchup
"-------------------------------------------------------------------------------
nmap <leader>n z%
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_hi_surround_always = 1


"-------------------------------------------------------------------------------
" LeaderF
"-------------------------------------------------------------------------------
noremap <leader>F :<C-U><C-R>=printf("Leaderf file --no-ignore %s", "")<CR><CR>
noremap <leader>m :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
"noremap <leader>F :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
"noremap <leader>d :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>ht :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>hs :<C-U><C-R>=printf("Leaderf searchHistory %s", "")<CR><CR>
let g:Lf_CommandMap = {'<C-X>': ['<C-S>'], '<C-]>': ['<C-V>'], '<C-P>': ['<C-H>'], '<C-V>': ['<C-P>']}
let g:Lf_WindowPosition = 'popup'
let g:Lf_PopupPosition = [30, 0]
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult = {'Function': 1, 'BufTag': 1}
let g:Lf_WildIgnore = {
  \ 'dir': ['.svn','.git','.hg', 'node_modules', 'tmp', 'bin'],
  \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.so','*.py[co]','*.bson','*.exe','*.swp']
  \}


"-------------------------------------------------------------------------------
" nerdtree
"-------------------------------------------------------------------------------
"let g:NERDTreeWinPos = "right"
let NERDTreeIgnore=['\~$', '\.pyc$', 'node_modules', '__pycache__', '\.sqlite3']
noremap <leader>z :NERDTreeFind<cr>
let g:NERDTreeMapOpenSplit="s"
let g:NERDTreeMapOpenVSplit="v"
" exit vim when nerdtree window only
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif


"-------------------------------------------------------------------------------
" QFEnter
"-------------------------------------------------------------------------------
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>', '<2-LeftMouse>']
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-s>']
let g:qfenter_exclude_filetypes = ['nerdtree', 'tagbar']


"-------------------------------------------------------------------------------
" vim-qf
"-------------------------------------------------------------------------------
let g:qf_shorten_path = 0
nnoremap , <Plug>(qf_older)
nnoremap . <Plug>(qf_newer)



"-------------------------------------------------------------------------------
" vim-go
"-------------------------------------------------------------------------------
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>doc <Plug>(go-doc)
au FileType go nmap gd <Plug>(go-def)
let g:go_fmt_command = "goimports"


"-------------------------------------------------------------------------------
" java getsetter
"-------------------------------------------------------------------------------
"autocmd FileType java map <Leader>gs :InsertBothGetterSetter<CR>



"-------------------------------------------------------------------------------
" ctrlsf
"-------------------------------------------------------------------------------
"let g:ctrlsf_default_view_mode = 'compact'
"let g:ctrlsf_populate_qflist = 1 "feed quickfix and location list with search result
let g:ctrlsf_auto_focus = {"at": "start" }
let g:ctrlsf_auto_close = {"normal": 0, "compact": 0 }
let g:ctrlsf_mapping = {                               
    \ "quit": ["<C-C>", "q"],
    \ "next": "n",
    \ "prev": "N",
    \ }


"-------------------------------------------------------------------------------
" vim-airline
"-------------------------------------------------------------------------------
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1


"-------------------------------------------------------------------------------
" ale
"-------------------------------------------------------------------------------
"let g:ale_enabled = 0
let g:ale_disable_lsp = 1
"let g:ale_sign_error = '☠️'
"let g:ale_sign_warning = '🔥'
"highlight clear ALEErrorSign
"highlight clear ALEWarningSign
nmap <Leader>[ <Plug>(ale_previous_wrap)
nmap <Leader>] <Plug>(ale_next_wrap)
let g:airline#extensions#ale#enabled = 1
call ale#Set('python_flake8_options', '--config=$HOME/.config/flake8')
nnoremap <leader>d :ALEToggle<CR>:e<CR>



"-------------------------------------------------------------------------------
" coc.nvim
"-------------------------------------------------------------------------------
" coc detects acceptable new version of installed extension everyday (by default) the first time it starts. 
" When it finds a new version of an extension, it will update it for you automatically.
let g:coc_global_extensions = [
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-html',
  \ 'coc-css',
  \ 'coc-pyright',
  \ 'coc-lua',
  \ 'coc-go',
  \ 'coc-java',
  \ 'coc-yaml',
  \ 'coc-json',
  \ 'coc-snippets',
  \ 'coc-flutter',
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
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
      "\ coc#pum#visible() ? coc#pum#next(1) :
      "\ CheckBackspace() ? "\<Tab>" :
      "\ coc#refresh()
"inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction


" navigate diagnostics
nmap <silent> <leader>qq <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>ww <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <leader>j <Plug>(coc-definition)
nmap <silent> <leader>k <Plug>(coc-type-definition)
nmap <silent> <leader>l <Plug>(coc-references)
"nmap <silent> <leader>i <Plug>(coc-implementation)

nmap <silent> <leader>ac <Plug>(coc-codeaction)
nmap <silent> <leader>qf <Plug>(coc-fix-current)
nmap <silent> <leader>ho :call CocAction('doHover')<cr>

autocmd FileType json syntax match Comment +\/\/.\+$+

nmap <silent> <leader>cor :CocRestart<cr>
nmap <silent> <leader>coc :CocCommand<cr>
nmap <silent> <leader>col :CocList<cr>
nmap <silent> <leader>cof :CocConfig<cr>
nmap <silent> <leader>coF :CocLocalConfig<cr>
"imap <C-l> <Plug>(coc-snippets-expand)

autocmd BufWritePre *.py silent! :call CocAction('runCommand', 'python.sortImports')



"-------------------------------------------------------------------------------
" quick-scope
"-------------------------------------------------------------------------------
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline



"-------------------------------------------------------------------------------
" quick-ui
"-------------------------------------------------------------------------------
call quickui#menu#reset()
call quickui#menu#install("&File", [
    \ [ "Search &File", 'exec input("", ":AckFile! ")'],
    \ [ "--", ],
    \ [ "LeaderF &Mru", 'Leaderf mru --regexMode', 'Open recently accessed files'],
    \ [ "LeaderF &SearchHistory", 'Leaderf searchHistory', 'List search history'],
    \ [ "LeaderF &CmdHistory", 'Leaderf cmdHistory', 'List cmd history'],
    \ [ "LeaderF &BufTag", 'Leaderf bufTag', 'List tag in current buffer'],
    \ [ "LeaderF Li&ne", 'Leaderf line', 'List line in current buffer'],
    \ ])
call quickui#menu#install("&Git", [
    \ ['&Git', 'Git', ''],
    \ ['Git &Blame', 'Gblame', ''],
    \ ['Git &Diff', 'Git diff -p', ''],
    \ ['Git Diff &Split', 'Gdiffsplit', ''],
    \ ['Git L&og', 'Git log', ''],
    \ ])
call quickui#menu#install("F&ormat", [
    \ ['Show &Indent', 'IndentGuidesToggle', 'highlight indent'],
    \ [ "--", ],
    \ ['Format &Json', '%!python3 -m json.tool', 'format json file using python3 module json.tool'],
    \ ['Format &Xml', '%!xmllint % --format', 'format xml using xmlint'],
    \ ['Format &Prettier', 'Prettier', 'format current buffer using Prettier'],
    \ ['Format &Black', '!black %', 'format pyhton file with Black'],
    \ ])
call quickui#menu#install("&Run", [
    \ ['Run &Python', '!python3 %', ''],
    \ ['Run &Go', '!go run %', ''],
    \ ['Run &Shell', '!sh %', ''],
    \ ['Run &Django', '!python manage.py shell < %', ''],
    \ ])
call quickui#menu#install("&Config", [
    \ ['&Vimrc', ':e $MYVIMRC', ''],
    \ ['Vim&Tips', ':e ~/Library/CloudStorage/Dropbox/vim/vimtips.txt', ''],
    \ ['&CocConfig', ':CocConfig', ''],
    \ ['C&ocLocalConfig', ':CocLocalConfig', ''],
    \ ])
call quickui#menu#install("&Window", [
    \ ['&Shell', 'terminal', ''],
    \ ['&Horizontal<->Vertical', 'call ToggleWindowHorizontalVerticalSplit()', 'Horizontal to Vertical, vise versa'],
    \ [ "--", ],
    \ ['&Tagbar', 'Vista!!', ''],
    \ ])

nnoremap <silent><space><space> :call quickui#menu#open()<cr>
"
let g:context_menu_1= [
    \ ["&Tip", "call CocAction('doHover')", "CocAction doHover"],
    \ ["&Fix", "CocFix", "CocFix"],
    \ ["&Diagnostics", "CocDiagnostics", "CocDiagnostics"],
    \ [ "--", ],
    \ ['&Lack', 'exec "Lack! -s -w " . expand("<cword>")'],
    \ ["&Vim help", 'exec "h " . expand("<cword>")'],
    \ ]
nnoremap <silent>K :call quickui#context#open(g:context_menu_1, {})<cr>
nnoremap <silent><tab>m :call quickui#context#open(g:context_menu_1, {})<cr>
"
let g:quickui_show_tip = 1
let g:quickui_color_scheme = 'gruvbox'
let g:quickui_preview_w = 100
let g:quickui_preview_h = 15
augroup MyQuickfixPreview
  au!
  au FileType qf noremap <silent><buffer> ` :call quickui#tools#preview_quickfix()<cr>
augroup END


"===============================================================================
" front-end
"===============================================================================

autocmd FileType *.dart,*.ts,*.tsx,*.jsx,*.js,*.html,*.css,*.json,*.yaml  set tabstop=2 shiftwidth=2

" Prettier
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
"autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml Prettier


"===============================================================================
" neovim
"===============================================================================
let g:python_host_prog = '/opt/homebrew/bin/python3'
if exists(':tnoremap')
    tnoremap <Esc> <C-\><C-n>
endif



"===============================================================================
"                       Ethan's Vim Function
"===============================================================================



"-------------------------------------------------------------------------------
" fold/unfold python docstring
"-------------------------------------------------------------------------------
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
    let line = getline(v:foldstart)
    if len(trim(line)) > 4
        return line
    endif
    return getline(v:foldstart+1)
endfunction
setlocal foldtext=MarkdownFoldText()

let g:PyDocString={} " {'bufname': 1 ...}
function! TogglePyDocString()
    if get(g:PyDocString, bufname(), 0) == 0
        call PyFoldDocString()
        let g:PyDocString[bufname()] = 1
    else
        normal! zr
        let g:PyDocString[bufname()] = 0
    endif
endfunction
nnoremap <F9> :call TogglePyDocString()<CR>


"-------------------------------------------------------------------------------
" toggle my tips in preview window 
"-------------------------------------------------------------------------------
let g:MyVimTips="off"
function! ToggleVimTips()
  if g:MyVimTips == "on"
    let g:MyVimTips="off"
    pclose
  else
    let g:MyVimTips="on"
    pedit ~/Library/CloudStorage/Dropbox/vim/vimtips.txt
  endif
endfunction
nnoremap <F8> :call ToggleVimTips()<CR>


"-------------------------------------------------------------------------------
" go to next ([{< in current line 
"-------------------------------------------------------------------------------
let g:enclosure = [["(", "[", "{", "<"], [")", "]", "}", ">"]]
function! GotoEnclosure(direction, side)
    let line=getline('.')
    let colidx = col('.') - 1
    let enc = (a:side == 0) ? g:enclosure[0] : g:enclosure[1]
    let f = a:direction == 0 ? 'f' : "F"
    let r = a:direction == 0 ? range(1, len(line) - colidx) : map(range(1, colidx), {k, v -> -v})
    for i in r
        let c = line[colidx + i]
        let w = index(enc, c)
        if w != -1
            execute "normal! " . f . enc[w]
            return 1
        endif
    endfor
    return 0
endfunction
function! GotoEnclosureDual(direction)
    let another_side = (a:direction == 0) ? 1 : 0
    if GotoEnclosure(a:direction, 0) == 0
        call GotoEnclosure(a:direction, another_side)
    endif
endfunction
nmap <silent> <tab>l :call GotoEnclosureDual(0)<CR>
nmap <silent> <tab>h :call GotoEnclosureDual(1)<CR>


"-------------------------------------------------------------------------------
" test
"-------------------------------------------------------------------------------
function! Test()
endfunction
nmap <F12> :call Test()<CR>
