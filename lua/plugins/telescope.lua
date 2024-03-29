---@type LazySpec
return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "Marskey/telescope-sg",
    "nvim-lua/plenary.nvim",

    -- https://github.com/debugloop/telescope-undo.nvim
    --
    -- Usage:
    -- <leader>sc (search commands), then Telescope undo
    "debugloop/telescope-undo.nvim",
    "smartpde/telescope-recent-files",

    -- https://github.com/AckslD/nvim-neoclip.lua
    {
      "AckslD/nvim-neoclip.lua",
      dependencies = { "kkharji/sqlite.lua" },
      opts = {
        default_register = { "+" },
        enable_persistent_history = true,
      },
      event = "VeryLazy",
    },
  },
  keys = {
    { "<leader><leader>", false },
    {
      "<leader>ff",
      function()
        local cwd = require("telescope.utils").buffer_dir()
        require("telescope.builtin").git_files({
          recurse_submodules = true,
          cwd = cwd,
        })
      end,
      { desc = "Find files (including in git submodules)" },
    },
    {
      -- mnemonic: "paste"
      "<leader>p",
      function()
        --
        require("telescope").extensions.neoclip.default({})
      end,
      { desc = "Paste with telescope (neoclip)" },
    },
  },

  opts = {
    defaults = {
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
    },

    extensions = {
      undo = {
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.8,
        },

        mappings = {
          n = {
            ["<cr>"] = function(bufnr)
              return require("telescope-undo.actions").restore(bufnr)
            end,
          },
          i = {
            ["<cr>"] = function(bufnr)
              return require("telescope-undo.actions").restore(bufnr)
            end,
          },
        },
      },
    },
  },

  config = function(_, opts)
    -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
    -- configs for us. We won't use data, as everything is in it's own namespace (telescope
    -- defaults, as well as each extension).
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("undo")
    telescope.load_extension("recent_files")
    telescope.load_extension("neoclip")
  end,
}
