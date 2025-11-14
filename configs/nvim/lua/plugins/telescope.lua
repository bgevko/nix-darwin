return {
  -- Trouble (dependency)
  {
    "folke/trouble.nvim",
    opts = {
      use_diagnostic_signs = true,
    },
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "folke/trouble.nvim",
    },

    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local trouble = require("trouble.sources.telescope")

      telescope.setup({
        defaults = {
          prompt_prefix = " ",
          selection_caret = " ",
          sorting_strategy = "ascending",

          layout_config = {
            prompt_position = "top",
          },

          mappings = {
            i = {
              ["<C-Down>"] = actions.cycle_history_next,
              ["<C-Up>"] = actions.cycle_history_prev,
              ["<C-f>"] = actions.preview_scrolling_down,
              ["<C-b>"] = actions.preview_scrolling_up,
              ["<C-t>"] = trouble.open,
              ["<A-t>"] = trouble.open,
            },
            n = {
              ["q"] = actions.close,
            },
          },
        },

        pickers = {
          find_files = {
            hidden = true,
            find_command = (function()
              if vim.fn.executable("rg") == 1 then
                return { "rg", "--files", "--color", "never", "-g", "!.git" }
              elseif vim.fn.executable("fd") == 1 then
                return { "fd", "--type", "f", "--color", "never", "-E", ".git" }
              elseif vim.fn.executable("fdfind") == 1 then
                return { "fdfind", "--type", "f", "--color", "never", "-E", ".git" }
              elseif vim.fn.executable("find") == 1 and vim.fn.has("win32") == 0 then
                return { "find", ".", "-type", "f" }
              elseif vim.fn.executable("where") == 1 then
                return { "where", "/r", ".", "*" }
              end
            end)(),
          },
        },
      })

      telescope.load_extension("fzf")

      -- Keymaps
      local map = vim.keymap.set
      map("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
      map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>")
      map("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
      map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>")
      map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
      map("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>")
      map("n", "<leader>sk", "<cmd>Telescope keymaps<cr>")
      map("n", "<leader>sr", "<cmd>Telescope resume<cr>")
      map("n", "<leader>sC", "<cmd>Telescope commands<cr>")
      map("n", "<leader>sH", "<cmd>Telescope highlights<cr>")
      map("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<cr>")
      map("n", "<leader>sS", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>")
      map("n", "<leader>uC", "<cmd>Telescope colorscheme<cr>")
      map("n", "<leader>/", "<cmd>Telescope live_grep<cr>")
    end,
  },
}
