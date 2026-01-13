return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = {
            "c",
            "cpp",
            "lua",
        },
        indent = { enable = true },
        highlight = { enable = true },
        folds = { enable = true },
    }
}
