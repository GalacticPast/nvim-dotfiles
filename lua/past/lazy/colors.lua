--return {
--    'maxmx03/solarized.nvim',
--    lazy = false,
--    priority = 1000,
--    opts = {},
--    config = function(_, opts)
--        vim.o.termguicolors = true
--        vim.o.background = 'dark'
--        require('solarized').setup(opts)
--        vim.cmd.colorscheme 'solarized'
--    end,
--}
-- Lua
return{
    'navarasu/onedark.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('onedark').setup  ({
            -- Main options --
            style = 'warm', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
            transparent = false,  -- Show/hide background
            term_colors = true, -- Change terminal color as per the selected theme style
            ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
            cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

            -- toggle theme style ---
            toggle_style_key = "<leader>ts", -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
            toggle_style_list = {'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light'}, -- List of styles to toggle between

            -- Change code style ---
            -- Options are italic, bold, underline, none
            -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
            code_style = {
                comments = 'italic',
                keywords = 'none',
                functions = 'none',
                strings = 'none',
                variables = 'none'
            },

            -- Lualine options --
            lualine = {
                transparent = false, -- lualine center bar transparency
            },

            -- Custom Highlights --
            colors = {}, -- Override default colors
            highlights = {}, -- Override highlight groups

            -- Plugins Config --
            diagnostics = {
                darker = true, -- darker colors for diagnostic
                undercurl = true,   -- use undercurl instead of underline for diagnostics
                background = true,    -- use background color for virtual text
            },
        })
        vim.cmd("colorscheme onedark")
    end,

}
--return {
--    "ellisonleao/gruvbox.nvim",
--    lazy = false,
--    priority = 1000,
--    config = function()
--        -- Default options:
--        require("gruvbox").setup({
--            terminal_colors = true, -- add neovim terminal colors
--            undercurl = true,
--            underline = true,
--            bold = true,
--            italic = {
--                strings = true,
--                emphasis = true,
--                comments = true,
--                operators = false,
--                folds = true,
--            },
--            strikethrough = true,
--            invert_selection = false,
--            invert_signs = false,
--            invert_tabline = false,
--            invert_intend_guides = false,
--            inverse = true,    -- invert background for search, diffs, statuslines and errors
--            contrast = "hard", -- can be "hard", "soft" or empty string
--            palette_overrides = {},
--            overrides = {},
--            dim_inactive = false,
--            transparent_mode = false,
--        })
--        vim.cmd("colorscheme gruvbox")
--    end,
--}
