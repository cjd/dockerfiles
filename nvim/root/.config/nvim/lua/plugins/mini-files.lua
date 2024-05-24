return {
  "echasnovski/mini.files",
  version = false,
  keys = { { "<leader>e", ":lua MiniFiles.open()<cr>", { slient=true, desc = "Files"}}},
  config = function()
    require('mini.files').setup()
  end
}
