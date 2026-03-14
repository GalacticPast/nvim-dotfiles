if vim.loader then vim.loader.enable() end

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "ellisonleao/gruvbox.nvim", priority = 1000 },
  { "neovim/nvim-lspconfig" }, -- Provides server definitions
  { "lervag/vimtex", lazy = false },
  { "nvim-tree/nvim-tree.lua" },
  { 
    "nvim-telescope/telescope.nvim", 
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope" 
  },
})

require("gruvbox").setup({ 
    contrast = "soft",
    inverse = true,
    palette_overrides = {},
    overrides = {
        -- This forces comments to be Green (#b8bb26) and removes Italics if preferred
        Comment = { fg = "#b8bb26", italic = true },
        -- Optional: Also make LSP "hint" comments or documentation green
        ["@comment"] = { fg = "#b8bb26" },
    },
})
vim.opt.termguicolors = true
vim.cmd("colorscheme gruvbox")

vim.g.mapleader = " "
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.background = "dark"
vim.opt.tabstop = 4
vim.opt.cursorline = true
vim.opt.mouse = ""

vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.wrap = false 

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.hidden = true -- Allows switching buffers without saving
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
k("n", "<leader>pv", "<cmd>NvimTreeToggle<CR>")

k("n", "<leader>pf", "<cmd>Telescope find_files<CR>")
k("n", "<leader>fw", "<cmd>Telescope live_grep<CR>")
k("n", "<leader><leader>", "<cmd>noh<CR>")
k("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
k("x", "<leader>p", [["_dP]])
k({ "n", "v" }, "<leader>y", [["+y]])
k("n", "<leader>Y", [["+Y]])
k("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>")
k("n", "<leader>rw", "*``cgn", { desc = "Replace word under cursor" })


k("n", "<leader>gm", function()
    vim.o.background = (vim.o.background == "dark") and "light" or "dark"
    vim.cmd("colorscheme gruvbox")
    vim.opt.guicursor = ""
end)


k("n", "<leader>f", function()
    vim.lsp.buf.format { async = true }
end, { desc = "Format Buffer" })
function _G.definition_split()
  vim.lsp.buf.definition({
    on_list = function(options)
      if not options or #options.items == 0 then return end
      
      if #options.items > 1 then
        vim.notify("Multiple items found, opening first one", vim.log.levels.WARN)
      end

      local item = options.items[1]
      local wins = vim.api.nvim_tabpage_list_wins(0)
      
      if #wins > 1 then
        -- Move to the right-most window and overwrite
        vim.cmd("wincmd l")
        vim.cmd("w");
        vim.cmd("edit +" .. item.lnum .. " " .. item.filename)
      else
        -- Create a new split to the RIGHT
        vim.cmd("botright vsplit +" .. item.lnum .. " " .. item.filename)
      end
      
      -- Set column and center
      vim.api.nvim_win_set_cursor(0, {item.lnum, item.col - 1})
      vim.cmd("normal! zz")
    end,
  })
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'c', 'cpp' },
    callback = function(args)
        local root = vim.fs.root(args.buf, { 'compile_flags.txt', '.git' })
        vim.lsp.start({
            name = 'clangd',
            cmd = { 'clangd', '--background-index', '--header-insertion=never' },
            root_dir = root or vim.uv.cwd(),
        })
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local opts = { buffer = ev.buf }
        k("n", "gd", _G.definition_split, opts) -- Your custom split-right jump
        k({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
        k("n", "<space>e", vim.diagnostic.open_float, opts)
    end,
})

local function run_build_task(task)
    local is_windows = vim.fn.has("win32") == 1
    
    -- Priority check for debug task to support build.sh/bat fallbacks
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
        print("Script not found: " .. (cmd or task))
        return 
    end

    vim.opt.makeprg = cmd
    vim.cmd("silent make!")

    if #vim.fn.getqflist() > 0 then
        vim.cmd("cclose")
        vim.cmd("vertical leftabove copen")
        vim.api.nvim_win_set_width(0, math.floor(vim.opt.columns:get() / 2))
        vim.cmd("wincmd p")
    else
        vim.cmd("cclose")
        print("Done: " .. task .. " ✨")
    end
end

k("n", "<leader>bd", function() run_build_task("debug") end)
k("n", "<leader>br", function() run_build_task("release") end)
k("n", "<leader>bc", function() run_build_task("clean") end)
k("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "[C]lose [C]quickfix" })

require("nvim-tree").setup({
  renderer = { icons = { show = { file = false, folder = false, git = false } } }
})
