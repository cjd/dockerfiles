return {
  'lukas-reineke/indent-blankline.nvim',
  config = function()
    vim.opt.list = true

    local highlight = {
      "CursorColumn",
      "Whitespace",
    }
    require("ibl").setup {
    }
  end
}

