return {
    'ziontee113/color-picker.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = function()
        require('color-picker').setup({ -- for changing icons & mappings
            ['icons'] = { 'ﱢ', '' },
            -- ["icons"] = { "ﮊ", "" },
            -- ["icons"] = { "", "ﰕ" },
            -- ["icons"] = { "", "" },
            -- ["icons"] = { "", "" },
            -- ["icons"] = { "ﱢ", "" },
            -- ["border"] = "rounded", -- none | single | double | rounded | solid | shadow)
        })
    end,
}
