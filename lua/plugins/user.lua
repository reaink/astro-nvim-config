---@type LazySpec
return {
  -- Debug print helpers (g?p, g?v, etc.)
  {
    "andrewferrier/debugprint.nvim",
    keys = {
      { "g?", mode = "n", desc = "Debug Print" },
      { "g?", mode = "x", desc = "Debug Print" },
    },
    opts = {
      keymaps = {
        normal = {
          plain_below = "g?p",
          plain_above = "g?P",
          variable_below = "g?v",
          variable_above = "g?V",
          textobj_below = "g?o",
          textobj_above = "g?O",
        },
        visual = {
          variable_below = "g?v",
          variable_above = "g?V",
        },
      },
    },
  },

  -- LazyGit integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile" },
    keys = {
      { "<Leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },

  -- Scrollbar
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
    opts = {
      handlers = { cursor = false },
    },
  },

  -- Mouse hover documentation popup
  {
    "soulis-1256/eagle.nvim",
    event = "VeryLazy",
    opts = {},
  },

  -- Cursor smear effect
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
