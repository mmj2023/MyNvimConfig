return {
    {
        'folke/playground',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    },
    -- event = { "BufReadPost", "BufNewFile", "BufWritePre" }, },
    {
        'nvim-treesitter/nvim-treesitter-textobjects',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    },
    {
        'nvim-treesitter/nvim-treesitter-refactor',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    },
    {
        'windwp/nvim-ts-autotag',
        event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    },
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufNewFile', 'BufReadPre' },
    build = ':TSUpdate',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
        'nvim-treesitter/nvim-treesitter-refactor',
        'nvim-treesitter/nvim-treesitter-context',
        'windwp/nvim-ts-autotag',
    },
    config = function()
        --setting up treesitter
        playground = {
            enable = true,
            disable = {},
            updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
            persist_queries = false, -- Whether the query persists across vim sessions
            keybindings = {
                toggle_query_editor = 'o',
                toggle_hl_groups = 'i',
                toggle_injected_languages = 't',
                toggle_anonymous_nodes = 'a',
                toggle_language_display = 'I',
                focus_language = 'f',
                unfocus_language = 'F',
                update = 'R',
                goto_node = '<cr>',
                show_help = '?',
            },
        }
        local configs = require('nvim-treesitter.configs')
        configs.setup({
            autotag = {
                enable = true,
            },
            ensure_installed = {
                'help',
                'c',
                'cpp',
                'haskell',
                'http',
                'lua',
                'vim',
                'vimdoc',
                'query',
                'elixir',
                'heex',
                'javascript',
                'html',
                'bash',
                'asm',
                'cuda',
                'css',
                'dockerfile',
                'elixir',
                'gitignore',
                'git_config',
                'gitcommit',
                'gitattributes',
                'markdown',
                'go',
                'json',
                -- "latex",
                'htmldjango',
                'java',
                'json5',
                'julia',
                'markdown_inline',
                'kotlin',
                'latex',
                'luadoc',
                'make',
                'nix',
                'ocaml',
                'php',
                'python',
                'r',
                'ruby',
                'rust',
                'sql',
                'swift',
                'toml',
                'typescript',
                'xml',
                'yaml',
                'zig',
            },
            --sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = { 'ruby' },
            },
            indent = { enable = true }, -- disable = { "ruby" }
            refactor = {
                highlight_current_scope = { enable = true },
                highlight_definitions = {
                    enable = true,
                    -- Set to false if you have an `updatetime` of ~100.
                    clear_on_cursor_move = true,
                },
                navigation = {
                    enable = true,
                    -- Assign keymaps to false to disable them, e.g. `goto_definition = false`.
                    keymaps = {
                        goto_definition_lsp_fallback = 'gd',
                        list_definitions = 'gnD',
                        list_definitions_toc = 'gO',
                        goto_next_usage = '<a-*>',
                        goto_previous_usage = '<a-#>',
                    },
                },
                smart_rename = {
                    enable = true,
                    -- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
                    keymaps = {
                        smart_rename = 'grr',
                    },
                },
            },
            textobjects = {
                select = {
                    enable = true,

                    -- Automatically jump forward to textobj, similar to targets.vim
                    lookahead = true,

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        -- You can optionally set descriptions to the mappings (used in the desc parameter of
                        -- nvim_buf_set_keymap) which plugins like which-key display
                        ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
                        -- You can also use captures from other query groups like `locals.scm`
                        ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
                    },
                    -- You can choose the select mode (default is charwise 'v')
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * method: eg 'v' or 'o'
                    -- and should return the mode ('v', 'V', or '<c-v>') or a table
                    -- mapping query_strings to modes.
                    selection_modes = {
                        ['@parameter.outer'] = 'v', -- charwise
                        ['@function.outer'] = 'V', -- linewise
                        ['@class.outer'] = '<c-v>', -- blockwise
                    },
                    -- If you set this to `true` (default is `false`) then any textobject is
                    -- extended to include preceding or succeeding whitespace. Succeeding
                    -- whitespace has priority in order to act similarly to eg the built-in
                    -- `ap`.
                    --
                    -- Can also be a function which gets passed a table with the keys
                    -- * query_string: eg '@function.inner'
                    -- * selection_mode: eg 'v'
                    -- and should return true or false
                    include_surrounding_whitespace = true,
                },

                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['<leader>A'] = '@parameter.inner',
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = { query = '@class.outer', desc = 'Next class start' },
                        --
                        -- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
                        [']o'] = '@loop.*',
                        -- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
                        --
                        -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
                        -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
                        [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
                        [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer',
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer',
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer',
                    },
                    -- Below will go to either the start or the end, whichever is closer.
                    -- Use if you want more granular movements
                    -- Make it even more gradual by adding multiple queries and regex.
                    goto_next = {
                        [']d'] = '@conditional.outer',
                    },
                    goto_previous = {
                        ['[d'] = '@conditional.outer',
                    },
                },
                lsp_interop = {
                    enable = true,
                    border = 'none',
                    floating_preview_opts = {},
                    peek_definition_code = {
                        ['<leader>df'] = '@function.outer',
                        ['<leader>dF'] = '@class.outer',
                    },
                },
            },
        })
        require('nvim-ts-autotag').setup({
            opts = {
                -- Defaults
                enable_close = true, -- Auto close tags
                enable_rename = true, -- Auto rename pairs of tags
                enable_close_on_slash = false, -- Auto close on trailing </
            },
            -- Also override individual filetype configs, these take priority.
            -- Empty by default, useful if one of the "opts" global settings
            -- doesn't work well in a specific filetype
            -- per_filetype = {
            --   ["html"] = {
            --     enable_close = false
            --   }
            -- }
        })
        require('treesitter-context').setup({
            enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 4, -- How many lines the window should span. Values <= 0 mean no limit.
            min_window_height = 4, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
            line_numbers = true,
            multiline_threshold = 2, -- Maximum number of lines to show for a single context
            trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
            -- Separator between context and content. Should be a single character string, like '-'.
            -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
            separator = nil,
            zindex = 20, -- The Z-index of the context window
            on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
        })
        -- Prefer git instead of curl in order to improve connectivity in some environments
        -- require('nvim-treesitter.install').prefer_git = true
        vim.keymap.set('n', '<leader>[c', function()
            require('treesitter-context').go_to_context(vim.v.count1)
        end, { silent = true })
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
}
