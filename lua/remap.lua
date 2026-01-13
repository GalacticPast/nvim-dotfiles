local os = "unknown"
if vim.loop.os_uname().sysname == "Darwin" then
    os = "osx"
elseif vim.loop.os_uname().sysname == "Linux" then
    os = "linux"
elseif vim.loop.os_uname().sysname == "Windows_NT" then
    os = "windows"
else
    error("unknown OS/platform, config might not work")
end


vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", ":NvimTreeToggle<CR>", { desc = "Toggle [E]xplorer tree" })


vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")


-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "<space>e", "<cmd>lua vim.diagnostic.open_float()<CR>")

--
-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<C-h>",
    function()
        vim.cmd("wincmd h")
    end
)
vim.keymap.set("n", "<C-l>",
    function()
        vim.cmd("wincmd l")
    end
)

--tree
-- optionally enable 24-bit colour
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.termguicolors = true
-- empty setup using defaults

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")
vim.keymap.set("n", "<leader>vs", function()
    vim.cmd(":vs");
    vim.cmd(":vertical resize 100");
end)

vim.keymap.set("n", "<leader>xa", ":%bd|e#|bd#<CR>", { desc = "[X]Close [A]ll buffers but this one" })
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Build shortcuts
if os == "windows" then
    vim.keymap.set("n", "<leader>bd", "<C-w>v<cr>|<cmd>:term build_debug.bat<cr>i", { desc = "[B]uild [D]ebug" })
    vim.keymap.set("n", "<leader>br", "<C-w>v<cr>|<cmd>:term build_release.bat<cr>i", { desc = "[B]uild [R]elease" })
    vim.keymap.set("n", "<leader>bs", "<C-w>v<cr>|<cmd>:term post_build.bat<cr>i", { desc = "[B]uild [S]haders" })
    vim.keymap.set("n", "<leader>bc", "<C-w>v<cr>|<cmd>:term clean.bat<cr>i", { desc = "[B]uild->[C]lean" })
else
    vim.keymap.set("n", "<leader>bd", "<C-w>v<cr>|<cmd>:term ./build_debug.sh<cr>i", { desc = "[B]uild [D]ebug" })
    vim.keymap.set("n", "<leader>br", "<C-w>v<cr>|<cmd>:term ./build_release.sh<cr>i", { desc = "[B]uild [R]elease" })
    vim.keymap.set("n", "<leader>bc", "<C-w>v<cr>|<cmd>:term ./clean.sh<cr>i", { desc = "[B]uild->[C]lean" })
    vim.keymap.set("n", "<leader>bs", "<C-w>v<cr>|<cmd>:term ./post_build.sh<cr>i", { desc = "[B]uild [S]haders" })
    vim.keymap.set("n", "<leader>faf",
        "<C-w>v<cr>|<cmd>:term find . -regex '.*\\.\\(cpp\\|hpp\\|c\\|h\\|cxx\\)' -exec clang-format -style=file -i {} \\;<cr>i",
        { desc = "[F]ornmat [A]ll [F]iles" })
end

vim.keymap.set("n", "<leader>=", function()
    vim.cmd("vertical resize 220")
end)

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("noh")
end)

