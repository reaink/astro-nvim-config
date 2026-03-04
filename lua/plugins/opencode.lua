-- opencode.nvim - Neovim integration for the opencode AI assistant
-- https://github.com/nickjvandyke/opencode.nvim

---@type LazySpec
return {
  "nickjvandyke/opencode.nvim",
  version = "*", -- 使用最新稳定版
  dependencies = {
    {
      -- snacks.nvim 已在 AstroNvim 中安装，提供更好的 input/picker 体验
      ---@module "snacks"
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {}, -- 增强 ask() 输入体验
        picker = {
          actions = {
            opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
          },
          win = {
            input = {
              keys = {
                -- 在 snacks picker 中按 <Alt-a> 发送选中文件给 opencode
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    ---@type opencode.Opts
    vim.g.opencode_opts = {
      -- 如需自定义配置，在此处添加
      -- 完整选项参见 :h opencode 或 github.com/nickjvandyke/opencode.nvim
    }

    -- opencode 编辑文件后自动重载 buffer（必需）
    vim.o.autoread = true

    -- ─── 核心操作（<Leader>a 前缀，a = AI）────────────────────────
    -- <Leader>aa  询问 opencode（当前上下文/选区）
    vim.keymap.set({ "n", "x" }, "<Leader>aa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "Ask opencode" })

    -- <Leader>as  打开 opencode 操作菜单（prompts / commands / 会话控制）
    vim.keymap.set({ "n", "x" }, "<Leader>as", function()
      require("opencode").select()
    end, { desc = "Opencode actions" })

    -- <Leader>ac  选择要连接的 opencode 实例（多实例时使用）
    vim.keymap.set("n", "<Leader>ac", function()
      require("opencode.server").get_all():next(function(servers)
        require("opencode.ui.select_server").select_server(servers)
      end)
    end, { desc = "Connect to opencode server" })

    -- <Leader>at  切换 opencode 终端面板
    vim.keymap.set({ "n", "t" }, "<Leader>at", function()
      require("opencode").toggle()
    end, { desc = "Toggle opencode" })

    -- ─── Operator 模式（范围操作，支持 dot-repeat）────────────────
    -- go{motion}  将指定范围发送给 opencode（如 goip 发送当前段落）
    vim.keymap.set({ "n", "x" }, "go", function()
      return require("opencode").operator("@this ")
    end, { desc = "Send range to opencode", expr = true })

    -- goo  发送当前行给 opencode
    vim.keymap.set("n", "goo", function()
      return require("opencode").operator("@this ") .. "_"
    end, { desc = "Send line to opencode", expr = true })

    -- ─── 滚动 opencode 面板 ──────────────────────────────────────
    vim.keymap.set("n", "<S-C-u>", function()
      require("opencode").command("session.half.page.up")
    end, { desc = "Scroll opencode up" })

    vim.keymap.set("n", "<S-C-d>", function()
      require("opencode").command("session.half.page.down")
    end, { desc = "Scroll opencode down" })
  end,
}
