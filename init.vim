call plug#begin('~/.vim/plugged')
Plug 'dstein64/vim-startuptime'
Plug 'github/copilot.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'yaegassy/coc-ruff', {'do': 'yarn install --frozen-lockfile'}
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'dense-analysis/ale'
Plug 'yssl/QFEnter'
Plug 'editorconfig/editorconfig-vim'
Plug 'markonm/traces.vim'
Plug 'vim-scripts/CmdlineComplete'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-airline/vim-airline'
Plug 'romainl/vim-qf'
Plug 'tpope/vim-fugitive'
Plug 'unblevable/quick-scope'
Plug 'wincent/ferret'
Plug 'skywind3000/vim-quickui'
Plug 'andymass/vim-matchup'
Plug 'RRethy/vim-illuminate'
Plug 'echasnovski/mini.animate'
Plug 'stevearc/stickybuf.nvim'
Plug 'stevearc/aerial.nvim'
" dap debug
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python', {'for': 'python'}
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
" efm-langserver
Plug 'neovim/nvim-lspconfig'
Plug 'creativenull/efmls-configs-nvim'
Plug 'lukas-reineke/lsp-format.nvim'
" language
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'mracos/mermaid.vim'
Plug 'dart-lang/dart-vim-plugin'
" themes
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
call plug#end()



"-------------------------------------------------------------------------------
" color
"-------------------------------------------------------------------------------

colorscheme gruvbox

highlight Normal     ctermbg=NONE guibg=NONE
highlight LineNr     ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight VertSplit  ctermbg=NONE guibg=NONE

" true color setting
" make vim use the GUI colors setting (e.g. gui=Grey) in the terminal
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"underline color for cursor word
hi def IlluminatedWordText gui=underline guisp=#7aa697 cterm=underline
hi def IlluminatedWordRead gui=underline guisp=#7aa697 cterm=underline
hi def IlluminatedWordWrite gui=underline guisp=#7aa697 cterm=underline

" quick-scope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']
highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline


"-------------------------------------------------------------------------------
" common
"-------------------------------------------------------------------------------


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

" quit 
noremap <C-C> <ESC>:q!<CR>


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
set fillchars=eob:\ 
set fillchars+=vert:┃
syntax on
filetype plugin indent on
let mapleader = "\<Space>"

autocmd bufenter * execute "let g:extension = expand('%:e')"

" delete without copy
"nnoremap <leader>d "_d
"vnoremap <leader>d "_d
" copy to system clipboard
vnoremap <leader>y "*y
nnoremap <tab>j }
nnoremap <tab>k {

" go to last file pos
map <leader>` :e#<CR>

" F
noremap <F2> :NERDTreeToggle<CR>
nnoremap <F4> :CtrlSFToggle<CR>
set pastetoggle=<F11>

" Vita
let g:vista_default_executive = "coc"

" <leader> number
nmap <leader>1 :Ack! --python --ignore tests -s -w <C-r><C-w><cr>
nmap <leader>2 :CtrlSF -S -W <C-r><C-w>
nmap <leader>4 :Ack! --ignore static/ --ignore node_modules --ignore builds --ignore tests -s -w <C-r><C-w>


" <leader> F
nmap <leader><F2> :AerialToggle!<cr>
"nmap <Leader><F5> <Plug>(qf_loc_toggle)
nmap <leader><F6> :NERDTreeClose<CR>\|<Plug>(qf_qf_toggle)
nmap <leader><F7> <Plug>(qf_shorten_path_toggle)
nmap <leader><F10> :bufdo! e<cr>
nnoremap <leader><F11> :vsplit $MYVIMRC<cr>
nmap <leader><F12> :source ~/.config/nvim/init.vim<cr>



"-------------------------------------------------------------------------------
" github copilot
"-------------------------------------------------------------------------------
imap <C-j> <Plug>(copilot-suggest)
imap <C-l> <Plug>(copilot-next)
imap <C-h> <Plug>(copilot-previous)
imap <C-;> <Plug>(copilot-dismiss)
imap <C-K> <Plug>(copilot-accept-word)
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



"-------------------------------------------------------------------------------
" markdown-preview
"-------------------------------------------------------------------------------
nmap <C-m> <Plug>MarkdownPreviewToggle


"-------------------------------------------------------------------------------
" vim-devicons
"-------------------------------------------------------------------------------
let g:WebDevIconsOS = 'Darwin'


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
"nnoremap , <Plug>(qf_older)
"nnoremap . <Plug>(qf_newer)



"-------------------------------------------------------------------------------
" vim-go
"-------------------------------------------------------------------------------
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>doc <Plug>(go-doc)
au FileType go nmap gd <Plug>(go-def)
let g:go_fmt_command = "goimports"


"-------------------------------------------------------------------------------
" vim-airline
"-------------------------------------------------------------------------------
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1


"-------------------------------------------------------------------------------
" ale
"-------------------------------------------------------------------------------
let g:ale_enabled = 1
"highlight clear ALEErrorSign
"highlight clear ALEWarningSign
nmap <Leader>ww <Plug>(ale_next_wrap)
nmap <Leader>qq <Plug>(ale_previous_wrap)
let g:airline#extensions#ale#enabled = 1
let g:ale_echo_msg_format = '[%linter%] %code%: %s'
let g:ale_use_neovim_diagnostics_api = 1
"nnoremap <leader>d :ALEToggle<CR>:e<CR>




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
  \ 'coc-go',
  \ 'coc-java',
  \ 'coc-yaml',
  \ 'coc-json',
  \ 'coc-snippets',
  \ 'coc-flutter',
  \ 'coc-toml',
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

"function! s:check_back_space() abort
  "let col = col('.') - 1
  "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

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
    \ ['&Horizontal<->Vertical', 'lua swap_window_horizontal_vertical()', 'Horizontal to Vertical, vise versa'],
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


lua << EOF
require('config')
EOF
