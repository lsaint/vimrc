-------------------------------------------------------------------------------
--- common
-------------------------------------------------------------------------------
vim.g.python_host_prog = "/opt/homebrew/bin/python3"

-- exit terminal mode by pressing ESC
if vim.fn.exists(":tnoremap") == 2 then
    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")
end

-- always display diagnostic source
vim.diagnostic.config({
    --virtual_text = { source = true, prefix = "●" },
    virtual_text = false,
    float = { source = true, border = "rounded" },
})

local args = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>J", vim.lsp.buf.declaration, args)
vim.keymap.set("n", "<leader>j", vim.lsp.buf.definition, args)
--vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, args)
--vim.keymap.set("n", "<leader>qf", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>k", vim.diagnostic.goto_prev, args)
vim.keymap.set("n", "<leader>l", vim.diagnostic.goto_next, args)
vim.keymap.set("n", "<leader>i", function()
    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end)

-------------------------------------------------------------------------------
--- lsp
--- manson
-------------------------------------------------------------------------------
--:Mason
--:MasonLog
--:MasonUpdate
--:MasonInstall <package> ... - installs/re-installs @ ~/.local/share/nvim/mason/bin
--:MasonUninstall <package> ...
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "efm",
        "taplo", --toml
        "vimls",
        "vale_ls", --markdown
        "basedpyright",
        --"json-lsp",
        --"css-lsp",
        --"oxlint",
        --"bash-language-server",
        --"typescript-language-server",
    },
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
        },
    },
})
-- pip3.13 install sourcery==1.3.0 --break-system-packages
require("lspconfig").sourcery.setup({
    init_options = {
        token = "user_70Iu0e_MRFlAVLZu2n_7TPm0LdByn2W5bXJr1p49QCfRbC3q07nI8my1d8I",
        extension_version = "vim.lsp",
        editor_version = "nvim",
    },
})
require("lspconfig").jsonls.setup({
    init_options = {
        provideFormatter = false,
    },
})
-- brew install lua-language-server
require("lspconfig").lua_ls.setup({})
require("lspconfig").oxlint.setup({})
require("lspconfig").ts_ls.setup({})
require("lspconfig").cssls.setup({})
require("lspconfig").bashls.setup({})

-------------------------------------------------------------------------------
--- fzf-lua
-------------------------------------------------------------------------------
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
vim.keymap.set("n", "<leader>;", ":FzfLua builtin<cr>", args)
vim.keymap.set("n", "<leader>f", ":FzfLua files<cr>", args)
vim.keymap.set("n", "<leader>b", ":FzfLua buffers<cr>", args)
vim.keymap.set("n", "<leader>m", ":FzfLua oldfiles<cr>", args)
vim.keymap.set("n", "<leader>gb", ":FzfLua git_blame<cr>", args)
vim.keymap.set("v", "<leader>gb", ":FzfLua git_blame<cr>", args)

vim.keymap.set("n", "<leader>qf", ":FzfLua lsp_code_actions<cr>", args)
vim.keymap.set("n", "<leader>qi", ":FzfLua lsp_incoming_calls<cr>", args)
vim.keymap.set("n", "<leader>qo", ":FzfLua lsp_outgoing_calls<cr>", args)

-------------------------------------------------------------------------------
--- trouble.nvim
-------------------------------------------------------------------------------
require("trouble").setup({})
vim.keymap.set("n", "<leader>t", "<cmd>Trouble diagnostics toggle<cr>", args)

-------------------------------------------------------------------------------
--- treesitter
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
--- efm-langserver
--- partial format with lsp-format
--- https://www.reddit.com/r/neovim/comments/jvisg5/lets_talk_formatting_again/
-------------------------------------------------------------------------------
local default_settings = require("efmls-configs.defaults").languages()
require("lsp-format").setup({})
--- https://github.com/creativenull/efmls-configs-nvim/blob/main/doc/SUPPORTED_LIST.md
require("lspconfig").efm.setup({
    init_options = { documentFormatting = true, documentRangeFormatting = true },
    on_attach = require("lsp-format").on_attach,
    settings = {
        rootMarkers = { ".git/", "package.json" },
        languages = vim.tbl_extend("force", default_settings, {
            -- css/scss/less/sass: stylelint, prettier
            -- javascript/jsx typescript/tsx: eslint, prettier
            -- override default settings
            python = {
                require("efmls-configs.formatters.ruff"),
                require("efmls-configs.formatters.ruff_sort"),
            },
            lua = {
                require("efmls-configs.formatters.stylua"),
            },
            json = {
                require("efmls-configs.formatters.prettier"),
            },
            jsonc = {
                require("efmls-configs.formatters.prettier"),
            },
            markdown = {
                require("efmls-configs.formatters.mdformat"),
            },
            toml = {
                require("efmls-configs.formatters.taplo"),
            },
            yaml = {
                require("efmls-configs.formatters.prettier"),
            },
            sh = {
                require("efmls-configs.formatters.shfmt"),
            },
        }),
    },
})

-------------------------------------------------------------------------------
--- stickybuf: locking a buffer to a window
-------------------------------------------------------------------------------
require("stickybuf").setup()

-------------------------------------------------------------------------------
--- aerial.nvim: code outline
-------------------------------------------------------------------------------
require("aerial").setup()

-------------------------------------------------------------------------------
--- indent-blankline
-------------------------------------------------------------------------------
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
vim.keymap.set("n", "<leader><tab>", toggle_ibl, { silent = true })

-------------------------------------------------------------------------------
--- dap
-------------------------------------------------------------------------------
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
end, { silent = true })
vim.keymap.set("n", "<F7>", function()
    require("dap").toggle_breakpoint()
end, { silent = true })
vim.keymap.set("n", "<F8>", function()
    require("dap").step_over()
end, { silent = true })
vim.keymap.set("n", "<F9>", function()
    require("dap").step_into()
end, { silent = true })
vim.keymap.set("n", "<leader><F5>", function()
    require("dap").step_out()
end, { silent = true })
vim.keymap.set("n", "<F5>", function()
    require("dapui").toggle({ reset = true })
end, { silent = true })
vim.keymap.set("n", "<leader>dh", function()
    require("dap.ui.widgets").hover()
end, { silent = true })
vim.keymap.set("v", "<leader>ds", function()
    require("dap-python").debug_selection()
end, { silent = true })
vim.keymap.set("n", "<leader>df", function()
    require("dapui").float_element()
end, { silent = true })

-------------------------------------------------------------------------------
--- mini.animate
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
--- front-end
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "dart", "ts", "tsx", "jsx", "js", "html", "css", "json", "yaml" },
    callback = function()
        vim.opt.tabstop = 2
        vim.opt.shiftwidth = 2
    end,
})

-- Prettier
vim.g["prettier#autoformat"] = 1
vim.g["prettier#autoformat_require_pragma"] = 0

--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
--                       Custom Functions
--↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

-------------------------------------------------------------------------------
--- Highlight and ready to search current word
-------------------------------------------------------------------------------
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

vim.keymap.set("n", "<F1>", highlight_search, { noremap = true, silent = true })

-------------------------------------------------------------------------------
--- Highlight the word while cursor is moving on it
-------------------------------------------------------------------------------
function highlight_cursor_area() -- luacheck: ignore
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
        vim.api.nvim_buf_add_highlight(
            bufnr,
            ns_id,
            highlight_group,
            row,
            start_col,
            end_col
        )
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

-------------------------------------------------------------------------------
--- toggle my tips in preview window
-------------------------------------------------------------------------------
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
vim.keymap.set("n", "<leader><F8>", toggle_vim_tips, { noremap = true })

-------------------------------------------------------------------------------
--- go to next ([{< in current line
-------------------------------------------------------------------------------
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

-------------------------------------------------------------------------------
--- fold/unfold python docstring
-------------------------------------------------------------------------------
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

vim.keymap.set("n", "<leader><F9>", TogglePyDocString, { noremap = true, silent = true })

-------------------------------------------------------------------------------
--- ZoomToggle for current window
-------------------------------------------------------------------------------
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
vim.keymap.set("n", "<F3>", ZoomToggle, { silent = true })

-------------------------------------------------------------------------------
--- swap last two buffers
-------------------------------------------------------------------------------
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

vim.keymap.set("n", "<leader>sw", win_buf_swap, { silent = true })

-------------------------------------------------------------------------------
--- Horizontal to Vertical, vise versa
-------------------------------------------------------------------------------
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

vim.keymap.set("n", "<leader>vh", swap_window_horizontal_vertical, { silent = true })

-------------------------------------------------------------------------------
--- test
-------------------------------------------------------------------------------
local function test()
    print("Hello World!")
end
vim.keymap.set("n", "<F12>", test, { noremap = true, silent = true })
