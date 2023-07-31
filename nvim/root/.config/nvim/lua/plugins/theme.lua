return {
    "neanias/everforest-nvim",
    version = false,
    lazy = false,
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
        require('everforest').setup({
            background = "medium",
            transparent_backround_level = 1
        })
        vim.cmd [[set background=dark ]]
        vim.cmd [[colorscheme everforest]]
    end
}
