local set = vim.opt

--Tab and Space

set.tabstop = 4
set.softtabstop = 4
set.expandtab = true
set.smarttab = true
set.shiftwidth = 4

vim.cmd([[
autocmd BufEnter *.ml :setlocal tabstop=2 shiftwidth=2 softtabstop=4
autocmd BufEnter *.js :setlocal tabstop=2 shiftwidth=2 softtabstop=4
autocmd BufEnter *.ts :setlocal tabstop=2 shiftwidth=2 softtabstop=4
autocmd BufEnter *.jsx :setlocal tabstop=2 shiftwidth=2 softtabstop=4
autocmd BufEnter *.tsx :setlocal tabstop=2 shiftwidth=2 softtabstop=4
autocmd BufEnter *.json :setlocal tabstop=2 shiftwidth=2 softtabstop=4
autocmd BufEnter *.prisma :setlocal tabstop=2 shiftwidth=2 softtabstop=4
autocmd BufEnter *.dart :setlocal tabstop=2 shiftwidth=2 softtabstop=4
]])

-- UI config
set.number = true
set.relativenumber = true -- set relative line numbers
set.wildmenu = true       -- show vim command line autocomplete candidates


-- Key config
set.backspace = { 'indent', 'eol', 'start' }
vim.cmd([[
tnoremap <Esc> <C-\><C-n>
]])

-- last-position-jump
vim.api.nvim_create_autocmd(
    { 'BufReadPost' },
    {
        --pattern = { '*' },
        callback = function()
            local ft = vim.opt_local.filetype:get()
            -- don't apply to git messages
            if (ft:match('commit') or ft:match('rebase')) then
                return
            end
            -- get position of last saved edit
            local markpos = vim.api.nvim_buf_get_mark(0, '"')
            local line = markpos[1]
            local col = markpos[2]
            -- if in range, go there
            if (line > 1) and (line < vim.api.nvim_buf_line_count(0)) then
                vim.api.nvim_win_set_cursor(0, { line, col })
            end
        end
    }
)

-- keymap
vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>tm", vim.cmd.te)

-- lazy plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = require("plugins")
require("lazy").setup(plugins)

-- after plugins
require("after.color")
require("after.telescope")
