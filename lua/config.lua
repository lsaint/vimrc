-------------------------------------------------------------------------------
--- common
-------------------------------------------------------------------------------


-- win style save
vim.keymap.set("n", "<C-S>", ":update<CR>", { silent = true })
vim.keymap.set("v", "<C-S>", "<C-c>:update<CR>", { silent = true })
vim.keymap.set("i", "<C-S>", "<ESC>:update<CR>", { silent = true })

-- resize windows
vim.keymap.set("n", "<S-Down>", "<C-W>-", { silent = true })
vim.keymap.set("n", "<S-Up>", "<C-W>+", { silent = true })
vim.keymap.set("n", "<S-Left>", "<C-W><", { silent = true })
vim.keymap.set("n", "<S-Right>", "<C-W>>", { silent = true })

-- windows navigation
vim.keymap.set("n", "<C-J>", "<C-W>j", { silent = true })
vim.keymap.set("n", "<C-K>", "<C-W>k", { silent = true })
vim.keymap.set("n", "<C-H>", "<C-W>h", { silent = true })
vim.keymap.set("n", "<C-L>", "<C-W>l", { silent = true })
vim.keymap.set("n", "<C-P>", "<C-W>p", { silent = true })

-- quit
vim.keymap.set("n", "<C-C>", "<ESC>:q!<CR>", { silent = true })

vim.g.python_host_prog = '/opt/homebrew/bin/python3'

-- exit terminal mode by pressing ESC
if vim.fn.exists(':tnoremap') == 2 then
    vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
end


-------------------------------------------------------------------------------
--- dap
-------------------------------------------------------------------------------
require('dap-python').setup('uv')

require("dapui").setup({
    layouts = { {
        elements = { {
            id = "repl",
        } },
        position = "bottom",
        size = 10
    }, {
        elements = { {
            id = "scopes",
            size = 0.34,
        }, {
            id = "breakpoints",
            size = 0.33,
        }, {
            id = "watches",
            size = 0.33,
        } },
        position = "left",
        size = 40
    },
    },
})

table.insert(require('dap').configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'DoxTurbo Uvicorn',
    program = '/Users/lsaint/com/doxturbo/run_uvicorn.py',
})

table.insert(require('dap').configurations.python, {
    type = 'python',
    request = 'launch',
    name = 'DoxTurbo Celery',
    program = '/Users/lsaint/com/doxturbo/run_celery.py',
})

local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
    dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
    dapui.open()
end
vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '▶️', texthl = '', linehl = '', numhl = '' })

vim.keymap.set("n", "<F6>", function() require("dap").continue() end, { silent = true })
vim.keymap.set("n", "<F7>", function() require("dap").toggle_breakpoint() end, { silent = true })
vim.keymap.set("n", "<F8>", function() require("dap").step_over() end, { silent = true })
vim.keymap.set("n", "<F9>", function() require("dap").step_into() end, { silent = true })
vim.keymap.set("n", "<leader><F5>", function() require("dap").step_out() end, { silent = true })
vim.keymap.set("n", "<F5>", function() require("dapui").toggle({ reset = true }) end, { silent = true })
vim.keymap.set("n", "<leader>dh", function() require("dap.ui.widgets").hover() end, { silent = true })
vim.keymap.set("v", "<leader>ds", function() require("dap-python").debug_selection() end, { silent = true })
vim.keymap.set("n", "<leader>df", function() require("dapui").float_element() end, { silent = true })


-------------------------------------------------------------------------------
--- mini.animate
-------------------------------------------------------------------------------
local animate = require('mini.animate')
require('mini.animate').setup({
    open = { enable = false },
    close = { enable = false },
    cursor = { enable = false },
    scroll = {
        enable = true,
        timing = animate.gen_timing.linear({ duration = 200, unit = 'total' }),
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
--- Highlight the word while cursor is moving on it
-------------------------------------------------------------------------------
function highlight_cursor_area()
    local winid = vim.api.nvim_get_current_win()
    local bufnr = vim.api.nvim_win_get_buf(winid)
    local cursor_pos = vim.api.nvim_win_get_cursor(winid)
    local row = cursor_pos[1] - 1 -- 0-based row index

    local start_pos = vim.fn.searchpos('\\<', 'bcn')
    local end_pos = vim.fn.searchpos('\\>', 'cn')

    local ns_id = vim.api.nvim_create_namespace('cursor_word')

    if start_pos[1] == row + 1 and end_pos[1] == row + 1 then
        local start_col = start_pos[2] - 1
        local end_col = end_pos[2] - 1

        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)

        local highlight_group = 'CursorWord'
        vim.api.nvim_buf_add_highlight(bufnr, ns_id, highlight_group, row, start_col, end_col)
    else
        vim.api.nvim_buf_clear_namespace(bufnr, ns_id, 0, -1)
    end
end

vim.api.nvim_command [[
  highlight CursorWord guibg=#585858
]]
vim.api.nvim_command [[
  autocmd CursorMoved * call luaeval('highlight_cursor_area()')
]]


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
vim.keymap.set('n', '<leader><F8>', toggle_vim_tips, { noremap = true })


-------------------------------------------------------------------------------
--- go to next ([{< in current line
-------------------------------------------------------------------------------
local enclosure = {
    left = { "(", "[", "{", "<" },
    right = { ")", "]", "}", ">" }
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

vim.keymap.set('n', '<tab>l', function() goto_enclosure_dual(0) end, { silent = true })
vim.keymap.set('n', '<tab>h', function() goto_enclosure_dual(1) end, { silent = true })


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

vim.api.nvim_set_keymap("n", "<leader><F9>", ":lua TogglePyDocString()<CR>", { noremap = true, silent = true })


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
    local thiswin = vim.fn.winnr()           -- Get the current window number
    local thisbuf = vim.fn.bufnr("%")        -- Get the current buffer number
    local lastwin = vim.fn.winnr('#')        -- Get the last window number
    local lastbuf = vim.fn.winbufnr(lastwin) -- Get the buffer number in the last window

    -- Execute commands to swap buffers
    vim.cmd(lastwin .. " wincmd w | buffer " .. thisbuf) -- Switch to the last window and open the current buffer
    vim.cmd(thiswin .. " wincmd w | buffer " .. lastbuf) -- Switch back to the current window and open the last window's buffer

    vim.opt.number = false
end

vim.keymap.set('n', '<Leader>sw', win_buf_swap, { silent = true })


-------------------------------------------------------------------------------
--- test
-------------------------------------------------------------------------------
local function test()
    print("Hello World!")
end
vim.keymap.set('n', '<F12>', test, { noremap = true, silent = true })
