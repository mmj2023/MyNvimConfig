return {
    'folke/trouble.nvim',
    -- event = 'VeryLazy',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {},
    config = function()
        require('trouble').setup({})
    end,
}
