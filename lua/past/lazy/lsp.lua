return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "ray-x/lsp_signature.nvim",
    },
    event = "InsertEnter",

    config = function()
        local lsp_signature = require("lsp_signature")

        local on_attach = function(_, bufnr)
            lsp_signature.on_attach({
                bind = true,
                handler_opts = { border = "rounded" },
                hint_enable = true,
                hint_prefix = "→ ",  -- simple arrow, no emoji
            }, bufnr)
        end

        require("lspconfig").clangd.setup({
            on_attach = on_attach,
        })
    end,
}

