return {
    {
        "rebelot/kanagawa.nvim",
        lazy = false,
    },
    { 'rose-pine/neovim', name = 'rose-pine' },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function () 
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = { "c", "lua", "javascript", "html", "ocaml", "python", "typescript" },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        dependencies = {
            { 'nvim-lua/plenary.nvim', lazy = false }
        }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require("indent_blankline").setup {
                -- for example, context is off by default, use this to turn it on
                show_current_context = true,
                show_current_context_start = true,
            }
        end
    },
    {
        "simrat39/inlay-hints.nvim",
        config = function()
            require('inlay-hints').setup()
        end
    },
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},     -- Required
            {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'L3MON4D3/LuaSnip'},     -- Required
        },
        config = function ()
            -- auto completion use enter
            local cmp = require('cmp')
            cmp.setup(
                {
                    mapping = {
                        ['<CR>'] = cmp.mapping.confirm({select=true}),
                        ['<C-Space>'] = cmp.mapping.complete(),
                    }
                }
            )

            -- lsp
            local lsp = require('lsp-zero').preset({})

            lsp.on_attach(function(client, bufnr)
                lsp.default_keymaps({buffer = bufnr})
            end)

            lsp.format_on_save({
                server = {
                    ['lua_ls'] = { 'lua' },
                    ['ocamllsp'] = { 'ocaml', 'ocaml.menhir', 'ocaml.interface', 'ocaml.ocamllex', 'reason', 'dune' },
                    ['rust_analyzer'] = { 'rust' },
                    ['html'] = { 'html' },
                }
            })

            lsp.setup()

            -- keymap
            vim.keymap.set("n", "<leader>hl", vim.lsp.buf.code_action)
            vim.keymap.set("n", "<leader>hp", vim.lsp.buf.signature_help)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename)
        end
    },
}
