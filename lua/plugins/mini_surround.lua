return {
    'echasnovski/mini.surround',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
        mappings = {
            add = 'gsa',
            delete = 'gsd',
            find = 'gsf',
            find_left = 'gsF',
            highlight = 'gsh',
            replace = 'gsr',
            update_n_lines = 'gsn',
        },
    },
    -- config = function()
    -- require("mini").setup {
    -- end,
}
