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
        }, {
            id = "breakpoints",
        }, {
            id = "watches",
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


-------------------------------------------------------------------------------
--- mini.animate
-------------------------------------------------------------------------------
require('mini.animate').setup({
    cursor = { enable = false },
    open = { enable = false },
    close = { enable = false },
    --    scroll = { enable = false },
})


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
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
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

-- Set key mappings
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
--- test
-------------------------------------------------------------------------------
local function test()
    print("Hello World!")
end
vim.keymap.set('n', '<F12>', test, { noremap = true, silent = true })
