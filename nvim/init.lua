vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", "https://github.com/folke/lazy.nvim.git", lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { "Failed to clone lazy.nvim:\n", "ErrorMsg" }, { out, "WarningMsg" }, { "\nPress any key to exit..." } }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { "nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = { "nvim-lua/plenary.nvim" }, cmd = "Telescope" },
    {
      "nvim-neo-tree/neo-tree.nvim",
      branch = "v3.x",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-tree/nvim-web-devicons",
      },
      cmd = "Neotree",
      config = function()
        require("neo-tree").setup({
          close_if_last_window = true,
          popup_border_style = "rounded",
          enable_git_status = false,
          enable_diagnostics = false,
          filesystem = {
            hijack_netrw_behavior = "open_default",
            filtered_items = {
              hide_dotfiles = false,
              hide_gitignored = false,
            },
            follow_current_file = {
              enabled = true,
            },
          },
          window = {
            position = "left",
            width = 30,
          },
        })
      end,
    },
    { "neovim/nvim-lspconfig" },
    {
      "williamboman/mason.nvim",
      event = "VeryLazy",
      config = function()
        require("mason").setup()
      end,
    },
    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
      event = "VeryLazy",
      config = function()
        local capabilities = require("cmp_nvim_lsp").default_capabilities()
        vim.lsp.config("*", {
          capabilities = capabilities,
          on_init = function(client)
            client.server_capabilities.semanticTokensProvider = nil
          end,
        })
        require("mason-lspconfig").setup({
          ensure_installed = {
            "clangd",
            "pyright",
            "gopls",
            "rust_analyzer",
          },
        })
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",
        "saadparwaiz1/cmp_luasnip",
      },
      config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        luasnip.config.set_config({ history = false, updateevents = "TextChanged,TextChangedI", delete_check_events = "TextChanged" })
        cmp.setup({
          snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
          mapping = cmp.mapping.preset.insert({
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }),
            ["<Tab>"] = cmp.mapping.select_next_item(),
            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
          }),
          sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "luasnip" },
            { name = "path" },
            { name = "buffer", keyword_length = 3, get_bufnrs = function() return { vim.api.nvim_get_current_buf() } end },
          }),
          experimental = { ghost_text = true },
          performance = { debounce = 60, throttle = 30, fetching_timeout = 200, max_view_entries = 40 },
          sorting = {
            comparators = {
              cmp.config.compare.score,
              cmp.config.compare.recently_used,
              cmp.config.compare.locality,
              cmp.config.compare.exact,
              cmp.config.compare.kind,
              cmp.config.compare.length,
              cmp.config.compare.order,
            },
          },
        })
        cmp.setup.cmdline({ "/", "?" }, {
          mapping = cmp.mapping.preset.cmdline(),
          sources = { { name = "buffer" } },
        })
        cmp.setup.cmdline(":", {
          mapping = cmp.mapping.preset.cmdline(),
          sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
        })
      end,
    },
    {
      "stevearc/conform.nvim",
      event = "BufWritePre",
      config = function()
        require("conform").setup({
          formatters_by_ft = { python = { "ruff_organize_imports", "ruff_format" } },
          format_on_save = { lsp_fallback = true, timeout_ms = 400 },
        })
      end,
    },
  },
  checker = { enabled = false },
})

-- Shared ANSI colors stay consistent when tmux clients inherit stale app variables.
vim.o.termguicolors = false
vim.o.number = true
vim.o.relativenumber = false
vim.o.numberwidth = 3
vim.o.signcolumn = "no"
vim.o.foldcolumn = "0"
vim.o.cursorline = false
vim.o.showtabline = 0
vim.o.laststatus = 0
vim.o.cmdheight = 1
vim.o.ruler = true
vim.o.showcmd = true
vim.o.showmode = true
vim.o.updatetime = 300
vim.cmd.colorscheme("reference")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true, desc = "Delete Buffer" })
vim.keymap.set("n", "<leader>bl", ":ls<CR>", { noremap = true, silent = true, desc = "List Buffers" })
vim.keymap.set("n", "<leader>e", "<cmd>Neotree toggle filesystem reveal left<CR>", { noremap = true, silent = true, desc = "Toggle Sidebar Explorer" })
vim.keymap.set("n", "<leader>E", ":Explore<CR>", { noremap = true, silent = true, desc = "File Explorer" })
vim.keymap.set("n", "<leader>t", ":terminal<CR>", { noremap = true, silent = true, desc = "Open Terminal" })

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

vim.diagnostic.config({
  virtual_text = false,
  signs = false,
  update_in_insert = false,
  severity_sort = true,
})

vim.keymap.set("n", "<leader>sd", function() vim.diagnostic.open_float(0, { scope = "line" }) end, { desc = "Show Line Diagnostics" })
vim.keymap.set("n", "<leader>ld", builtin.diagnostics, { desc = "List Diagnostics" })

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local keymap = vim.keymap.set
    local opts = { buffer = ev.buf, noremap = true, silent = true }
    keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to Definition" }))
    keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover Documentation" }))
    keymap("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to Implementation" }))
    keymap("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename Symbol" }))
    keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code Actions" }))
    keymap("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Go to References" }))
    keymap("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous Diagnostic" }))
    keymap("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next Diagnostic" }))
  end,
})

-- nb: Markdown notebook links and Telescope navigation.
vim.opt.rtp:prepend(vim.fn.expand("~/programming/nb"))
require("nb").setup()
