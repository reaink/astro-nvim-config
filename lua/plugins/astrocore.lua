-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    features = {
      large_buf = { size = 1024 * 256, lines = 10000 },
      autopairs = true,
      cmp = true,
      diagnostics = { virtual_text = false, virtual_lines = false }, -- 关闭虚拟文本诊断
      highlighturl = true,
      notifications = true,
    },
    diagnostics = {
      virtual_text = false,
      underline = true,
    },
    options = {
      opt = {
        relativenumber = true,
        number = true,
        spell = false,
        signcolumn = "yes",
        wrap = false,
        cursorcolumn = true,
      },
    },
    mappings = {
      n = {
        ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
        ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
        ["<Leader>bd"] = {
          function()
            require("astroui.status.heirline").buffer_picker(
              function(bufnr) require("astrocore.buffer").close(bufnr) end
            )
          end,
          desc = "Close buffer from tabline",
        },

        -- command mode shortcut
        [";"] = { ":", desc = "Command mode" },

        -- buffer navigation
        L = {
          function() require("astrocore.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
          desc = "Next buffer",
        },
        H = {
          function() require("astrocore.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
          desc = "Previous buffer",
        },
        ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },

        -- save
        ["<C-s>"] = { ":update<cr>", desc = "Save file" },

        -- snacks.picker
        ["<Leader><Leader>"] = { function() Snacks.picker.files() end, desc = "Find files" },
        ["<Leader>/"] = { function() Snacks.picker.grep() end, desc = "Find words" },
        ["<Leader>,"] = { function() Snacks.picker.buffers() end, desc = "Find buffers" },

        -- copy whole file
        ["<C-c>"] = { "<cmd>%y+<cr>", desc = "Copy file" },
      },
      i = {
        ["<C-h>"] = { "<Left>", desc = "Move left" },
        ["<C-j>"] = { "<Down>", desc = "Move down" },
        ["<C-k>"] = { "<Up>", desc = "Move up" },
        ["<C-l>"] = { "<Right>", desc = "Move right" },
      },
    },
  },
}
