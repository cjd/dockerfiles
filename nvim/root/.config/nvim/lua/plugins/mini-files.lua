return {
  "echasnovski/mini.files",
  version = false,
  keys = { { "<leader>e", ":lua MiniFiles.open()<cr>", { slient=true, desc = "Files"}}},
  config = function()
    require('mini.files').setup(
    {
      mappings = {
        close       = 'q',
        go_in       = '<S-Right>',
        go_in_plus  = '<Enter>',
        go_out      = '<S-Left>',
        go_out_plus = 'H',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
      }
    }
    )
  end
}
