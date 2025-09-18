local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
    end
    end
    vim.opt.rtp:prepend(lazypath)

    require("lazy").setup({
      spec = {
        { "nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = { "nvim-lua/plenary.nvim" } },
        { "neovim/nvim-lspconfig" },
        {
          "williamboman/mason.nvim",
          -- build = ":MasonUpdate",
          config = function()
          require("mason").setup()
          end,
        },
        {
          "williamboman/mason-lspconfig.nvim",
          dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
          config = function()
          local capabilities = require("cmp_nvim_lsp").default_capabilities()
          require("mason-lspconfig").setup({
            ensure_installed = { "clangd" },
            handlers = {
              function(server_name)
              require("lspconfig")[server_name].setup({
                capabilities = capabilities,
              })
              end,
            },
          })
          end,
        },

        -- Autocompletion (LSP only, no snippets)
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",
      },
      config = function()
      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
                                            ["<CR>"] = cmp.mapping.confirm({ select = true }),
                                            ["<Tab>"] = cmp.mapping.select_next_item(),
                                            ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = {
          { name = "nvim_lsp" },
        },
      })
      end,
    },
      },
      checker = { enabled = false },
    })

    vim.g.mapleader = " "
    vim.g.maplocalleader = "\\"
    vim.o.termguicolors = true
    vim.o.number = true
    vim.cmd.colorscheme("default")
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#5eacd3", bold = true }) -- current line number
    vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#888888" }) -- for relative lines above (requires Neovim 0.9+)
    vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#888888" }) -- for relative lines below (requires Neovim 0.9+)
    -- Telescope keymaps
    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Find Help Tags" })
    -- Buffer management keymaps
    vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { noremap = true, silent = true, desc = "Next Buffer" })
    vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { noremap = true, silent = true, desc = "Previous Buffer" })
    vim.keymap.set("n", "<leader>bd", ":bd<CR>", { noremap = true, silent = true, desc = "Delete Buffer" })
    vim.keymap.set("n", "<leader>bl", ":ls<CR>", { noremap = true, silent = true, desc = "List Buffers" })
    vim.keymap.set("n", "<leader>e", ":Explore<CR>", { noremap = true, silent = true, desc = "File Explorer" })
    vim.keymap.set("n", "<leader>t", ":terminal<CR>", { noremap = true, silent = true, desc = "Open Terminal" })

    vim.opt.tabstop = 2
    vim.opt.shiftwidth = 2
    vim.opt.softtabstop = 2
    vim.opt.expandtab = true

    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(ev)
      local opts = { buffer = ev.buf, noremap = true, silent = true }
      local keymap = vim.keymap.set
      keymap("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
      keymap("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
      keymap("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
      keymap("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Symbol" })
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Actions" })
      keymap("n", "gr", vim.lsp.buf.references, { desc = "Go to References" })
      keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous Diagnostic" })
      keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
      end,
    })
