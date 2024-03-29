-- https://www.lazyvim.org/plugins/lsp
---@type LazySpec
return {
  "neovim/nvim-lspconfig",

  dependencies = {
    {
      "folke/noice.nvim",
      opts = {
        lsp = {
          signature = {
            enabled = false,
          },
        },
      },
    },
    {
      "ray-x/lsp_signature.nvim",
      event = "VeryLazy",
      opts = {
        -- https://github.com/ray-x/lsp_signature.nvim?tab=readme-ov-file#full-configuration-with-default-values
        bind = true, -- This is mandatory, otherwise border config won't get registered.
        handler_opts = {
          border = "rounded",
        },
      },
      config = function(_, opts)
        require("lsp_signature").setup(opts)
      end,
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        {
          "hrsh7th/cmp-cmdline",
          config = function(_, opts)
            -- https://github.com/hrsh7th/cmp-cmdline
            local cmp = require("cmp")
            -- `/` cmdline setup.
            cmp.setup.cmdline("/", {
              mapping = cmp.mapping.preset.cmdline(),
              sources = {
                { name = "buffer" },
              },
            })

            -- `:` cmdline setup.
            cmp.setup.cmdline(":", {
              mapping = cmp.mapping.preset.cmdline(),
              sources = cmp.config.sources({
                { name = "path" },
              }, {
                {
                  name = "cmdline",
                  option = {
                    ignore_cmds = { "Man", "!" },
                  },
                },
              }),
            })
          end,
        },
      },

      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        local cmp = require("cmp")

        ---@type cmp.ConfigSchema
        local new_options = {
          window = {
            completion = cmp.config.window.bordered({
              winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
            }),
            documentation = cmp.config.window.bordered({
              winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
            }),
          },
        }
        return vim.tbl_deep_extend("keep", new_options, opts)
      end,
    },
  },

  init = function()
    -- configure keymaps here
    -- https://www.lazyvim.org/plugins/lsp#%EF%B8%8F-customizing-lsp-keymaps
    -- local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- -- change a keymap
    -- keys[#keys + 1] = { "K", "<cmd>echo 'hello'<cr>" }
    -- -- disable a keymap
    -- keys[#keys + 1] = { "K", false }
    -- -- add a keymap
    -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
  end,

  opts = {

    servers = {
      tsserver = {
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayVariableTypeHints = true,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all'
              includeInlayParameterNameHintsWhenArgumentMatchesName = true,
              includeInlayVariableTypeHints = true,

              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHintsWhenTypeMatchesName = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
    },
    inlay_hints = {
      enabled = true,
    },
    setup = {},
  },
}
