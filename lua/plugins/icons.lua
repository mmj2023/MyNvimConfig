return {
    -- {
    --     'nvim-tree/nvim-web-devicons',
    --     opts = {
    --         color_icons = true,
    --         strict = true,
    --         override_by_filename = {
    --             ['.gitignore'] = {
    --                 icon = '',
    --                 color = '#f1502f',
    --                 name = 'Gitignore',
    --             },
    --         },
    --         override = {
    --             zsh = {
    --                 icon = '', --
    --                 color = '#428850',
    --                 cterm_color = '65',
    --                 name = 'Zsh',
    --             },
    --         },
    --         override_by_extension = {
    --
    --             ['log'] = {
    --                 icon = '',
    --                 color = '#81e043',
    --                 name = 'Log',
    --             },
    --         },
    --     },
    --     config = function(_, opts)
    --         --setting up web dev icons
    --         require('lua.plugins.icons').setup(opts)
    --     end,
    -- },
    {
        'echasnovski/mini.icons',
        version = false,
        opts = {},
    },
}
