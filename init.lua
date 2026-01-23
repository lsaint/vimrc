-- 1. Set Leader keys (MUST be before lazy setup)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Setup lazy.nvim with plugin list
require("lazy").setup({
    -- UI & Editor
    "ibhagwan/fzf-lua",
    "lukas-reineke/indent-blankline.nvim",
    "editorconfig/editorconfig-vim",
    "markonm/traces.vim",
    "nvim-tree/nvim-tree.lua",
    "tpope/vim-surround",
    "scrooloose/nerdcommenter",
    "unblevable/quick-scope",
    "skywind3000/vim-quickui",
    "andymass/vim-matchup",
    "RRethy/vim-illuminate",
    "echasnovski/mini.animate",
    "stevearc/stickybuf.nvim",
    "stevearc/aerial.nvim",
    "nvim-lualine/lualine.nvim",
    "nvim-tree/nvim-web-devicons",
    {
        "morhetz/gruvbox",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd("colorscheme gruvbox")
        end,
    },

    -- Git
    "lewis6991/gitsigns.nvim",
    "kdheepak/lazygit.nvim",

    -- Quickfix
    "folke/trouble.nvim",
    "kevinhwang91/nvim-bqf",
    "romainl/vim-qf",
    "wincent/ferret",
    "yssl/QFEnter",

    -- AI
    "zbirenbaum/copilot.lua",
    "nvim-lua/plenary.nvim",
    "CopilotC-Nvim/CopilotChat.nvim",

    -- Completion
    { "saghen/blink.cmp", version = "1.*" },
    "fang2hou/blink-copilot",

    -- Debug (DAP)
    "mfussenegger/nvim-dap",
    { "mfussenegger/nvim-dap-python", ft = "python" },
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",

    -- LSP
    "neovim/nvim-lspconfig",
    "creativenull/efmls-configs-nvim",
    "lukas-reineke/lsp-format.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "rmagatti/goto-preview",

    -- Language
    "OXY2DEV/markview.nvim",
    "mracos/mermaid.vim",
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate", branch = "main" },
}, {
    defaults = { lazy = false },
    ui = { border = "rounded" },
})

--
require("options")

local user_grp = vim.api.nvim_create_augroup("LazyUserGroup", { clear = true })

-- Toggle Lazy UI
local function toggle_lazy()
    local found = false
    for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        -- Compat: use nvim_get_option_value if available, else buf_get_option
        local ft = vim.api.nvim_get_option_value
                and vim.api.nvim_get_option_value("filetype", { buf = buf })
            or vim.api.nvim_buf_get_option(buf, "filetype")
        if ft == "lazy" then
            vim.api.nvim_win_close(win, true)
            found = true
            break
        end
    end
    if not found then
        vim.cmd("Lazy")
    end
end
vim.keymap.set("n", "<F10>", toggle_lazy, { desc = "Toggle Lazy UI" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "lazy",
    desc = "Quit lazy with <esc>",
    callback = function()
        vim.keymap.set("n", "<esc>", function()
            vim.api.nvim_win_close(0, false)
        end, { buffer = true, nowait = true })
    end,
    group = user_grp,
})

require("config")
