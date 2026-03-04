-- Customize Mason packages
-- v5 uses mason-tool-installer instead of mason-lspconfig/mason-null-ls/mason-nvim-dap
-- Package names must match what's shown in `:Mason`

---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        -- LSP servers (not covered by language packs)
        "lua-language-server",
        "emmet-language-server",
        "graphql-language-service-cli",

        -- Formatters
        "stylua",

        -- Debuggers
        "debugpy",
      },
    },
  },
}
