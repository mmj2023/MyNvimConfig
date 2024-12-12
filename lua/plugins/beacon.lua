return {
    'danilamihailov/beacon.nvim',
    -- event = 'VeryLazy',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
} -- lazy calls setup() by itself
