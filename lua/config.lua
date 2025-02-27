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

require('mini.animate').setup({
    cursor = { enable = false },
    open = { enable = false },
    close = { enable = false },
    --    scroll = { enable = false },
})

---------------------------------------------------------------------------------
-- Highlight the word while cursor is moving on it
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


---------------------------------------------------------------------------------
--- test
-------------------------------------------------------------------------------
local function test()
    print("Hello World!")
end

vim.keymap.set('n', '<F12>', test, { noremap = true, silent = true })
