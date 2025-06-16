--------------------------------------------------------------------------------------------
--- common
--------------------------------------------------------------------------------------------
vim.g.python_host_prog = "/opt/homebrew/bin/python3"
--vim.o.winborder = "rounded"

-- exit terminal mode by pressing ESC
if vim.fn.exists(":tnoremap") == 2 then
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
end

-- always display diagnostic source
vim.diagnostic.config({
    --virtual_text = { source = true, prefix = "●" },
    virtual_text = false,
    float = { source = true },
})

local hightlight_ignore_list = {
    "qf",
    "NvimTree",
    "help",
    "checkhealth",
    "aerial",
    "trouble",
    "dap-repl",
    "dapui_scopes",
    "dapui_stacks",
    "dapui_watches",
}

local args = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>J", vim.lsp.buf.declaration, args)
vim.keymap.set("n", "<leader>j", vim.lsp.buf.definition, args)
--vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, args)
--vim.keymap.set("n", "<leader>qf", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev, args)
vim.keymap.set("n", "<leader>l", vim.diagnostic.goto_next, args)
vim.keymap.set("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end, args)
vim.keymap.set("n", "<leader>qh", vim.lsp.buf.signature_help, args)

--------------------------------------------------------------------------------------------
--- copilot.lua
--------------------------------------------------------------------------------------------
require("copilot").setup({
    suggestion = {
        auto_trigger = true,
        keymap = {
            accept_word = "<C-K>",
            accept_line = "<C-l>",
            accept = "<C-;>",
            dismiss = "<C-'>",
            next = "<C-n>",
            prev = "<C-p>",
        },
    },
    panel = {
        keymap = {},
    },
    filetypes = {
        gitcommit = true,
        markdown = true,
        yaml = true,
        --["."] = false,
    },
})
-- todo: file size check

--------------------------------------------------------------------------------------------
--- CopilotChat.nvim
--------------------------------------------------------------------------------------------
local select = require("CopilotChat.select")
require("CopilotChat").setup({
    model = "claude-sonnet-4",
    selection = function(source)
        return select.visual(source) or select.buffer(source)
    end,
    highlight_selection = false,
    mappings = {},
})
vim.keymap.set({ "n", "x" }, "<tab><tab>", "<Esc>:CopilotChatToggle<cr>", args)
vim.keymap.set("n", "<tab>p", ":CopilotChatPrompts<cr>", args)
vim.keymap.set("n", "<tab>m", ":CopilotChatModels<cr>", args)

--------------------------------------------------------------------------------------------
--- blink.cmp
--------------------------------------------------------------------------------------------
require("blink.cmp").setup({
    sources = {
        default = { "copilot", "lsp", "path", "buffer" },
        providers = {
            copilot = {
                name = "copilot",
                module = "blink-copilot",
                --score_offset = 10,
                async = true,
            },
        },
    },
    completion = {
        list = { selection = { preselect = false, auto_insert = false } },
        menu = { auto_show = false },
        --ghost_text = { enabled = true },
    },
    signature = { enabled = true },
    keymap = {
        ["<C-j>"] = { "show" },
        ["<enter>"] = { "accept", "fallback" },
        ["<C-;>"] = { "cancel", "fallback" },
        ["<C-k>"] = {},
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning",
        prebuilt_binaries = {
            download = true,
            -- https://github.com/saghen/blink.cmp/releases/
            -- force_version = "v1.3.1",
        },
    },
})

--------------------------------------------------------------------------------------------
--- nvim-tree
--------------------------------------------------------------------------------------------
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.keymap.set("n", "<leader>z", ":NvimTreeFindFile<cr>", args)
vim.keymap.set("n", "<F2>", ":NvimTreeToggle<cr>", args)
vim.cmd("autocmd FileType NvimTree nnoremap <buffer> <silent> <Esc> :NvimTreeClose<CR>")
require("nvim-tree").setup({
    on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
            return {
                desc = "nvim-tree: " .. desc,
                buffer = bufnr,
                noremap = true,
                silent = true,
                nowait = true,
            }
        end
        -- load default mappings
        api.config.mappings.default_on_attach(bufnr)
        -- remove default mappings
        local keys_to_delete = { "m", "M", "S", "s", "<C-v>", "<C-x>", "bmv" }
        for _, key in ipairs(keys_to_delete) do
            vim.keymap.del("n", key, { buffer = bufnr })
        end
        -- set custom mappings
        vim.keymap.set("n", "bo", api.tree.toggle_no_bookmark_filter, opts("Toggle Bookmark only"))
        vim.keymap.set("n", "bv", api.marks.bulk.move, opts("Move Bookmarked"))
        vim.keymap.set("n", "bm", api.marks.toggle, opts("Toggle Bookmark"))
        vim.keymap.set("n", "S", api.node.run.system, opts("Run System"))
        vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "s", api.node.open.horizontal, opts("Open: Horizontal Split"))
    end,

    filters = {
        dotfiles = true,
    },
})
-- close nvim when nvim-tree is the last window
vim.api.nvim_create_autocmd("BufEnter", {
    nested = true,
    callback = function()
        if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
            vim.cmd("quit")
        end
    end,
})

--------------------------------------------------------------------------------------------
--- nvim-bqf
--- https://github.com/kevinhwang91/nvim-bqf?tab=readme-ov-file#function-table
--------------------------------------------------------------------------------------------
require("bqf").setup({
    func_map = {
        ptoggleitem = "<esc>",
    },
})

--------------------------------------------------------------------------------------------
--- lsp
--- manson
--------------------------------------------------------------------------------------------
--:Mason
--:MasonLog
--:MasonUpdate
--:MasonInstall <package> ... - installs/re-installs @ ~/.local/share/nvim/mason/bin
--:MasonUninstall <package> ...
require("mason").setup()
require("mason-lspconfig").setup({
    -- name list: https://github.com/williamboman/mason-lspconfig.nvim
    ensure_installed = {
        "efm",
        "taplo", -- toml
        "vimls",
        "lua_ls",
        "vale_ls", -- markdown
        "basedpyright",
        "jsonls",
        "cssls",
        "ts_ls",
        "bashls", -- need `shellcheck` to lint
        --"shellcheck",
        --"oxlint",
    },
    automatic_enable = false,
})
-- lsp list
-- https://mason-registry.dev/registry/list
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
require("lspconfig").taplo.setup({})
require("lspconfig").vimls.setup({})
require("lspconfig").vale_ls.setup({})
require("lspconfig").basedpyright.setup({})
require("lspconfig").ruff.setup({
    init_options = {
        settings = {
            lint = { enable = true },
            fixAll = false,
            organizeImports = false,
        },
    },
})
-- pip3.13 install sourcery==1.3.0 --break-system-packages
local sourcery_token = os.getenv("SOURCERY_TOKEN")
require("lspconfig").sourcery.setup({
    init_options = {
        token = sourcery_token,
        extension_version = "vim.lsp",
        editor_version = "nvim",
    },
})
require("lspconfig").jsonls.setup({
    init_options = {
        provideFormatter = false,
    },
})
require("lspconfig").lua_ls.setup({})
require("lspconfig").oxlint.setup({})
require("lspconfig").ts_ls.setup({})
require("lspconfig").cssls.setup({})
require("lspconfig").bashls.setup({ filetypes = { "zsh", "bash", "sh" } })

vim.keymap.set("n", "<leader>dt", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
end, vim.tbl_extend("force", args, { desc = "toggle diagnostic" }))

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(_args)
        local bufnr = _args.buf
        local filename = vim.api.nvim_buf_get_name(bufnr)

        local disable_lsp_filenames = {
            "local.env",
            "another_file_to_ignore.log",
            "temp_data_.*%.json",
        }

        local disable_lsp_folders = {
            "/path/to/your/project/node_modules/",
            "/var/log/",
            "~/.cache/nvim/",
        }

        local function is_filename_in_list(file_path, list)
            for _, pattern in ipairs(list) do
                if file_path == pattern then
                    return true
                end
                if file_path:match(pattern) then
                    return true
                end
            end
            return false
        end

        local function is_file_in_folder_list(file_path, folder_list)
            local normalized_file_path = vim.fn.fnamemodify(file_path, ":p")

            for _, folder_path in ipairs(folder_list) do
                local expanded_folder_path = folder_path:gsub("^~", vim.fn.expand("~"))
                if
                    not expanded_folder_path:match("/$") and not expanded_folder_path:match("\\$")
                then
                    expanded_folder_path = expanded_folder_path .. "/"
                end

                if normalized_file_path:sub(1, #expanded_folder_path) == expanded_folder_path then
                    return true
                end
            end
            return false
        end

        local should_disable_lsp = false

        if is_filename_in_list(filename, disable_lsp_filenames) then
            should_disable_lsp = true
        end

        if not should_disable_lsp and is_file_in_folder_list(filename, disable_lsp_folders) then
            should_disable_lsp = true
        end

        local ok, stats = pcall(vim.loop.fs_stat, filename)
        if ok and stats and stats.size > 1024 * 1024 then
            should_disable_lsp = true
        end

        if should_disable_lsp then
            vim.schedule(function()
                for _, client in pairs(vim.lsp.get_active_clients({ bufnr = bufnr })) do
                    vim.lsp.buf_detach_client(bufnr, client.id)
                end
                vim.diagnostic.disable(bufnr)
                print("LSP disabled for: " .. filename)
            end)
        end
    end,
})

--------------------------------------------------------------------------------------------
--- efm-langserver
--- partial FORMAT with lsp-format
--- https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
--- https://github.com/creativenull/efmls-configs-nvim/blob/main/doc/SUPPORTED_LIST.md
--------------------------------------------------------------------------------------------
local default_settings = require("efmls-configs.defaults").languages()
local formatter_prettier = { require("efmls-configs.formatters.prettier") }
local formatter_shfmt = { require("efmls-configs.formatters.shfmt") }
require("lsp-format").setup({})
require("lspconfig").efm.setup({
    init_options = { documentFormatting = true, documentRangeFormatting = true },
    on_attach = require("lsp-format").on_attach,
    settings = {
        rootMarkers = { ".git/" },
        languages = vim.tbl_extend("force", default_settings, {
            -- css/scss/less/sass: stylelint, prettier
            -- javascript/jsx typescript/tsx: eslint, prettier
            -- override default settings
            yaml = formatter_prettier,
            json = formatter_prettier,
            jsonc = formatter_prettier,

            -- brew install djlint
            htmldjango = {
                require("efmls-configs.linters.djlint"),
                require("efmls-configs.formatters.djlint"),
            },

            -- brew install shfmt
            -- using .editorconfig
            sh = formatter_shfmt,
            zsh = formatter_shfmt,

            lua = { require("efmls-configs.formatters.stylua") },
            toml = { require("efmls-configs.formatters.taplo") },
            markdown = { require("efmls-configs.formatters.mdformat") },
            python = {
                require("efmls-configs.formatters.ruff_sort"),
                require("efmls-configs.formatters.ruff"),
            },
        }),
    },
})

--------------------------------------------------------------------------------------------
--- fzf-lua
--------------------------------------------------------------------------------------------
-- brew install fzf, fd
require("fzf-lua").setup({
    defaults = {
        file_icons = "devicons",
    },
    keymap = {
        builtin = {
            ["<C-U>"] = "preview-page-up",
            ["<C-D>"] = "preview-page-down",
        },
    },
    winopts = {
        height = 0.65,
        width = 0.80,
        row = 0.75,
        col = 0.60,
    },
})
require("fzf-lua").register_ui_select()

vim.keymap.set("n", "<leader>;", ":FzfLua builtin<cr>", args)
vim.keymap.set("n", "<leader>f", ":FzfLua files<cr>", args)
vim.keymap.set("n", "<leader>F", ":FzfLua files hidden=false no_ignore=true follow=true<cr>", args)
vim.keymap.set("n", "<leader>b", ":FzfLua buffers<cr>", args)
vim.keymap.set("n", "<leader>m", ":FzfLua oldfiles<cr>", args)
vim.keymap.set("n", "<leader>gb", ":FzfLua git_blame<cr>", args)
vim.keymap.set("n", "<leader>co", ":FzfLua commands<cr>", args)
vim.keymap.set("n", "<leader>ch", ":FzfLua command_history<cr>", args)

vim.keymap.set("n", "<leader>a", ":FzfLua lsp_code_actions<cr>", args)
vim.keymap.set("n", "<leader>qi", ":FzfLua lsp_incoming_calls<cr>", args)
vim.keymap.set("n", "<leader>qo", ":FzfLua lsp_outgoing_calls<cr>", args)

vim.keymap.set("n", "1", ":FzfLua lsp_references<cr>", args)
vim.keymap.set("n", "<C-2>", ":FzfLua grep_cword<cr>", args)
vim.keymap.set("n", "<C-3>", ":FzfLua grep<cr>", args)
vim.keymap.set("n", "<C-4>", ":FzfLua live_grep<cr>", args)

--------------------------------------------------------------------------------------------
--- trouble.nvim
--------------------------------------------------------------------------------------------
require("trouble").setup({})
vim.keymap.set("n", "<leader>t", "<cmd>Trouble diagnostics toggle<cr>", args)

--------------------------------------------------------------------------------------------
--- treesitter
--------------------------------------------------------------------------------------------
require("nvim-treesitter.configs").setup({
    ensure_installed = {
        "python",
        "c",
        "lua",
        "bash",
        "typescript",
        "javascript",
        "css",
        "html",
        "json",
        "toml",
        "yaml",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
    },
})

--------------------------------------------------------------------------------------------
--- goto-preview: show lsp information in floating windows
--------------------------------------------------------------------------------------------
require("goto-preview").setup({ opacity = 10 })

vim.keymap.set("n", "`", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", args)
vim.keymap.set("n", "<esc>", "<cmd>lua require('goto-preview').close_all_win()<CR>", args)

--------------------------------------------------------------------------------------------
--- stickybuf: locking a buffer to a window
--------------------------------------------------------------------------------------------
require("stickybuf").setup()

--------------------------------------------------------------------------------------------
--- aerial.nvim: code outline
--------------------------------------------------------------------------------------------
require("aerial").setup()

--------------------------------------------------------------------------------------------
--- indent-blankline
--------------------------------------------------------------------------------------------
local hooks = require("ibl.hooks")
hooks.register(hooks.type.VIRTUAL_TEXT, function(_, _, _, virt_text)
    -- replace the first column indent with a whitespace character
    if virt_text[1] and virt_text[1][1] == "▎" then
        virt_text[1] = { " ", { "@ibl.whitespace.char.1" } }
    end
    return virt_text
end)

local ibl_enabled = true
local ibl_config = { scope = { enabled = false } }
require("ibl").setup(vim.tbl_extend("force", ibl_config, { enabled = ibl_enabled }))
local function toggle_ibl()
    ibl_enabled = not ibl_enabled
    require("ibl").setup(vim.tbl_extend("force", ibl_config, { enabled = ibl_enabled }))
end
vim.keymap.set("n", "<leader><tab>", toggle_ibl, args)

--------------------------------------------------------------------------------------------
--- gitsigns.nvim
--------------------------------------------------------------------------------------------
require("gitsigns").setup()

vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#859900", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#b58900", bg = "NONE" })
vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#dc322f", bg = "NONE" })

--------------------------------------------------------------------------------------------
--- dap
--------------------------------------------------------------------------------------------
require("dap-python").setup("uv")

require("dapui").setup({
    layouts = {
        {
            elements = { {
                id = "repl",
            } },
            position = "bottom",
            size = 10,
        },
        {
            elements = {
                {
                    id = "scopes",
                    size = 0.34,
                },
                {
                    id = "breakpoints",
                    size = 0.33,
                },
                {
                    id = "watches",
                    size = 0.33,
                },
            },
            position = "left",
            size = 40,
        },
    },
})

table.insert(require("dap").configurations.python, {
    type = "python",
    request = "launch",
    name = "DoxTurbo Uvicorn",
    program = "/Users/lsaint/com/doxturbo/run_uvicorn.py",
})

table.insert(require("dap").configurations.python, {
    type = "python",
    request = "launch",
    name = "DoxTurbo Celery",
    program = "/Users/lsaint/com/doxturbo/run_celery.py",
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })

vim.keymap.set("n", "<F6>", function()
    require("dap").continue()
end, args)
vim.keymap.set("n", "<F7>", function()
    require("dap").toggle_breakpoint()
end, args)
vim.keymap.set("n", "<F8>", function()
    require("dap").step_over()
end, args)
vim.keymap.set("n", "<F9>", function()
    require("dap").step_into()
end, args)
vim.keymap.set("n", "<leader><F5>", function()
    require("dap").step_out()
end, args)
vim.keymap.set("n", "<F5>", function()
    require("dapui").toggle({ reset = true })
end, args)
vim.keymap.set("n", "<leader>dh", function()
    require("dap.ui.widgets").hover()
end, args)
vim.keymap.set("v", "<leader>ds", function()
    require("dap-python").debug_selection()
end, args)
vim.keymap.set("n", "<leader>df", function()
    require("dapui").float_element()
end, args)

--------------------------------------------------------------------------------------------
--- mini.animate
--------------------------------------------------------------------------------------------
local animate = require("mini.animate")
require("mini.animate").setup({
    open = { enable = false },
    close = { enable = false },
    cursor = { enable = false },
    scroll = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 200, unit = "total" }),
    },
})

--------------------------------------------------------------------------------------------
--- lualine
--------------------------------------------------------------------------------------------
require("lualine").setup({
    options = {
        ignore_focus = hightlight_ignore_list,
    },
})

--------------------------------------------------------------------------------------------
--- vim-illuminate: underline
--------------------------------------------------------------------------------------------
require("illuminate").configure({ filetypes_denylist = hightlight_ignore_list })

--------------------------------------------------------------------------------------------
--- front-end
--------------------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
    pattern = {
        "ts",
        "js",
        "tsx",
        "jsx",
        "css",
        "less",
        "html",
        "json",
        "yaml",
        "toml",
        "dart",
    },
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end,
})

--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
--                               Custom Functions
--------------------------------------------------------------------------------------------
--- Highlight and ready to search current word
--------------------------------------------------------------------------------------------
local highlighting = false
local function highlight_search()
    local current_word = vim.fn.expand("<cword>")
    local search_pattern = "\\<" .. current_word .. "\\>"
    local current_search = vim.fn.getreg("/")

    if highlighting and current_search == search_pattern then
        highlighting = false
        vim.cmd("silent nohlsearch")
    else
        vim.fn.setreg("/", search_pattern)
        highlighting = true
        vim.cmd("silent set hlsearch")
    end
end

vim.keymap.set("n", "<F1>", highlight_search, args)

--------------------------------------------------------------------------------------------
--- toggle quickfix window
--------------------------------------------------------------------------------------------
vim.keymap.set("n", "<F4>", function()
    local qf_win = vim.fn.getqflist({ winid = 0 }).winid
    if qf_win ~= 0 then
        vim.cmd("cclose")
    else
        vim.cmd("copen")
    end
end, { desc = "Toggle Quickfix" }, args)

--------------------------------------------------------------------------------------------
--- Highlight the word while cursor is moving on it
--------------------------------------------------------------------------------------------
function highlight_cursor_area() -- luacheck: ignore
    local current_filetype = vim.api.nvim_buf_get_option(0, "filetype")
    if vim.list_contains(hightlight_ignore_list, current_filetype) then
        return
    end
    local winid = vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_win_get_buf(winid)
    local cursor_pos = vim.api.nvim_win_get_cursor(winid)
    local row = cursor_pos[1] - 1 -- 0-based row index

    local start_pos = vim.fn.searchpos("\\<", "bcn")
    local end_pos = vim.fn.searchpos("\\>", "cn")

    local ns_id = vim.api.nvim_create_namespace("cursor_word")

    if start_pos[1] == row + 1 and end_pos[1] == row + 1 then
        local start_col = start_pos[2] - 1
        local end_col = end_pos[2] - 1

        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

        local highlight_group = "CursorWord"
        vim.api.nvim_buf_add_highlight(bufnr, ns_id, highlight_group, row, start_col, end_col)
    else
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    end
end

vim.api.nvim_command([[
  highlight CursorWord guibg=#585858
]])
vim.api.nvim_command([[
  autocmd CursorMoved * call luaeval('highlight_cursor_area()')
]])

--------------------------------------------------------------------------------------------
--- toggle my tips in preview window
--------------------------------------------------------------------------------------------
vim.g.MyVimTips = "off"
local function toggle_vim_tips()
    if vim.g.MyVimTips == "on" then
        vim.g.MyVimTips = "off"
        vim.cmd("pclose")
    else
        vim.g.MyVimTips = "on"
        vim.cmd("pedit ~/Library/CloudStorage/Dropbox/vim/vimtips.txt")
    end
end
vim.keymap.set("n", "<leader><F8>", toggle_vim_tips, args)

--------------------------------------------------------------------------------------------
--- go to next ([{< in current line
--------------------------------------------------------------------------------------------
local enclosure = {
    left = { "(", "[", "{", "<" },
    right = { ")", "]", "}", ">" },
}

-- Move cursor to next/previous enclosure symbol
local function goto_enclosure(direction, side)
    local line = vim.api.nvim_get_current_line()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local row, col = cursor[1], cursor[2]
    col = col + 1 -- Convert to 1-based index
    local enc = (side == 0) and enclosure.left or enclosure.right
    local step = (direction == 0) and 1 or -1
    local start = (direction == 0) and (col + 1) or (col - 1)
    local stop = (direction == 0) and #line or 1
    for i = start, stop, step do
        local c = line:sub(i, i)
        if vim.tbl_contains(enc, c) then
            vim.api.nvim_win_set_cursor(0, { row, i - 1 }) -- Convert back to 0-based index
            return true
        end
    end
    return false
end

-- Try moving cursor to enclosure on both sides
local function goto_enclosure_dual(direction)
    local another_side = (direction == 0) and 1 or 0
    if not goto_enclosure(direction, 0) then
        goto_enclosure(direction, another_side)
    end
end

vim.keymap.set("n", "<tab>l", function()
    goto_enclosure_dual(0)
end, { silent = true })
vim.keymap.set("n", "<tab>h", function()
    goto_enclosure_dual(1)
end, { silent = true })

--------------------------------------------------------------------------------------------
--- fold/unfold python docstring
--------------------------------------------------------------------------------------------
function PyFoldDocString()
    vim.opt_local.foldmethod = "manual"
    vim.cmd([[
python3 << EOF
import vim
import ast

lines = vim.current.buffer[:]
docstring_start_lines = []
root = ast.parse("\n".join(lines))
for node in ast.walk(root):
    if isinstance(node, (ast.FunctionDef, ast.ClassDef, ast.Module)):
        if (node.body and isinstance(node.body[0], ast.Expr) and isinstance(node.body[0].value, ast.Str)):
            start = node.body[0].value.lineno
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
]])
end

function TogglePyDocString()
    if vim.b.py_docstring_state == nil or vim.b.py_docstring_state == 0 then
        PyFoldDocString()
        vim.b.py_docstring_state = 1
    else
        vim.cmd("normal! zr")
        vim.b.py_docstring_state = 0
    end
end

vim.keymap.set("n", "<leader><F9>", TogglePyDocString, args)

--------------------------------------------------------------------------------------------
--- ZoomToggle for current window
--------------------------------------------------------------------------------------------
function ZoomToggle()
    if vim.t.zoomed and vim.t.zoomed == 1 then
        vim.cmd(vim.t.zoom_winrestcmd)
        vim.t.zoomed = 0
    else
        vim.t.zoom_winrestcmd = vim.fn.winrestcmd()
        vim.cmd("resize")
        vim.cmd("vertical resize")
        vim.t.zoomed = 1
    end
end

-- :lua ZoomToggle()<CR>
vim.keymap.set("n", "<F3>", ZoomToggle, args)

--------------------------------------------------------------------------------------------
--- swap last two buffers
--------------------------------------------------------------------------------------------
function win_buf_swap()
    local thiswin = vim.fn.winnr() -- Get the current window number
    local thisbuf = vim.fn.bufnr("%") -- Get the current buffer number
    local lastwin = vim.fn.winnr("#") -- Get the last window number
    local lastbuf = vim.fn.winbufnr(lastwin) -- Get the buffer number in the last window

    -- Switch to the last window and open the current buffer
    vim.cmd(lastwin .. " wincmd w | buffer " .. thisbuf)
    -- Switch back to the current window and open the last window's buffer
    vim.cmd(thiswin .. " wincmd w | buffer " .. lastbuf)

    vim.opt.number = false
end

vim.keymap.set("n", "<leader>sw", win_buf_swap, args)

--------------------------------------------------------------------------------------------
--- Horizontal to Vertical, vise versa
--------------------------------------------------------------------------------------------
local split_type = "vertical"

function swap_window_horizontal_vertical()
    if split_type == "vertical" then
        vim.cmd("windo wincmd K")
        split_type = "horizontal"
    else
        vim.cmd("windo wincmd H")
        split_type = "vertical"
    end
end

vim.keymap.set("n", "<leader>vh", swap_window_horizontal_vertical, args)

--------------------------------------------------------------------------------------------
--- test
--------------------------------------------------------------------------------------------
local function test()
    print("Hello World!")
end
vim.keymap.set("n", "<F12>", test, args)
