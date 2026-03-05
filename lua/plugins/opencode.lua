-- opencode.nvim - Neovim frontend for opencode AI agent
-- https://github.com/sudo-tee/opencode.nvim

---@type LazySpec
return {
  "sudo-tee/opencode.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      -- render-markdown 用于在输出窗口渲染 markdown
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    },
    -- completion: 使用 blink.cmp（AstroNvim 默认）
    { "saghen/blink.cmp", optional = true },
    -- picker: 使用 snacks.nvim（AstroNvim 已内置）
    { "folke/snacks.nvim", optional = true },
  },
  config = function()
    require("opencode").setup {
      -- 默认 keymap 前缀
      keymap_prefix = "<leader>k",

      -- 使用 snacks.nvim 作为 picker，blink.cmp 作为补全
      preferred_picker = "snacks",
      preferred_completion = "blink",

      -- 默认模式: build（允许文件修改）
      default_mode = "build",

      keymap = {
        editor = {
          -- quick chat: 用当前行或 visual 选区作为上下文发起快速问答
          ["<leader>k/"] = { "quick_chat", mode = { "n", "x" } },
        },
      },

      -- quick chat 配置
      quick_chat = {
        default_model = nil, -- nil = 沿用当前 session 的 model
        default_agent = "plan", -- plan 模式不修改文件，更安全
        instructions = nil, -- nil = 使用内置 instructions
      },

      ui = {
        position = "right",
        window_width = 0.40,
        display_model = true,
        display_context_size = true,
        icons = {
          preset = "nerdfonts",
        },
      },

      context = {
        enabled = true,
        diagnostics = {
          info = false,
          warn = true,
          error = true,
        },
        current_file = {
          enabled = true,
          show_full_path = true,
        },
        selection = {
          enabled = true,
        },
      },
    }

    -- opencode 编辑文件后自动重载 buffer（必需）
    vim.o.autoread = true
  end,
}
