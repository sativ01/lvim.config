-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.spell = false
vim.opt.signcolumn = "auto"
vim.opt.wrap = false

-- general
lvim.log.level = "warning"
lvim.format_on_save = {
  enabled = true,
  timeout = 10000,
}
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings <https://www.lunarvim.org/docs/configuration/keybindings>
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<leader>w"] = ":w<cr>"
lvim.keys.normal_mode["Y"] = "Y"
lvim.keys.normal_mode["|"] = ":vs<cr>"

lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- Standard operations
lvim.keys.normal_mode["U"] = ":redo<cr>"
lvim.keys.normal_mode[";;"] = "<Esc>A;<Esc>"
lvim.keys.normal_mode[",,"] = "<Esc>A,<Esc>"
lvim.keys.normal_mode["<leader>u"] = "<cmd>nohlsearch<cr>"
-- Center on scroll nav
lvim.keys.normal_mode["<c-d>"] = "<c-d>zz"
lvim.keys.normal_mode["<c-u>"] = "<c-u>zz"
lvim.keys.normal_mode["*"] = "*zz"
lvim.keys.normal_mode["<c-w>"] = "<cmd>close<cr>"
lvim.keys.normal_mode["<c-o>"] = "<c-o>zz"
-- open lazygit
lvim.keys.normal_mode["<leader>gg"] = "<cmd>LazyGit<CR>"
-- telescope extra search commands
lvim.keys.normal_mode["<leader>gm"] = function()
  require("telescope.builtin").git_status()
end

-- local cwd = vim.lsp.get_active_clients()[1].config.root_dir
local cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1];
lvim.keys.normal_mode["<leader>aa"] = function() print(cwd) end

lvim.keys.normal_mode["<leader>bf"] = function() require("telescope.builtin").current_buffer_fuzzy_find() end
lvim.keys.normal_mode["<leader>ss"] = function()
  require("telescope.builtin").grep_string({
    cwd = cwd })
end
lvim.keys.normal_mode["<leader>se"] = function()
  require("telescope.builtin").grep_string({
    cwd = cwd,
    word_match = "-w"
  })
end
lvim.keys.normal_mode["<leader>fw"] = function()
  require("telescope.builtin").live_grep({
    cwd = cwd })
end
-- lvim.keys.normal_mode["<leader>st"] = function() require("telescope.builtin").colorscheme({ enable_preview = true }) end
lvim.keys.normal_mode["<leader>st"] = function() require("telescope.builtin").builtin() end
lvim.keys.normal_mode["<leader>sc"] = function() require("telescope.builtin").git_commits() end
-- copy/change/delete word
lvim.keys.normal_mode["cw"] = "ciw"
lvim.keys.normal_mode["yw"] = "yiw"
lvim.keys.normal_mode["dw"] = "diw"
lvim.keys.normal_mode["cW"] = "ciW"
lvim.keys.normal_mode["yW"] = "yiW"
lvim.keys.normal_mode["dW"] = "diW"

-- close buffers
lvim.keys.normal_mode["<leader>ch"] = "<cmd>BufferLineCloseLeft<cr>"
lvim.keys.normal_mode["<leader>cl"] = "<cmd>BufferLineCloseRight<cr>"
-- select all
lvim.keys.normal_mode["<leader>a"] = "<esc>ggVG"
lvim.keys.normal_mode["gd"] = function() require("telescope.builtin").lsp_definitions() end
lvim.keys.normal_mode["<leader>lR"] = function()
  require("telescope.builtin").lsp_references({ show_line = false })
end

-- Git Diff view
lvim.keys.normal_mode["<leader>gd"] = "<cmd>DiffviewOpen<cr>"
lvim.keys.normal_mode["<leader>gw"] = "<cmd>DiffviewClose<cr>"
lvim.keys.normal_mode["<leader>ge"] = "<cmd>DiffviewToggleFiles<cr>"

-- navigate to error
lvim.keys.normal_mode["[d"] = function() vim.diagnostic.goto_prev() end
lvim.keys.normal_mode["]d"] = function() vim.diagnostic.goto_next() end
lvim.keys.normal_mode["<leader>dd"] = function()
  require("telescope.builtin").diagnostics({ show_line = false })
end
-- focus nvim tree on current file
lvim.keys.normal_mode["<leader>o"] = "<cmd>NvimTreeFocus<cr>"

--bufferline
lvim.builtin.bufferline.options = {
  max_name_length = 44,
  max_prefix_length = 43,
}

-- Telescope layouts
lvim.builtin.telescope.extensions = {
  fzf = {
    fuzzy = true,                   -- false will only do exact matching
    override_generic_sorter = true, -- override the generic sorter
    override_file_sorter = true,    -- override the file sorter
    case_mode = "respect_case",     -- or "ignore_case" or "respect_case"
    -- the default case_mode is "smart_case"
  },
}
lvim.builtin.telescope.defaults = {
  vimgrep_arguments = {
    "rg",
    "-L",
    "--color=never",
    "--no-heading",
    "--with-filename",
    "--line-number",
    "--column",
    "--smart-case",
  },
  prompt_prefix = "   ",
  selection_caret = "  ",
  entry_prefix = "  ",
  initial_mode = "insert",
  selection_strategy = "reset",
  sorting_strategy = "ascending",
  layout_strategy = "horizontal",
  layout_config = {
    horizontal = {
      prompt_position = "top",
      preview_width = 0.55,
      results_width = 0.8,
    },
    vertical = {
      mirror = false,
    },
    width = 0.87,
    height = 0.80,
    preview_cutoff = 120,
  },
  -- file_sorter = require("telescope.sorters").get_fuzzy_file,
  file_ignore_patterns = { "node_modules" },
  -- generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
  path_display = { "truncate" },
  winblend = 0,
  border = {},
  borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
  color_devicons = true,
  set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
  file_previewer = require("telescope.previewers").vim_buffer_cat.new,
  grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
  qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
  -- Developer configurations: Not meant for general override
  buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
  mappings = {
    n = {
      ["q"] = require("telescope.actions").close,
    },
    i = {
      ["<C-j>"] = require("telescope.actions").move_selection_next,
      ["<C-k>"] = require("telescope.actions").move_selection_previous,
    }
  },
}

-- -- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["<leader>W"] = { "<cmd>wa<cr>", "Save all files" }
-- lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

-- -- Change theme settings
-- lvim.colorscheme = "lunar"
lvim.colorscheme = "catppuccin-macchiato"

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- adoptive width
lvim.builtin.nvimtree.setup.view.width = {}
lvim.builtin.nvimtree.setup.renderer.icons.show.git = false

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- lvim.builtin.treesitter.ignore_install = { "haskell" }

-- -- always installed on startup, useful for parsers without a strict filetype
-- lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- -- generic LSP settings <https://www.lunarvim.org/docs/languages#lsp-support>

-- --- disable automatic installation of servers
-- lvim.lsp.installer.setup.automatic_installation = false

-- ---configure a server manually. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---see the full default list `:lua =lvim.lsp.automatic_configuration.skipped_servers`
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "pyright" })
-- local opts = {} -- check the lspconfig documentation for a list of all possible options
-- require("lvim.lsp.manager").setup("pyright", opts)

-- ---remove a server from the skipped list, e.g. eslint, or emmet_ls. IMPORTANT: Requires `:LvimCacheReset` to take effect
-- ---`:LvimInfo` lists which server(s) are skipped for the current filetype
-- lvim.lsp.automatic_configuration.skipped_servers = vim.tbl_filter(function(server)
--   return server ~= "emmet_ls"
-- end, lvim.lsp.automatic_configuration.skipped_servers)

-- -- you can set a custom on_attach function that will be used for all the language servers
-- -- See <https://github.com/neovim/nvim-lspconfig#keybindings-and-completion>
-- lvim.lsp.on_attach_callback = function(client, bufnr)
--   local function buf_set_option(...)
--     vim.api.nvim_buf_set_option(bufnr, ...)
--   end
--   --Enable completion triggered by <c-x><c-o>
--   buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
-- end

-- -- linters and formatters <https://www.lunarvim.org/docs/languages#lintingformatting>
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "prettierd", filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" } }
}
local linters = require "lvim.lsp.null-ls.linters"
linters.setup {
  { command = "eslint_d", filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" } },
  -- {
  --   command = "shellcheck",
  --   args = { "--severity", "warning" },
  -- },
}

-- filter out D.TS files from search
local function filter(arr, fn)
  if type(arr) ~= "table" then
    return arr
  end

  local filtered = {}
  for k, v in pairs(arr) do
    if fn(v, k, arr) then
      table.insert(filtered, v)
    end
  end

  return filtered
end

local function filterReactDTS(value)
  -- Depending on typescript version either uri or targetUri is returned
  if value.uri then
    return string.match(value.uri, "%.d.ts") == nil
  elseif value.targetUri then
    return string.match(value.targetUri, "%.d.ts") == nil
  end
end
local handlers = {
  ["textDocument/definition"] = function(err, result, method, ...)
    if vim.tbl_islist(result) and #result > 1 then
      local filtered_result = filter(result, filterReactDTS)
      return vim.lsp.handlers["textDocument/definition"](err, filtered_result, method, ...)
    end

    vim.lsp.handlers["textDocument/definition"](err, result, method, ...)
  end,
}

-- -- Additional Plugins <https://www.lunarvim.org/docs/plugins#user-plugins>
lvim.plugins = {
  -- {
  --   "folke/trouble.nvim",
  --   cmd = "TroubleToggle",
  -- },
  { "catppuccin/nvim" },
  { "github/copilot.vim" },
  {
    "olimorris/persisted.nvim",
    config = function()
      require("persisted").setup {
        use_git_branch = true,
        autoload = true,
        before_save = function() vim.cmd "NvimTreeClose" end,
      }
    end,
  },
  { "kdheepak/lazygit.nvim" },
  { "sindrets/diffview.nvim" },
  {
    "pmizio/typescript-tools.nvim",
    dependency = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("typescript-tools").setup {
        handlers = handlers
      }
    end,
  }
}

-- Disable default typescript server to enable typescript-tools to handle it
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "tsserver" })
-- TS tools key maps
lvim.keys.normal_mode["<leader>io"] = "<cmd>TSToolsOrganizeImports<cr>"
lvim.keys.normal_mode["<leader>ia"] = "<cmd>TSToolsAddMissingImports<cr>"
lvim.keys.normal_mode["<leader>if"] = "<cmd>TSToolsFixAll<cr>"


-- -- Autocommands (`:help autocmd`) <https://neovim.io/doc/user/autocmd.html>
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "zsh",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("nvim-treesitter.highlight").attach(0, "bash")
--   end,
-- })
-- // Autocommand to close quick list after the selection
vim.api.nvim_create_autocmd(
  "FileType", {
    pattern = "qf",
    command = [[nnoremap <buffer> <CR> <CR>:cclose<CR>]]
  })
