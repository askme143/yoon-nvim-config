local dayfox = "dayfox"
local tokyonight_day = "tokyonight-day"
local kanagawa = "kanagawa"
local rosepine = "rose-pine"

require('rose-pine').setup({
    variant = 'dawn'
})

function ColorMyPencil(color)
    color = color or "kanagawa"
    vim.cmd.colorscheme(color)

    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

ColorMyPencil(rosepine)
