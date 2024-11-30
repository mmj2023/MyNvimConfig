return {
    {
        'stevearc/oil.nvim',
        event = {
            'VimEnter', --[[  "BufReadPost", "BufNewFile", "BufWritePre" ]]
        },
        -- opts = {},
        -- Optional dependencies
        dependencies = { { 'echasnovski/mini.icons', opts = {} } },
        -- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
        config = function()
            require('oil').setup({
                default_file_explorer = true,
                -- skip_confirm_for_simple_edits = true,
                columns = {
                    'icon',
                    -- "permissions",
                    'size',
                    -- "mtime",
                },
                buf_options = {
                    buflisted = false,
                    bufhidden = 'hide',
                },
                view_options = {
                    show_hidden = true, -- Show hidden files by default
                    tree_style = true,
                },
                win_options = {
                    wrap = false,
                    -- signcolumn = "no",
                    cursorcolumn = false,
                    foldcolumn = '0',
                    spell = false,
                    list = false,
                    conceallevel = 3,
                    concealcursor = 'nvic',
                    signcolumn = 'yes:2',
                },
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,
                prompt_save_on_select_new_entry = true,
                cleanup_delay_ms = 2000,
                show_hidden = true, -- Show hidden files
                preview_split = 'left',
            })
            -- vim.cmd[['require("oil").toggle_hidden()']]
        end,
    },
    {
        'refractalize/oil-git-status.nvim',
        event = { 'VimEnter', 'BufReadPost', 'BufNewFile', 'BufWritePre' },

        dependencies = {
            'stevearc/oil.nvim',
        },

        config = true,
    },
}
