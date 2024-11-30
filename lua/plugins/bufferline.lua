return {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
        options = {
            mode = 'buffers',
            -- style_preset = bufferline.style_preset.default,
            themable = true,
            numbers = 'none',
            close_command = 'bdelete! %d',
            right_mouse_command = 'bdelete! %d',
            left_mouse_command = 'buffer %d',
            middle_mouse_command = nil,
            indicator = {
                icon = '▎',
                style = 'underline', -- Change this to 'icon', 'underline', or 'none'
            },
            -- buffer_close_icon = '',--
            -- modified_icon = '●',
            close_icon = '',
            -- left_trunc_marker = '',
            -- right_trunc_marker = '',
            -- max_name_length = 18,
            -- max_prefix_length = 15,
            -- tab_size = 18,
            diagnostics = 'nvim_lsp',
            diagnostics_indicator = function(_, _, diag)
                local icons = {
                    Error = ' ',
                    Warn = ' ',

                    Hint = ' ',

                    Info = ' ',
                }
                local ret = (diag.error and icons.Error .. diag.error .. ' ' or '')
                    .. (diag.warning and icons.Warn .. diag.warning or '')
                return vim.trim(ret)
            end,
            -- diagnostics_update_in_insert = true,
            offsets = { { filetype = 'Oil', text = 'File Explorer', text_align = 'left' } },
            show_buffer_icons = true,
            show_buffer_close_icons = true,
            show_close_icon = true,
            show_tab_indicators = true,
            persist_buffer_sort = true,
            separator_style = 'slant', -- Change this to "slant", "thick", "thin", "padded_slant", or a custom table
            enforce_regular_tabs = false,
            always_show_bufferline = true,

            sort_by = 'id',
            --  get_element_icon = function(opts)
            --   return {
            --     octo = "",
            -- }[opts.filetype]
            -- end,
        },
    },
    -- config = function(_, opts)
    --   -- vim.cmd [[
    --   --     " highlight TabLineSel guibg=#ff0000 guifg=#ffffff gui=bold
    --   --     highlight BufferLineFill guibg=#1e1e1e
    --   --     highlight BufferLineBackground guibg=#1e1e1e guifg=#5c6370
    --   --     " highlight BufferLineBufferSelected guibg=#ff0000 guifg=#ffffff gui=bold
    --   --     highlight BufferLineBufferVisible guibg=#1e1e1e guifg=#5c6370
    --   --     highlight BufferLineSeparator guibg=#1e1e1e guifg=#1e1e1e
    --   --     highlight BufferLineSeparatorVisible guibg=#1e1e1e guifg=#1e1e1e
    --   --     " highlight BufferLineSeparatorSelected guibg=#ff0000 guifg=#ff0000
    --   --     " highlight BufferLineIndicatorSelected guibg=#ff0000 guifg=#ff0000
    --   -- ]]
    --   -- vim.api.nvim_set_hl(0, 'BufferLineIndicatorUnderline', { fg = '#ff0000', underline = true })
    --   require("bufferline").setup(opts)
    -- end,
}
