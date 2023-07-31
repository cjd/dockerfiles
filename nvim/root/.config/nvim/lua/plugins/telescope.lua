return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {'nvim-lua/plenary.nvim'},
    config = function()
        require("telescope").setup({
            defaults =  {
                prompt_prefix='🔍',
                layout_strategy = 'vertical',
                mappings = {
                    i = {
                        ["<esc>"] = require("telescope.actions").close
                    },
                },
            },
        })
    end
}
