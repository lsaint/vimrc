-- Options
vim.opt.termguicolors = true
vim.opt.title = true
vim.opt.scrolloff = 2
vim.opt.shortmess = "a"
vim.opt.cmdheight = 2
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.hlsearch = true
vim.opt.hidden = true
vim.opt.expandtab = true
vim.opt.backspace = { "indent", "eol", "start" }
-- vim.opt.nocompatible -- Neovim is always nocompatible
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.fileencodings = { "ucs-bom", "utf-8", "gbk", "latin1" }

-- Fillchars
vim.opt.fillchars = { eob = " ", vert = " " }

-- Colorscheme (handled by lazy.nvim priority)
-- vim.cmd("colorscheme gruvbox")

-- Highlights
vim.api.nvim_set_hl(0, "Normal", {bg = "NONE", ctermbg = "NONE"})
vim.api.nvim_set_hl(0, "LineNr", {bg = "NONE", ctermbg = "NONE"})
vim.api.nvim_set_hl(0, "SignColumn", {bg = "NONE", ctermbg = "NONE"})
vim.api.nvim_set_hl(0, "VertSplit", {bg = "NONE", ctermbg = "NONE"})
vim.api.nvim_set_hl(0, "WinSeparator", {bg = "#3c3836"})

-- True color fix for terminal
vim.g.t_8f = [[<Esc>[38;2;%lu;%lu;%lum]]
vim.g.t_8b = [[<Esc>[48;2;%lu;%lu;%lum]]

-- IlluminatedWord
vim.cmd([[
  hi def IlluminatedWordText gui=underline guisp=#7aa697 cterm=underline
  hi def IlluminatedWordRead gui=underline guisp=#7aa697 cterm=underline
  hi def IlluminatedWordWrite gui=underline guisp=#7aa697 cterm=underline
]])

-- QuickScope
vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
vim.cmd([[ 
  highlight QuickScopePrimary guifg='#afff5f' gui=underline ctermfg=155 cterm=underline
  highlight QuickScopeSecondary guifg='#5fffff' gui=underline ctermfg=81 cterm=underline
]])

-- Matchup
vim.g.matchup_matchparen_deferred = 1

-- QFEnter
vim.g.qfenter_keymap = {
  open = { '<CR>', '<2-LeftMouse>' },
  vopen = { '<C-v>' },
  hopen = { '<C-s>' },
}
vim.g.qfenter_exclude_filetypes = { 'NvimTree', 'aerial' }

-- Vim-QF
vim.g.qf_shorten_path = 0

-- Vim-Go
vim.g.go_fmt_command = "goimports"

-- QuickUI
vim.g.quickui_show_tip = 1
vim.g.quickui_color_scheme = 'gruvbox'
vim.g.quickui_preview_w = 100
vim.g.quickui_preview_h = 15

-- Auto commands
local aucmd = vim.api.nvim_create_autocmd
aucmd("BufEnter", {
  pattern = "*",
  command = "let g:extension = expand('%:e')"
})

aucmd("FileType", {
  pattern = "go",
  callback = function()
    local map = function(keys, func) vim.keymap.set('n', keys, func, {buffer=true, remap=true}) end
    map("<Leader>i", "<Plug>(go-info)")
    map("<Leader>doc", "<Plug>(go-doc)")
    map("gd", "<Plug>(go-def)")
  end
})

aucmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set('n', '`', ':call quickui#tools#preview_quickfix()<cr>', {buffer=true, silent=true})
  end,
  group = vim.api.nvim_create_augroup("MyQuickfixPreview", { clear = true })
})

-- QuickUI Menus (Converted to Vimscript block for compatibility)
vim.cmd([[ 
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

  let g:context_menu_1= [
      \ ['&Lack', 'exec "Lack! -s -w " . expand("<cword>")'],
      \ [ "--", ],
      \ ["&Vim help", 'exec "h " . expand("<cword>")'],
      \ ]
  
  let g:context_menu_qf= [
      \ ['&Save List', 'exec input("", ":SaveList ")'],
      \ ['Sa&ve List Add', 'exec input("", ":SaveListAdd ")'],
      \ ['&List Lists', 'ListLists'],
      \ ['L&oad Lists', 'exec input("", ":LoadList ")'],
      \ ['Lo&ad Lists Add', 'exec input("", ":LoadListAdd ")'],
      \ ['&Doline', 'exec input("", ":Doline ")'],
      \ ['Do&file', 'exec input("", ":Dofile ")'],
      \ ]
]])


--------------------------------------------------------------------------------
-- Keymaps (Merged from keymaps.lua)
--------------------------------------------------------------------------------
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Win style save
map({ "n", "v", "i" }, "<C-S>", function()
    vim.cmd("update")
    if vim.fn.mode() == "i" then
        return "<C-o>:update<CR>" 
    end
end, { desc = "Save file" })
-- Correcting insert mode save:
vim.api.nvim_set_keymap("i", "<C-S>", "<C-o>:update<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<C-S>", ":update<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<C-S>", "<C-c>:update<CR>", { noremap = true, silent = true })

-- Resize windows
map("n", "<S-Down>", "<C-W>-", opts)
map("n", "<S-Up>", "<C-W>+", opts)
map("n", "<S-Left>", "<C-W><", opts)
map("n", "<S-Right>", "<C-W>>", opts)

-- Move windows
map("n", "<C-J>", "<C-W>j", opts)
map("n", "<C-K>", "<C-W>k", opts)
map("n", "<C-H>", "<C-W>h", opts)
map("n", "<C-L>", "<C-W>l", opts)
map("n", "<C-P>", "<C-W>p", opts)

map("n", "<C-W>j", "<C-W>J", opts)
map("n", "<C-W>k", "<C-W>K", opts)
map("n", "<C-W>l", "<C-W>L", opts)
map("n", "<C-W>h", "<C-W>H", opts)

map("n", "<C-1>", "1", opts)

-- Quit
map("n", "<C-C>", "<ESC>:q!<CR>", opts)

-- Copy to system clipboard
map("v", "<leader>y", '"*y', opts)

-- Tab navigation
map("n", "<tab>j", "}", opts)
map("n", "<tab>k", "{", opts)

-- Go to last file pos
map("n", "<leader>`", ":e#<CR>", opts)

-- Ack/Grep shortcuts
map("n", "<leader>1", ":Ack! --type python --glob !tests -s -w <C-r><C-w><cr>", { silent = false })
map("n", "<leader>2", ":Ack! -s -w ", { silent = false })
map("n", "<leader>3", ":Ack! --glob !static/ --glob !node_modules --glob !builds -s <C-r><C-w>", { silent = false })
map("n", "<leader>4", ":Ack! --glob !static/ --glob !node_modules --glob !builds --glob !*tests -s -w <C-r><C-w>", { silent = false })

-- Leader F mappings
map("n", "<leader><F2>", ":AerialToggle!<cr>", opts)
map("n", "<leader><F6>", ":NERDTreeClose<CR>|<Plug>(qf_qf_toggle)", { remap = true, silent = true })
map("n", "<leader><F7>", "<Plug>(qf_shorten_path_toggle)", { remap = true })
map("n", "<leader><F10>", ":bufdo! e<cr>", opts)
map("n", "<leader><F11>", ":vsplit $MYVIMRC<cr>", opts)
map("n", "<leader><F12>", ":source $MYVIMRC<cr>", opts)

-- Markview
map("n", "<leader>dd", ":Markview<cr>", opts)

-- Vim-matchup
map("n", "<leader>n", "z%", opts)

-- QuickUI Menus
map("n", "<space><space>", ":call quickui#menu#open()<cr>", { silent = true })
map("n", "<leader>qm", ":call quickui#context#open(g:context_menu_1, {})<cr>", { silent = true })
map("n", "<leader>qf", ":call quickui#context#open(g:context_menu_qf, {})<cr>", { silent = true })