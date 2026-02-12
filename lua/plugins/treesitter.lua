return {
    -- Core Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "c", "cpp", "lua" },
            highlight = { enable = true },
            indent = { enable = true },
        },
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        opts = {
            enable = true,
            line_numbers = true,
            mode = 'cursor',
            max_lines = 3, -- Just an example to keep it tidy
        }
    }
}
