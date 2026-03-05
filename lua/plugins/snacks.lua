-- Override AstroNvim's default snacks.nvim dashboard with a Pokemon + GitHub layout.
--   pane=1：宝可梦精灵（顶部）+ 快捷键 + 启动时间
--   pane=2：GitHub 信息（自然顶部对齐）

---@type LazySpec
return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      row = nil,
      col = nil,
      width = 60,
      pane_gap = 4,
      sections = {
        -- ── pane 1 顶部：随机宝可梦精灵 ─────────────────────────────────
        -- macOS variant has no --no-title flag; strip the first line (name) with tail
        -- Linux variant supports --no-title natively
        (function()
          local is_mac = vim.uv.os_uname().sysname == "Darwin"
          return {
            pane = 1,
            section = "terminal",
            cmd = is_mac and "pokemon-colorscripts -r | tail -n +2" or "pokemon-colorscripts -r --no-title",
            random = 10,
            indent = 4,
            height = 16,
            padding = 1,
          }
        end)(),

        -- ── pane 1：快捷键 + 启动时间 ────────────────────────────────────
        { section = "keys", gap = 1, padding = 1 },
        { section = "startup" },

        -- ── pane 2：GitHub 信息（顶部对齐） ──────────────────────────────
        function()
          ---@diagnostic disable-next-line: undefined-global
          local in_git = Snacks.git.get_root() ~= nil -- luacheck: ignore
          local has_gh = vim.fn.executable("gh") == 1
          if not has_gh then return {} end

          -- 注入 GH_TOKEN，避免 dashboard 子 shell 无法读取 keyring
          local function with_token(cmd)
            return 'GH_TOKEN="$(gh auth token 2>/dev/null)" ' .. cmd
          end

          local cmds = {
            {
              title = "Notifications",
              cmd = with_token("gh notify -s -a -n5"),
              action = function() vim.ui.open("https://github.com/notifications") end,
              key = "N",
              enabled = true,
            },
            {
              title = "Open Issues",
              cmd = with_token("gh issue list -L 3"),
              key = "i",
              action = function() vim.fn.jobstart("gh issue list --web", { detach = true }) end,
              icon = " ",
              height = 7,
            },
            {
              title = "Open PRs",
              cmd = with_token("gh pr list -L 3"),
              key = "P",
              action = function() vim.fn.jobstart("gh pr list --web", { detach = true }) end,
              icon = " ",
              height = 7,
            },
            {
              title = "Git Status",
              cmd = "git --no-pager diff --stat -B -M -C",
              icon = " ",
              height = 10,
            },
          }

          return vim.tbl_map(function(cmd)
            return vim.tbl_extend("force", {
              pane = 2,
              section = "terminal",
              enabled = in_git,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            }, cmd)
          end, cmds)
        end,
      },
    },
  },
}
