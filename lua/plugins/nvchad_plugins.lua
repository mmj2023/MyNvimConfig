return {
    {
        'nvchad/volt',
        -- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        event = { 'VimEnter' },
        -- opts = {},
    },
    {
        'nvchad/menu',
        -- event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        event = { 'VimEnter' },
        -- opts = {},
        keys = {
            {
                '<leader>me',
                function()
                    require('menu').open('default')
                end,
                desc = 'Menu',
            },
        },
    },
    {
        'nvchad/minty',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
        -- opts = {},
    },
}
