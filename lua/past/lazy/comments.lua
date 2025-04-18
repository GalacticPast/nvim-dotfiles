return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
        keywords = {
            nocheckin = { color = "#ff00ff" },
            param = { color = "#1656ad" },
        },
        highlight = {
            pattern = [[(KEYWORDS|keywords)\s*(\([^\)]*\))?:]],
            keyword = "fg",
        },
    }
}
