return {
    'xiyaowong/transparent.nvim',
    config = function()
      require('transparent').setup()
      require('transparent').toggle(true)
    end
}
