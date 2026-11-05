if vim.loader then vim.loader.enable() end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- Leader must be set before lazy.setup so plugin mappings use it
vim.g.mapleader = " "

require("lazy").setup({
    { "ellisonleao/gruvbox.nvim", priority = 1000 },
    {"bluz71/vim-moonfly-colors", priority = 1000, name = "moonfly"},
    { "neovim/nvim-lspconfig",
        dependencies = {{ 'williamboman/mason.nvim', config = true },
                      'williamboman/mason-lspconfig.nvim'},
    }, -- Provides server definitions
    {
        "lervag/vimtex",
        lazy = false,     -- we don't want to lazy load VimTeX
        -- tag = "v2.15", -- uncomment to pin to a specific release
        init = function()
            -- VimTeX configuration goes here, e.g.
            vim.g.vimtex_view_method = "zathura"
        end
    },
    { 'nvim-mini/mini.icons', version = false },
    {"stevearc/oil.nvim", lazy = false},
    {"mbbill/undotree"},
    {"stevearc/conform.nvim"},
    
    -- Install fff.nvim here, configure it outside later
    { 
        'dmtrKovalenko/fff.nvim',
        build = function()
            -- Automatically downloads a prebuilt binary or falls back to building via Cargo
            require("fff.download").download_or_build_binary()
        end,
        lazy = false, -- The plugin needs to initialize itself on startup
    },
    
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, 
    { "nvim-treesitter/nvim-treesitter-context" },             
    {
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    }
})

vim.opt.termguicolors = true

vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
-- Follow the desktop color preference that Noctalia updates.
local function sync_desktop_background()
    vim.system({"gsettings", "get", "org.gnome.desktop.interface", "color-scheme"}, {text = true}, function(result)
        if result.code ~= 0 then return end
        local mode = result.stdout:match("prefer%-(dark)") or result.stdout:match("prefer%-(light)")
        if mode then
            vim.schedule(function()
                if vim.o.background ~= mode then vim.o.background = mode end
            end)
        end
    end)
end

sync_desktop_background()
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.mouse = ""

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false 

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.local/share/nvim/undo"

vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250


local k = vim.keymap.set

k("n", "<C-h>", "<C-w>h")
k("n", "<C-l>", "<C-w>l")
k("i", "<C-c>", "<Esc>")

k("v", "J", ":m '>+1<CR>gv=gv")
k("v", "K", ":m '<-2<CR>gv=gv")
k("n", "<C-d>", "<C-d>zz")
k("n", "<C-u>", "<C-u>zz")
k("x", "<leader>p", [["_dP]])
k({ "n", "v" }, "<leader>y", [["+y]])
k("n", "<leader>pv", "<CMD>Oil<CR>", { desc = "Open parent directory" })

k("n", "<leader><leader>", "<cmd>noh<CR>")
k("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
k("n", "<leader>Y", [["+Y]])
k("n", "<leader>rw", "*``cgn", { desc = "Replace word under cursor" })
k('n', '<leader>u', vim.cmd.UndotreeToggle)

-- ==========================================
-- PLUGIN SETUPS (Outside of lazy.nvim)
-- ==========================================

-- fff.nvim Setup & Keymaps
require("fff").setup({
    max_results = 100,
    frecency = {
        enabled = true,
    },
    git = {
        status_text_color = true, -- Apply git status colors to files
    }
})

k("n", "<leader>pf", function() require('fff').find_files() end, { desc = 'Find files (fff)' })
k("n", "<leader>fw", function() require('fff').live_grep() end, { desc = 'Live grep (fff)' })
k("n", "<leader>fz", function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end, { desc = 'Live fuzzy grep' })
k("n", "<leader>fc", function() require('fff').live_grep({ query = vim.fn.expand("<cword>") }) end, { desc = 'Search current word' })


-- nvim-treesitter `main` branch: it only installs parsers; highlighting is started by Neovim
local ts_langs = { "c", "cpp", "go", "odin" }
require("nvim-treesitter").install(ts_langs)
vim.api.nvim_create_autocmd("FileType", {
  pattern = ts_langs,
  callback = function() pcall(vim.treesitter.start) end, -- pcall: parser may still be compiling
})

require("treesitter-context").setup{
  enable = true,            -- Enable this plugin
  max_lines = 3,            -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0,    -- Minimum editor window height to enable context.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded.
  mode = 'cursor',          -- Line used to calculate context. Can be 'cursor' or 'topline'.
}

require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = true,
  invert_signs = false,
  invert_tabline = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

require("todo-comments").setup({
    keywords = {
        FIX      = { icon = " ", color = "error"   , alt = {"fix"} },
        TODO     = { icon = " ", color = "info"    , alt = {"todo"} },
        HACK     = { icon = " ", color = "warning" , alt = {"hack"} },
        WARN     = { icon = " ", color = "warning" , alt = {"warn"} },
        PERF     = { icon = " ", color = "default" , alt = {"perf"} },
        NOTE     = { icon = " ", color = "hint"    , alt = {"note", "info"} },
        TEST     = { icon = "⏲ ", color = "test"    , alt = {"test"} },
        REFACTOR = { icon = " ", color = "warning" , alt = {"refactor"} },
    },
    highlight = {
        pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
        comments_only = true,
    },
    search = {
        pattern = [[\b(KEYWORDS):]], -- ripgrep regex
    },
})

require("conform").setup({
  formatters_by_ft = {
    odin = { "odinfmt" },
    javascript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
  },
  formatters = {
    -- odinfmt looks for odinfmt.json from its working directory upward, so run it
    -- from the project root instead of wherever nvim was started
    odinfmt = {
      cwd = require("conform.util").root_file({ "odinfmt.json" }),
    },
  },
  format_on_save = {
    stop_after_first = true,
    lsp_format = "fallback",
    timeout_ms = 1000,
  },
})

-- Format keybinding
vim.keymap.set("n", "<leader>f", function()
  require("conform").format({
    stop_after_first = true,
    lsp_format = "fallback",
    async = true,
  })
end, { desc = "Format Buffer" })

-- 1. Custom Functions
local function toggle_diagnostic_qf()
    local current_width = vim.api.nvim_win_get_width(0)
    vim.fn.setqflist({}, 'f') 
    vim.diagnostic.setqflist({ open = false })

    if #vim.fn.getqflist() == 0 then
        vim.notify("No diagnostics found", vim.log.levels.INFO)
        return
    end
    
    vim.cmd("vertical leftabove copen")
    vim.api.nvim_win_set_width(0, math.floor(vim.opt.columns:get() / 2))
    vim.cmd("wincmd p")
end

local function definition_split()
    vim.lsp.buf.definition({
        on_list = function(options)
            if not options or #options.items == 0 then return end
            
            if #options.items > 1 then
                vim.notify("Multiple items found, opening first one", vim.log.levels.WARN)
            end

            local item = options.items[1]
            local curr_split = vim.api.nvim_win_get_buf(0)
            
            vim.cmd("wincmd l")
            local possible_right_split = vim.api.nvim_win_get_buf(0)
            
            if curr_split == possible_right_split then
                vim.cmd("botright vsplit +" .. item.lnum .. " " .. item.filename)
            else
                vim.cmd("edit +" .. item.lnum .. " " .. item.filename)
            end

            vim.api.nvim_win_set_cursor(0, {item.lnum, item.col - 1})
            vim.cmd("normal! zz")
        end,
    })
end

-- 2. Define all your Language Servers here
local servers = {
    odin = {
        cmd = { 'ols' },
        filetypes = { 'odin' },
        root_markers = { '.git', 'odinfmt.json' },
    },
    gopls = {
        cmd = { 'gopls' },
        filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
        root_markers = { 'go.work', 'go.mod', '.git' },
    },
    clangd = {
        cmd = { 'clangd', '--background-index', '--header-insertion=never' },
        filetypes = { 'c', 'cpp', 'objc', 'objcpp' },
        root_markers = { 'compile_flags.txt', 'compile_commands.json', '.git' },
    },
}

-- 3. Generic Loop to configure and enable all servers
for name, config in pairs(servers) do
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
end

-- 4. Attach Keymaps globally whenever ANY language server attaches
vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        
        k("n", "gd", definition_split, opts) 
        k({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        k("n", "<space>e", toggle_diagnostic_qf, opts)  
        
        k("n", "<space>ne", function()
            local ok, _ = pcall(vim.cmd, "cnext")
            if ok then vim.cmd("normal! zz") end
        end, opts)

        k("n", "<space>pe", function()
            local ok, _ = pcall(vim.cmd, "cprev")
            if ok then vim.cmd("normal! zz") end
        end, opts)
    end,
})

-- 5. Build Tasks
local function run_build_task(task)
    local is_windows = vim.fn.has("win32") == 1
    
    local cmd = nil
    if task == "debug" then
        local candidates = is_windows and {"build_debug.bat", "build.bat"} or {"./build_debug.sh", "./build.sh"}
        for _, s in ipairs(candidates) do
            if vim.fn.filereadable(s) == 1 then cmd = s; break end
        end
    else
        local scripts = {
            release = is_windows and "build_release.bat" or "./build_release.sh",
            shaders = is_windows and "post_build.bat"    or "./post_build.sh",
            clean   = is_windows and "clean.bat"         or "./clean.sh"
        }
        cmd = scripts[task]
    end

    if not cmd or vim.fn.filereadable(cmd) == 0 then 
        vim.notify("Script not found: " .. (cmd or task), vim.log.levels.WARN)
        return 
    end

    vim.notify("Running " .. cmd .. "...", vim.log.levels.INFO)

    -- Force cmd.exe on Windows to avoid PowerShell redirection errors
    local exec_cmd = is_windows and ("cmd.exe /c " .. cmd) or cmd
    
    -- Odin: "file(line:col) Error: msg"; drop the source-snippet / ^~~~ lines
    local odin_efm = table.concat({
        "%f(%l:%c) Syntax %trror: %m",
        "%f(%l:%c) %trror: %m",
        "%f(%l:%c) %tarning: %m",
        "%-G%.%#",
    }, ",")

    -- Compilers often write errors to stderr, so collect both streams
    local output = {}
    local function collect(_, data)
        for _, line in ipairs(data or {}) do
            if line ~= "" then table.insert(output, line) end
        end
    end

    -- Run the command asynchronously (prevents UI freeze on long builds)
    vim.fn.jobstart(exec_cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = collect,
        on_stderr = collect,
        on_exit = function(_, exit_code)
            vim.fn.setqflist({}, ' ', { title = task .. " build", lines = output, efm = odin_efm })
            if exit_code == 0 then
                vim.notify("Build completed successfully", vim.log.levels.INFO)
                vim.cmd("cclose")
            else
                vim.notify("Build failed with code " .. exit_code, vim.log.levels.ERROR)
                vim.cmd("vertical leftabove copen")
                vim.api.nvim_win_set_width(0, math.floor(vim.opt.columns:get() / 2))
                vim.cmd("wincmd p")
            end
        end,
    })
end
k("n", "<leader>bd", function() run_build_task("debug") end)
k("n", "<leader>br", function() run_build_task("release") end)
k("n", "<leader>bc", function() run_build_task("clean") end)
k("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "[C]lose [C]quickfix" })

require('mini.icons').setup()

require("oil").setup({
    columns = {
        "icon",
    },
})
