return {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000,
    config = function()
        require("everforest").setup({
            background = "hard",
            transparent_background_level = 0,
            italics = false,
            disable_italic_comments = false,
            sign_column_background = "none",
            ui_contrast = "low",
            dim_inactive_windows = false,
            diagnostic_text_highlight = false,
            diagnostic_virtual_text = "coloured",
            diagnostic_line_highlight = false,
            spell_foreground = false,
            show_eob = true,
            float_style = "bright",
            inlay_hints_background = "none",
            on_highlights = function(highlight_groups, palette)
            end,
            colours_override = function(palette) end,
        })
        vim.cmd("colorscheme everforest")
    end,
}


--return {
--    "rose-pine/neovim",
--    name = "rose-pine",
--    config = function()
--        require("rose-pine").setup({
--            variant = "auto",      -- auto, main, moon, or dawn
--            dark_variant = "main", -- main, moon, or dawn
--            dim_inactive_windows = false,
--            extend_background_behind_borders = true,
--
--            enable = {
--                terminal = true,
--                legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
--                migrations = true,        -- Handle deprecated options automatically
--            },
--
--            styles = {
--                bold = true,
--                italic = true,
--                transparency = false,
--            },
--
--            groups = {
--                border = "muted",
--                link = "iris",
--                panel = "surface",
--
--                error = "love",
--                hint = "iris",
--                info = "foam",
--                note = "pine",
--                todo = "rose",
--                warn = "gold",
--
--                git_add = "foam",
--                git_change = "rose",
--                git_delete = "love",
--                git_dirty = "rose",
--                git_ignore = "muted",
--                git_merge = "iris",
--                git_rename = "pine",
--                git_stage = "iris",
--                git_text = "rose",
--                git_untracked = "subtle",
--
--                h1 = "iris",
--                h2 = "foam",
--                h3 = "rose",
--                h4 = "gold",
--                h5 = "pine",
--                h6 = "foam",
--            },
--
--            palette = {
--                -- Override the builtin palette per variant
--                -- moon = {
--                --     base = '#18191a',
--                --     overlay = '#363738',
--                -- },
--            },
--
--            -- NOTE: Highlight groups are extended (merged) by default. Disable this
--            -- per group via `inherit = false`
--            highlight_groups = {
--                -- Comment = { fg = "foam" },
--                -- StatusLine = { fg = "love", bg = "love", blend = 15 },
--                -- VertSplit = { fg = "muted", bg = "muted" },
--                -- Visual = { fg = "base", bg = "text", inherit = false },
--            },
--
--            before_highlight = function(group, highlight, palette)
--                -- Disable all undercurls
--                -- if highlight.undercurl then
--                --     highlight.undercurl = false
--                -- end
--                --
--                -- Change palette colour
--                -- if highlight.fg == palette.pine then
--                --     highlight.fg = palette.foam
--                -- end
--            end,
--        })
--
--        vim.cmd("colorscheme rose-pine")
--    end
--}
--

--return {
--    "rebelot/kanagawa.nvim",
--    name = "kanagawa",
--    priority = 1000,
--    config = function()
--        -- Default options:
--        require('kanagawa').setup({
--            compile = false,  -- enable compiling the colorscheme
--            undercurl = true, -- enable undercurls
--            commentStyle = { italic = true },
--            functionStyle = {},
--            keywordStyle = { italic = true },
--            statementStyle = { bold = true },
--            typeStyle = {},
--            transparent = false,   -- do not set background color
--            dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
--            terminalColors = true, -- define vim.g.terminal_color_{0,17}
--            colors = {             -- add/modify theme and palette colors
--                palette = {},
--                theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
--            },
--            overrides = function(colors) -- add/modify highlights
--                return {}
--            end,
--            theme = "wave",      -- Load "wave" theme
--            background = {       -- map the value of 'background' option to a theme
--                dark = "dragon", -- try "dragon" !
--                light = "lotus"
--            },
--        })
--
--        -- setup must be called before loading
--        vim.cmd("colorscheme kanagawa")
--    end,
--}

--return {
--    "catppuccin/nvim",
--    name = "catppuccin",
--    priority = 1000,
--    config = function()
--        require("catppuccin").setup({
--            flavour = "auto", -- latte, frappe, macchiato, mocha
--            background = {    -- :h background
--                light = "latte",
--                dark = "macchiato",
--            },
--            transparent_background = false, -- disables setting the background color.
--            show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
--            term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
--            dim_inactive = {
--                enabled = false,            -- dims the background color of inactive window
--                shade = "dark",
--                percentage = 0.15,          -- percentage of the shade to apply to the inactive window
--            },
--            no_italic = false,              -- Force no italic
--            no_bold = false,                -- Force no bold
--            no_underline = false,           -- Force no underline
--            styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
--                comments = { "italic" },    -- Change the style of comments
--                conditionals = { "italic" },
--                loops = {},
--                functions = {},
--                keywords = {},
--                strings = {},
--                variables = {},
--                numbers = {},
--                booleans = {},
--                properties = {},
--                types = {},
--                operators = {},
--                -- miscs = {}, -- Uncomment to turn off hard-coded styles
--            },
--            color_overrides = {},
--            custom_highlights = {},
--            default_integrations = true,
--            integrations = {
--                cmp = true,
--                gitsigns = true,
--                nvimtree = true,
--                treesitter = true,
--                notify = false,
--                mini = {
--                    enabled = true,
--                    indentscope_color = "",
--                },
--                -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
--            },
--        })
--        vim.cmd("colorscheme catppuccin")
--    end,
--}

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

-- Using lazy.nvim
--return {
--    'deparr/tairiki.nvim',
--    lazy = false,
--    priority = 1000, -- recommended if you use tairiki as your default theme
--    config = function()
--        require('tairiki').setup({
--            palette              = "dark", -- main palette, available options: dark, light, dimmed, tomorrow, light_legacy
--            default_dark         = "dark",
--            default_light        = "light",
--            transparent          = false, -- don't set background colors
--            terminal             = false, -- override nvim terminal colors
--            end_of_buffer        = false, -- show end of buffer filler lines (tildes)
--            visual_bold          = false, -- bolden visual selections
--            cmp_itemkind_reverse = false, -- reverse fg/bg on nvim-cmp item kinds
--
--            diagnostics          = {
--                darker     = false, -- darken diagnostic virtual text
--                background = true,  -- add background to diagnostic virtual text
--                undercurl  = false, -- use undercurls for inline diagnostics
--            },
--
--            -- style for different syntactic tokens
--            -- see :help nvim_set_hl() for available keys
--            code_style           = {
--                comments = { italic = true },
--                conditionals = {},
--                keywords = {},
--                functions = {},
--                strings = {},
--                variables = {},
--                parameters = {},
--                types = {},
--            },
--
--            -- lualine theme config
--            lualine              = {
--                transparent = true, -- remove background from center section
--            },
--
--            -- which plugins to enable
--            plugins              = {
--                all = false,  -- enable all supported plugins
--                none = false, -- ONLY set groups listed in :help highlight-groups (see lua/tairiki/groups/neovim.lua). Manually enabled plugins will also be ignored
--                auto = false, -- auto detect installed plugins, currently lazy.nvim only
--
--                -- or enable/disable plugins manually
--                -- see lua/tairiki/groups/init.lua for the full list of available plugins
--                -- either the key or value from the M.plugins table can be used as the key here
--                --
--                -- setting a specific plugin manually overrides `all` and `auto`
--                treesitter = true,
--                semantic_tokens = true,
--            },
--
--            -- optional function to modify or add colors to the palette
--            -- palette definitions are in lua/tairiki/palette
--            colors               = function(colors, opts) end,
--
--            -- optional function to override highlight groups
--            highlights           = function(groups, colors, opts) end,
--        })
--        vim.cmd("colorscheme tairiki")
--    end,
--}



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
--            bold = false,
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
--            inverse = false, -- invert background for search, diffs, statuslines and errors
--            contrast = "",   -- can be "hard", "soft" or empty string
--            palette_overrides = {},
--            overrides = {},
--            dim_inactive = false,
--            transparent_mode = false,
--        })
--        vim.cmd("colorscheme gruvbox")
--    end,
--}

--return {
--    -- Lua
--    "navarasu/onedark.nvim",
--    lazy = false,
--    priotiry = 1000,
--    config = function()
--        require('onedark').setup({
--            -- Main options --
--            style = 'dark',               -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
--            transparent = false,          -- Show/hide background
--            term_colors = true,           -- Change terminal color as per the selected theme style
--            ending_tildes = false,        -- Show the end-of-buffer tildes. By default they are hidden
--            cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
--
--            -- toggle theme style ---
--            toggle_style_key = "<leader>ts",                                                     -- keybind to toggle theme style. Leave it nil to disable it, or set it to a string, for example "<leader>ts"
--            toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between
--
--            -- Change code style ---
--            -- Options are italic, bold, underline, none
--            -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
--            code_style = {
--                comments = 'italic',
--                keywords = 'none',
--                functions = 'none',
--                strings = 'none',
--                variables = 'none'
--            },
--
--            -- Lualine options --
--            lualine = {
--                transparent = false, -- lualine center bar transparency
--            },
--
--            -- Custom Highlights --
--            colors = {},     -- Override default colors
--            highlights = {}, -- Override highlight groups
--
--            -- Plugins Config --
--            diagnostics = {
--                darker = true,     -- darker colors for diagnostic
--                undercurl = true,  -- use undercurl instead of underline for diagnostics
--                background = true, -- use background color for virtual text
--            },
--        })
--        vim.cmd("colorscheme onedark")
--    end,
--}
