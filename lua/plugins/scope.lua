return {
    'tiagovla/scope.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {},
    config = function()
        require('scope').setup({})
    end,
}
