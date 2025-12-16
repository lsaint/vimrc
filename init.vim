call plug#begin('~/.vim/plugged')
Plug 'ibhagwan/fzf-lua'
Plug 'dstein64/vim-startuptime'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'editorconfig/editorconfig-vim'
Plug 'markonm/traces.vim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'unblevable/quick-scope'
Plug 'skywind3000/vim-quickui'
Plug 'andymass/vim-matchup'
Plug 'RRethy/vim-illuminate'
Plug 'echasnovski/mini.animate'
Plug 'stevearc/stickybuf.nvim'
Plug 'stevearc/aerial.nvim'
Plug 'nvim-lualine/lualine.nvim'
" git
Plug 'lewis6991/gitsigns.nvim'
Plug 'kdheepak/lazygit.nvim'
" qf
Plug 'folke/trouble.nvim'
Plug 'kevinhwang91/nvim-bqf'
Plug 'romainl/vim-qf'
Plug 'wincent/ferret'
Plug 'yssl/QFEnter'
" ai
Plug 'zbirenbaum/copilot.lua'
Plug 'nvim-lua/plenary.nvim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'
" cmp
Plug 'saghen/blink.cmp', { 'tag': 'v*' }
Plug 'fang2hou/blink-copilot'
" dap debug
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python', {'for': 'python'}
Plug 'nvim-neotest/nvim-nio'
Plug 'rcarriga/nvim-dap-ui'
" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'creativenull/efmls-configs-nvim'
Plug 'lukas-reineke/lsp-format.nvim'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'rmagatti/goto-preview'
" language
Plug 'OXY2DEV/markview.nvim'
Plug 'mracos/mermaid.vim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate', 'branch': 'main'}
"Plug 'fatih/vim-go', {'for': 'go'}
" themes
Plug 'morhetz/gruvbox'
Plug 'nvim-tree/nvim-web-devicons'
call plug#end()



"--------------------------------------------------------------------------------
" color
"--------------------------------------------------------------------------------

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


"--------------------------------------------------------------------------------
" common
"--------------------------------------------------------------------------------

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

noremap <C-W>j <C-W>J
noremap <C-W>k <C-W>K
noremap <C-W>l <C-W>L
noremap <C-W>h <C-W>H

noremap <C-1> 1



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
set nocompatible
set splitright
set splitbelow

set fillchars=eob:\ 
set fillchars+=vert:\ 
highlight WinSeparator guibg=#3c3836 

set fileencodings=ucs-bom,utf-8,gbk,latin1
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

" <leader> number
nmap <leader>1 :Ack! --type python --glob !tests -s -w <C-r><C-w><cr>
nmap <leader>3 :Ack! --glob !static/ --glob !node_modules --glob !builds -s <C-r><C-w>
nmap <leader>4 :Ack! --glob !static/ --glob !node_modules --glob !builds --glob !*tests -s -w <C-r><C-w>

" <leader> F
nmap <leader><F2> :AerialToggle!<cr>
"nmap <Leader><F5> <Plug>(qf_loc_toggle)
nmap <leader><F6> :NERDTreeClose<CR>\|<Plug>(qf_qf_toggle)
nmap <leader><F7> <Plug>(qf_shorten_path_toggle)
nmap <leader><F10> :bufdo! e<cr>
nnoremap <leader><F11> :vsplit $MYVIMRC<cr>
nmap <leader><F12> :source ~/.config/nvim/init.vim<cr>


"--------------------------------------------------------------------------------
" markview.nvim
"--------------------------------------------------------------------------------
nmap <leader>dd :Markview<cr>


"--------------------------------------------------------------------------------
" vim-matchup
"--------------------------------------------------------------------------------
nmap <leader>n z%
let g:matchup_matchparen_deferred = 1
"let g:matchup_matchparen_hi_surround_always = 1


"--------------------------------------------------------------------------------
" QFEnter
"--------------------------------------------------------------------------------
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>', '<2-LeftMouse>']
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-s>']
let g:qfenter_exclude_filetypes = ['NvimTree', 'aerial']


"--------------------------------------------------------------------------------
" vim-qf
"--------------------------------------------------------------------------------
let g:qf_shorten_path = 0
"nnoremap , <Plug>(qf_older)
"nnoremap . <Plug>(qf_newer)



"--------------------------------------------------------------------------------
" vim-go
"--------------------------------------------------------------------------------
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>doc <Plug>(go-doc)
au FileType go nmap gd <Plug>(go-def)
let g:go_fmt_command = "goimports"




"--------------------------------------------------------------------------------
" quick-ui
"--------------------------------------------------------------------------------
call quickui#menu#reset()
call quickui#menu#install("&Find", [
    \ [ "Search &File", 'exec input("", ":AckFile! ")'],
    \ [ "--", ],
    \ [ "Fzf &builtin", 'FzfLua builtin', ''],
    \ ])
call quickui#menu#install("&Git", [
    \ ['&Git', 'Git', ''],
    \ ['Git &Blame', 'Gblame', ''],
    \ ['Git &Diff', 'Git diff -p', ''],
    \ ['Git Diff &Split', 'Gdiffsplit', ''],
    \ ['Git L&og', 'Git log', ''],
    \ ])
call quickui#menu#install("F&ormat", [
    \ ['Show &Indent', '<leader><tab>', 'highlight indent'],
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
    \ ['&StartupTime', ':StartupTime', 'Times are in milliseconds'],
    \ ['&Vimrc', ':e $MYVIMRC', ''],
    \ ['Vim&Tips', ':e ~/GDrive/vim/vimtips.txt', ''],
    \ ])
call quickui#menu#install("&Window", [
    \ ['&Shell', 'terminal', ''],
    \ ['&Horizontal<->Vertical', 'lua swap_window_horizontal_vertical()', 'Horizontal to Vertical, vise versa'],
    \ ])
call quickui#menu#install("&Mason", [
    \ ['&Mason', 'Mason', ''],
    \ ['Mason &Update', 'MasonUpdate', ''],
    \ ['Mason &Install', 'exec input("", ":MasonInstall ")', ''],
    \ ['Mason &Uninstall', 'exec input("", ":MasonUninstall ")', ''],
    \ ['Mason &Log', 'MasonLog', ''],
    \ ['Mason &Bin', '!Open ~/.local/share/nvim/mason/bin', ''],
    \ ])
call quickui#menu#install("&Lsp", [
    \ ['L&spInfo', 'LspInfo', ''],
    \ ['LspLo&g', 'LspLog', ''],
    \ ['&InlayHint', 'lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())', ''],
    \ ])

nnoremap <silent><space><space> :call quickui#menu#open()<cr>
"
let g:context_menu_1= [
    \ ['&Lack', 'exec "Lack! -s -w " . expand("<cword>")'],
    \ [ "--", ],
    \ ["&Vim help", 'exec "h " . expand("<cword>")'],
    \ ]
nnoremap <silent><leader>qm :call quickui#context#open(g:context_menu_1, {})<cr>
"
let g:context_menu_qf= [
    \ ['&Save List', 'exec input("", ":SaveList ")'],
    \ ['Sa&ve List Add', 'exec input("", ":SaveListAdd ")'],
    \ ['&List Lists', 'ListLists'],
    \ ['L&oad Lists', 'exec input("", ":LoadList ")'],
    \ ['Lo&ad Lists Add', 'exec input("", ":LoadListAdd ")'],
    \ ['&Doline', 'exec input("", ":Doline ")'],
    \ ['Do&file', 'exec input("", ":Dofile ")'],
    \ ]
nnoremap <silent><leader>qf :call quickui#context#open(g:context_menu_qf, {})<cr>
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
