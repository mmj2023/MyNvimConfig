return {
    'stevearc/aerial.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {},
    -- Optional dependencies
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
}
