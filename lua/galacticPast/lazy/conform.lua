return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                -- e.g., for C/C++ files
                cpp = { "my_formatter" },
                c = { "my_formatter" },
            },
            format_on_save = {
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            },
            formatters = {
                my_formatter = {
                    command = "clang-format",
                    -- Just call it without args to use .clang-format
                    args = {}, -- no --style
                    stdin = true, -- clang-format works well with stdin
                },
            },
        })

        vim.keymap.set({ "n", "v" }, "<leader>f", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 1000,
            })
        end, { desc = "Format file or range (in visual mode)" })
    end,
}

