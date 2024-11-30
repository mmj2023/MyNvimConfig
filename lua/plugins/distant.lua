return {
    'chipsenkbeil/distant.nvim',
    -- event = 'VeryLazy',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    branch = 'v0.3',
    config = function()
        require('distant'):setup()
    end,
}
