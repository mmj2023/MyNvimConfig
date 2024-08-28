vim.opt.expandtab = true
vim.loader.enable()
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.cmd("set termguicolors")
vim.cmd("set rtp+=/nix/store/jvgx1h2p9lp60wdakrc5ha3fmv86imxq-fzf-0.53.0/bin/fzf")
-- vim.cmd("set rtp+=/nix/store/jvgx1h2p9lp60wdakrc5ha3fmv86imxq-fzf-0.53.0/bin/fzf")

-- vim.cmd('highlight Cursor guifg=NONE guibg=NONE')
-- vim.cmd("set guicursor=n-v-c:block-Cursor")
-- vim.cmd("set guicursor+=i:ver100-iCursor")
vim.cmd("highlight Cursor guifg=NONE guibg=NONE")
-- vim.cmd("highlight iCursor guifg=NONE guibg=NONE")
vim.wo.number = true
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.pumblend = 0
vim.o.winblend = 0
-- vim.o.background = "dark"
vim.opt.hlsearch = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- listchars
vim.opt.list = true
vim.opt.listchars = {
	eol = "↴",
	tab = "» ",
	trail = "·",
	nbsp = "␣",
	-- signcolumn = 'yes',
	-- space = '·',
}
function enable_list()
	-- vim.opt_local.list = true
	vim.cmd("set listchars+=space:·")
	vim.cmd("set list")
	-- vim.opt_local.listchars:append("space:·")
end

function disable_list()
	-- vim.opt_local.list = false
	-- vim.cmd("set nolist")
	-- vim.opt_local.listchars:remove("space:·")
	-- vim.opt_local.list = true
	vim.cmd("set listchars-=space:·")
	vim.cmd("set list")
end

-- Set up autocmd for mode changes
vim.api.nvim_create_autocmd("ModeChanged", {
	pattern = "*", -- Apply to all file types (customize as needed)
	callback = function()
		local mode = vim.fn.mode()
		if mode == "v" or mode == "V" then
			enable_list()
		else
			disable_list()
		end
	end,
})

vim.opt.incsearch = true
vim.opt.swapfile = false
-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = "a"
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- Decrease update time
vim.opt.updatetime = 50
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
-- keymaps
vim.keymap.set("x", "<leader>p", '"_dp')
-- vim.keymap.set("n", "<leader>y", "\"+y" )
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
-- vim.keymap.set("n", "<Esc>", "cmd>nohlsearch<CR>", {})
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {})
-- vim.keymap.set("n", "<Esc>", "cmd>nohlsearch<CR>", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("my-highlight-on-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
vim.g.toggle_theme_icon = "   "
-- local icons = {
--     misc = {
--       dots = "󰇘",
--     },
--     ft = {
--       octo = "",
--     },
--     dap = {
--       Stopped             = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
--       Breakpoint          = " ",
--       BreakpointCondition = " ",
--       BreakpointRejected  = { " ", "DiagnosticError" },
--       LogPoint            = ".>",
--     },
--     diagnostics = {
--       Error = " ",
--       Warn  = " ",
--
--       Hint  = " ",
--
--       Info  = " ",
--     },
--     git = {
--       added    = " ",
--       modified = " ",
--
--       removed  = " ",
--     },
--     kinds = {
--       Array         = " ",
--
--       Boolean       = "󰨙 ",
--       Class         = " ",
--       Codeium       = "󰘦 ",
--       Color         = " ",
--       Control       = " ",
--       Collapsed     = " ",
--       Constant      = "󰏿 ",
--       Constructor   = " ",
--       Copilot       = " ",
--       Enum          = " ",
--       EnumMember    = " ",
--       Event         = " ",
--       Field         = " ",
--       File          = " ",
--       Folder        = " ",
--       Function      = "󰊕 ",
--       Interface     = " ",
--       Key           = " ",
--       Keyword       = " ",
--
--       Method        = "󰊕 ",
--       Module        = " ",
--       Namespace     = "󰦮 ",
--       Null          = " ",
--       Number        = "󰎠 ",
--
--       Object        = " ",
--
--       Operator      = " ",
--       Package       = " ",
--       Property      = " ",
--       Reference     = " ",
--       Snippet       = " ",
--       String        = " ",
--       Struct        = "󰆼 ",
--
--       TabNine       = "󰏚 ",
--       Text          = " ",
--       TypeParameter = " ",
--       Unit          = " ",
--
--       Value         = " ",
--
--       Variable      = "󰀫 ",
--     },
--   }
--installing lazy and getting it started up
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.oop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
	"tpope/vim-sleuth",
	{ "numToStr/Comment.nvim", opts = {} },
	{ -- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "" }, --+
				change = { text = "" }, --~
				delete = { text = "" }, --_
				topdelete = { text = "" }, --‾󰍵
				changedelete = { text = "󱕖" }, --~󱕖
				-- add          = {hl = 'GitGutterAdd', text = '󰅚', numhl='GitGutterAddNr', linehl='GitGutterAddLn'},
				-- change       = {hl = 'GitGutterChange', text = '󰋽', numhl='GitGutterChangeNr', linehl='GitGutterChangeLn'},
				-- delete       = {hl = 'GitGutterDelete', text = '󰌶', numhl='GitGutterDeleteNr', linehl='GitGutterDeleteLn'},
				-- topdelete    = {hl = 'GitGutterDelete', text = '󰌶', numhl='GitGutterDeleteNr', linehl='GitGutterDeleteLn'},
				-- changedelete = {hl = 'GitGutterChange', text = '󰋽', numhl='GitGutterChangeNr', linehl='GitGutterChangeLn'},
			},
			sign_priority = 4,
			update_debounce = 100,
			status_formatter = nil, -- Use default
		},
		config = function(_, opts)
			vim.keymap.set("n", "<leader>gp", "Gitsigns prev_hunk", { noremap = true, silent = true })
			vim.keymap.set("n", "<leader>gtb", "Gitsigns toggle_current_line_blame", { noremap = true, silent = true })
			require("gitsigns").setup(opts)
		end,
		--[[
    --{
              signs = {
                add = { text = '' },--+
                change = { text = '' },--~
                delete = { text = '' },--_
                topdelete = { text = '' },--‾󰍵
                changedelete = { text = '󱕖' },--~󱕖
                -- add          = {hl = 'GitGutterAdd', text = '󰅚', numhl='GitGutterAddNr', linehl='GitGutterAddLn'},
                -- change       = {hl = 'GitGutterChange', text = '󰋽', numhl='GitGutterChangeNr', linehl='GitGutterChangeLn'},
                -- delete       = {hl = 'GitGutterDelete', text = '󰌶', numhl='GitGutterDeleteNr', linehl='GitGutterDeleteLn'},
                -- topdelete    = {hl = 'GitGutterDelete', text = '󰌶', numhl='GitGutterDeleteNr', linehl='GitGutterDeleteLn'},
                -- changedelete = {hl = 'GitGutterChange', text = '󰋽', numhl='GitGutterChangeNr', linehl='GitGutterChangeLn'},
              },
              sign_priority = 4,
              update_debounce = 100,
              status_formatter = nil, -- Use default

      }
    --]]
	},
	{
		"mbbill/undotree",
		event = "VeryLazy",
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
		end,
	},
	{
		"tpope/vim-fugitive",
		event = "VeryLazy",
		opts = {},
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},
	-- Highlight todo, notes, etc in comments
	{
		"folke/todo-comments.nvim",
		event = "VimEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = { signs = true },
	},
	{
		"folke/tokyonight.nvim",
		-- lazy = true,
		-- priority = 1000,
		-- opts = {},
		config = function()
			require("tokyonight").setup({
				transparent = vim.g.transparent_enabled,
			})
		end,
	},
	{
		"yardnsm/nvim-base46",
		-- lazy = false,
		-- priority = 1000,
		-- opts = {},
		event = "VeryLazy",
		config = function()
			require("nvim-base46").setup({
				transparent = vim.g.transparent_enabled,
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		-- priority = 10000,
		config = function()
			--	--setting up the colorscheme
			require("catppuccin").setup({
				--	vim.o.background = "dark"
				--	vim.cmd.colorscheme("catppuccin")
				transparent = vim.g.transparent_enabled,
			})
		end,
	},
	{
		"tiagovla/tokyodark.nvim",
		-- priority = 10000,
		opts = {
			-- custom options here
			transparent = vim.g.transparent_enabled,
		},
		config = function(_, opts)
			require("tokyodark").setup(opts) -- calling setup is optional
			-- vim.cmd [[colorscheme tokyodark]]
		end,
	},
	{
		"adelarsq/image_preview.nvim",
		event = "VeryLazy",
		config = function()
			require("image_preview").setup()
		end,
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		event = "VimEnter",
		dependencies = {
			"nvim-lua/popup.nvim",
		},
		config = function()
			require("telescope").setup({
				extensions = {
					media_files = {
						-- filetypes whitelist
						-- defaults to {"png", "jpg", "mp4", "webm", "pdf"}
						filetypes = { "png", "webp", "mp4", "jpg", "webm", "pdf", "jpeg" },
						-- find command (defaults to `fd`)
						find_cmd = "rg",
					},
				},
			})
			require("telescope").load_extension("media_files")
		end,
	},
	-- {
	-- 	{
	--      {
	--        "nvim-telescope/telescope-fzf-native.nvim",
	--        build = "make",
	--        config = function()
	--          --setting up telescope fzf native
	--          require("telescope").load_extension("fzf")
	--        end,
	--      },
	-- 		"nvim-telescope/telescope.nvim",
	--      -- event = "VimEnter",
	-- 		branch = "0.1.6",
	-- 		dependencies = { "nvim-lua/plenary.nvim",
	--                       "nvim-tree/nvim-web-devicons",
	--                       "nvim-telescope/telescope-fzf-native.nvim",
	--      },
	-- 		config = function()
	-- 			--setting up telescope fuzzy finding and telescope related keymap
	--        require('telescope').setup({
	--            defaults = {
	--                vimgrep_arguments = {
	--                    'rg',
	--                    '--color=never',
	--                    '--no-heading',
	--                    '--with-filename',
	--                    '--line-number',
	--                    '--column',
	--                    '--smart-case',
	--                    '--hidden',    -- Include hidden files
	--                    '--no-ignore'  -- Override ignore patterns
	--                }
	--            }
	--        })
	-- 			local builtin = require("telescope.builtin")
	-- 			vim.keymap.set("n", "<leader>fs", builtin.find_files, {})
	-- 			vim.keymap.set("n", "<Space>gf", builtin.git_files, {})
	-- 			vim.keymap.set("n", "<Space>gs", builtin.grep_string, {})
	-- 			vim.keymap.set("n", "<Space>fg", builtin.live_grep, {})
	-- 			vim.keymap.set("n", "<Space>fb", builtin.buffers, {})
	-- 			vim.keymap.set("n", "<Space>fh", builtin.help_tags, {})
	-- 		end,
	-- 	},
	-- 	{
	-- 		"nvim-telescope/telescope-ui-select.nvim",
	-- 		config = function()
	-- 			-- This is your opts table
	-- 			require("telescope").setup({
	-- 				extensions = {
	-- 					["ui-select"] = {
	-- 						require("telescope.themes").get_dropdown({
	-- 							-- even more opts
	-- 						}),
	--
	-- 						-- pseudo code / specification for writing custom displays, like the one
	-- 						-- for "codeactions"
	-- 						-- specific_opts = {
	-- 						--   [kind] = {
	-- 						--     make_indexed = function(items) -> indexed_items, width,
	-- 						--     make_displayer = function(widths) -> displayer
	-- 						--     make_display = function(displayer) -> function(e)
	-- 						--     make_ordinal = function(e) -> string
	-- 						--   },
	-- 						--   -- for example to disable the custom builtin "codeactions" display
	-- 						--      do the following
	-- 						--   codeactions = false,
	-- 						-- }
	-- 					},
	-- 				},
	-- 			})
	-- 			-- To get ui-select loaded and working with telescope, you need to call
	-- 			-- load_extension, somewhere after setup function:
	-- 			require("telescope").load_extension("ui-select")
	-- 		end,
	-- 	},
	-- },
	{ -- Fuzzy Finder (files, lsp, etc)
		"nvim-telescope/telescope.nvim",
		event = "VimEnter",
		branch = "0.1.x",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ -- If encountering errors, see telescope-fzf-native README for installation instructions
				"nvim-telescope/telescope-fzf-native.nvim",

				-- `build` is used to run some command when the plugin is installed/updated.
				-- This is only run then, not every time Neovim starts up.
				build = "make",

				-- `cond` is a condition used to determine whether this plugin should be
				-- installed and loaded.
				cond = function()
					return vim.fn.executable("make") == 1
				end,
			},
			{ "nvim-telescope/telescope-ui-select.nvim" },

			-- Useful for getting pretty icons, but requires a Nerd Font.
			-- { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
		},
		config = function()
			-- Telescope is a fuzzy finder that comes with a lot of different things that
			-- it can fuzzy find! It's more than just a "file finder", it can search
			-- many different aspects of Neovim, your workspace, LSP, and more!
			--
			-- The easiest way to use Telescope, is to start by doing something like:
			--  :Telescope help_tags
			--
			-- After running this command, a window will open up and you're able to
			-- type in the prompt window. You'll see a list of `help_tags` options and
			-- a corresponding preview of the help.
			--
			-- Two important keymaps to use while in Telescope are:
			--  - Insert mode: <c-/>
			--  - Normal mode: ?
			--
			-- This opens a window that shows you all of the keymaps for the current
			-- Telescope picker. This is really useful to discover what Telescope can
			-- do as well as how to actually do it!

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require("telescope").setup({
				-- You can put your default mappings / updates / etc. in here
				--  All the info you're looking for is in `:help telescope.setup()`
				--
				-- defaults = {
				--   mappings = {
				--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
				--   },
				-- },
				-- pickers = {}
				defaults = {
					prompt_prefix = "   ",
					selection_caret = " ",
					entry_prefix = " ",
					sorting_strategy = "ascending",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.55,
						},
						width = 0.87,
						height = 0.80,
					},
				},
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			-- Enable Telescope extensions if they are installed
			pcall(require("telescope").load_extension, "fzf")
			pcall(require("telescope").load_extension, "ui-select")

			-- See `:help telescope.builtin`
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[S]earch [H]elp" })
			vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
			vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "[S]earch [F]iles" })
			vim.keymap.set("n", "<leader>fs", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
			vim.keymap.set("n", "<leader>fw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
			vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
			vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
			vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "[S]earch [R]esume" })
			vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[ ] Find existing buffers" })

			-- Slightly advanced example of overriding default behavior and theme
			vim.keymap.set("n", "<leader>/", function()
				-- You can pass additional configuration to Telescope to change the theme, layout, etc.
				builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
					winblend = 10,
					previewer = false,
				}))
			end, { desc = "[/] Fuzzily search in current buffer" })

			-- It's also possible to pass additional configuration options.
			--  See `:help telescope.builtin.live_grep()` for information about particular keys
			vim.keymap.set("n", "<leader>s/", function()
				builtin.live_grep({
					grep_open_files = true,
					prompt_title = "Live Grep in Open Files",
				})
			end, { desc = "[S]earch [/] in Open Files" })

			-- Shortcut for searching your Neovim configuration files
			vim.keymap.set("n", "<leader>fmn", function()
				builtin.find_files({ cwd = vim.fn.stdpath("config") })
			end, { desc = "[S]earch [N]eovim files" })
		end,
	},
	{
		"chipsenkbeil/distant.nvim",
		event = "VeryLazy",
		branch = "v0.3",
		config = function()
			require("distant"):setup()
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local harpoon = require("harpoon")
			-- REQUIRED
			harpoon:setup()
			-- REQUIRED

			-- local mark = require("harpoon.mark")
			-- local ui = require("harpoon.ui")
			vim.keymap.set("n", "<leader>+", function()
				harpoon:list():add()
			end)
			vim.keymap.set("n", "<C-e>", function()
				harpoon.ui:toggle_quick_menu(harpoon:list())
			end)

			vim.keymap.set("n", "<C-Up>", function()
				harpoon:list():select(1)
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-Down>", function()
				harpoon:list():select(2)
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-Left>", function()
				harpoon:list():select(3)
			end, { noremap = true, silent = true })
			vim.keymap.set("n", "<C-Right>", function()
				harpoon:list():select(4)
			end, { noremap = true, silent = true })
		end,
	},
	{
		{ "folke/playground" },
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/nvim-treesitter-textobjects",
		"nvim-treesitter/nvim-treesitter-refactor",
		"nvim-treesitter/nvim-treesitter-context",
		"windwp/nvim-ts-autotag",
		event = { "BufNewFile", "BufReadPre" },
		build = ":TSUpdate",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-treesitter/nvim-treesitter-refactor",
			"nvim-treesitter/nvim-treesitter-context",
			"windwp/nvim-ts-autotag",
		},
		config = function()
			--setting up treesitter
			playground = {
				enable = true,
				disable = {},
				updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
				persist_queries = false, -- Whether the query persists across vim sessions
				keybindings = {
					toggle_query_editor = "o",
					toggle_hl_groups = "i",
					toggle_injected_languages = "t",
					toggle_anonymous_nodes = "a",
					toggle_language_display = "I",
					focus_language = "f",
					unfocus_language = "F",
					update = "R",
					goto_node = "<cr>",
					show_help = "?",
				},
			}
			local configs = require("nvim-treesitter.configs")
			configs.setup({
				autotag = {
					enable = true,
				},
				ensure_installed = {
					"help",
					"c",
					"cpp",
					"haskell",
					"http",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"elixir",
					"heex",
					"javascript",
					"html",
					"bash",
					"asm",
					"cuda",
					"css",
					"dockerfile",
					"elixir",
					"gitignore",
					"git_config",
					"gitcommit",
					"gitattributes",
					"markdown",
					"go",
					"json",
					-- "latex",
					"htmldjango",
					"java",
					"json5",
					"julia",
					"markdown_inline",
					"kotlin",
					"latex",
					"luadoc",
					"make",
					"nix",
					"ocaml",
					"php",
					"python",
					"r",
					"ruby",
					"rust",
					"sql",
					"swift",
					"toml",
					"typescript",
					"xml",
					"yaml",
					"zig",
				},
				--sync_install = false,
				auto_install = true,
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = { "ruby" },
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
							goto_definition_lsp_fallback = "gd",
							list_definitions = "gnD",
							list_definitions_toc = "gO",
							goto_next_usage = "<a-*>",
							goto_previous_usage = "<a-#>",
						},
					},
					smart_rename = {
						enable = true,
						-- Assign keymaps to false to disable them, e.g. `smart_rename = false`.
						keymaps = {
							smart_rename = "grr",
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
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							-- You can optionally set descriptions to the mappings (used in the desc parameter of
							-- nvim_buf_set_keymap) which plugins like which-key display
							["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
							-- You can also use captures from other query groups like `locals.scm`
							["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
						},
						-- You can choose the select mode (default is charwise 'v')
						--
						-- Can also be a function which gets passed a table with the keys
						-- * query_string: eg '@function.inner'
						-- * method: eg 'v' or 'o'
						-- and should return the mode ('v', 'V', or '<c-v>') or a table
						-- mapping query_strings to modes.
						selection_modes = {
							["@parameter.outer"] = "v", -- charwise
							["@function.outer"] = "V", -- linewise
							["@class.outer"] = "<c-v>", -- blockwise
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
							["<leader>a"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
							--
							-- You can use regex matching (i.e. lua pattern) and/or pass a list in a "query" key to group multiple queries.
							["]o"] = "@loop.*",
							-- ["]o"] = { query = { "@loop.inner", "@loop.outer" } }
							--
							-- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
							-- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
							["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
							["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
						},
						-- Below will go to either the start or the end, whichever is closer.
						-- Use if you want more granular movements
						-- Make it even more gradual by adding multiple queries and regex.
						goto_next = {
							["]d"] = "@conditional.outer",
						},
						goto_previous = {
							["[d"] = "@conditional.outer",
						},
					},
					lsp_interop = {
						enable = true,
						border = "none",
						floating_preview_opts = {},
						peek_definition_code = {
							["<leader>df"] = "@function.outer",
							["<leader>dF"] = "@class.outer",
						},
					},
				},
			})
			require("nvim-ts-autotag").setup({
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
			require("treesitter-context").setup({
				enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
				max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
				min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
				line_numbers = true,
				multiline_threshold = 5, -- Maximum number of lines to show for a single context
				trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
				mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
				-- Separator between context and content. Should be a single character string, like '-'.
				-- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
				separator = nil,
				zindex = 20, -- The Z-index of the context window
				on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
			-- Prefer git instead of curl in order to improve connectivity in some environments
			-- require('nvim-treesitter.install').prefer_git = true
			vim.keymap.set("n", "<leader>[c", function()
				require("treesitter-context").go_to_context(vim.v.count1)
			end, { silent = true })
			-- local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			-- ts_update()
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
		opts = {
			color_icons = true,
			strict = true,
			override_by_filename = {
				[".gitignore"] = {
					icon = "",
					color = "#f1502f",
					name = "Gitignore",
				},
			},
			override = {
				zsh = {
					icon = "", --
					color = "#428850",
					cterm_color = "65",
					name = "Zsh",
				},
			},
			override_by_extension = {

				["log"] = {
					icon = "",
					color = "#81e043",
					name = "Log",
				},
			},
		},
		config = function(_, opts)
			--setting up web dev icons
			-- dofile(vim.g.base46_cache .. "devicons")
			require("nvim-web-devicons").setup(opts)
		end,
	},
	{
		"folke/ts-comments.nvim",
		opts = {},
		event = "VeryLazy",
		enabled = vim.fn.has("nvim-0.10.0") == 1,
	},
	{ "echasnovski/mini.icons", version = false },
	--   {'romgrk/barbar.nvim',
	--   dependencies = {
	--     'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
	--     -- 'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
	--     'echasnovski/mini.icons'
	--   },
	--   event = "VeryLazy",
	--   init = function() vim.g.barbar_auto_setup = false end,
	--   opts = {
	--     -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
	--     animation = true,
	--     -- insert_at_start = true,
	--     -- …etc.
	--   },
	--   version = '^1.0.0', -- optional: only update when a new 1.x version is released
	-- },
	--  { "nvim-tree/nvim-web-devicons",
	--   opts = {},
	--   config = function(_, opts)
	--     --setting up web dev icons
	--     dofile(vim.g.base46_cache .. "devicons")
	--     require("nvim-web-devicons").setup(opts)
	--   end,
	-- },
	{
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				mode = "buffers",
				-- style_preset = bufferline.style_preset.default,
				themable = true,
				numbers = "none",
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				indicator = {
					icon = "▎",
					style = "underline", -- Change this to 'icon', 'underline', or 'none'
				},
				-- buffer_close_icon = '',--
				-- modified_icon = '●',
				close_icon = "",
				-- left_trunc_marker = '',
				-- right_trunc_marker = '',
				-- max_name_length = 18,
				-- max_prefix_length = 15,
				-- tab_size = 18,
				diagnostics = "nvim_lsp",
				diagnostics_indicator = function(_, _, diag)
					local icons = {
						Error = " ",
						Warn = " ",

						Hint = " ",

						Info = " ",
					}
					local ret = (diag.error and icons.Error .. diag.error .. " " or "")
						.. (diag.warning and icons.Warn .. diag.warning or "")
					return vim.trim(ret)
				end,
				-- diagnostics_update_in_insert = true,
				offsets = { { filetype = "Oil", text = "File Explorer", text_align = "left" } },
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				persist_buffer_sort = true,
				separator_style = "padded_slant", -- Change this to "slant", "thick", "thin", "padded_slant", or a custom table
				enforce_regular_tabs = false,
				always_show_bufferline = true,

				sort_by = "id",
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
	},
	{
		"tiagovla/scope.nvim",
		opts = {},
		config = function()
			require("scope").setup({})
		end,
	},

	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { { "echasnovski/mini.icons", opts = {} } },
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if prefer nvim-web-devicons
		config = function()
			require("oil").setup({
				default_file_explorer = true,
				columns = {
					"icon",
					-- "permissions",
					"size",
					-- "mtime",
				},
				buf_options = {
					buflisted = false,
					bufhidden = "hide",
				},
				view_options = {
					show_hidden = true, -- Show hidden files by default
					tree_style = true,
				},
				win_options = {
					wrap = false,
					-- signcolumn = "no",
					cursorcolumn = false,
					foldcolumn = "0",
					spell = false,
					list = false,
					conceallevel = 3,
					concealcursor = "nvic",
					signcolumn = "yes:2",
				},
				delete_to_trash = false,
				skip_confirm_for_simple_edits = false,
				prompt_save_on_select_new_entry = true,
				cleanup_delay_ms = 2000,
				show_hidden = true, -- Show hidden files
				preview_split = "left",
				-- float = {
				--   padding = 2,
				--   max_width = 90,
				--   max_height = 0,
				--   border = "rounded",
				--   win_options = {
				--       winblend = 0,
				--   },
				-- float = {
				--   padding = 0,  -- Remove padding to make it more like a sidebar
				--   max_width = 30,  -- Adjust width to match typical sidebar width
				--   max_height = vim.o.lines,  -- Use full height of the editor
				--   border = "none",  -- Remove border for a cleaner look
				--   win_options = {
				--       winblend = 0,  -- No transparency
				--   },
				-- },
			})
			-- vim.cmd[['require("oil").toggle_hidden()']]
		end,
	},
	{
		"refractalize/oil-git-status.nvim",

		dependencies = {
			"stevearc/oil.nvim",
		},

		config = true,
	},
	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	branch = "v3.x",
	-- 	lazy = true,
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
	-- 		"MunifTanjim/nui.nvim",
	-- 		"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	-- 	},
	-- 	config = function()
	-- 		--setting up neotree
	-- 		require("neo-tree").setup({
	-- 			window = {
	-- 				position = "right",
	-- 				width = 40,
	-- 				mapping_options = {
	-- 					noremap = true,
	-- 					nowait = true,
	-- 				},
	-- 			},
	-- 			filesystem = {
	-- 				filtered_items = {
	-- 					visible = false,
	-- 					hide_dotfiles = false,
	-- 					hide_gitignored = false,
	-- 					hide_by_name = {
	-- 						-- Add any specific filenames you want to hide here
	-- 						-- e.g., ".git", ".DS_Store", "thumbs.db"
	-- 					},
	-- 				},
	-- 			},
	-- 			never_show = {},
	-- 		})
	-- 	end,
	-- },
	-- {
	--   'windwp/windline.nvim',
	--   dependencies = {'echasnovski/mini.icons',},
	--   config = function()
	--     require('wlsample.bubble2')
	--   end,
	-- },
	{
		"ziontee113/color-picker.nvim",
		config = function()
			require("color-picker").setup({-- for changing icons & mappings
     ["icons"] = { "ﱢ", "" },
	-- ["icons"] = { "ﮊ", "" },
	-- ["icons"] = { "", "ﰕ" },
	-- ["icons"] = { "", "" },
	-- ["icons"] = { "", "" },
	-- ["icons"] = { "ﱢ", "" },
	-- ["border"] = "rounded", -- none | single | double | rounded | solid | shadow)
})
		end,
	},
	{
		"dstein64/vim-startuptime",
		-- opts = {},
		-- config = function()
		--   require('startuptime').setup()
		-- end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		init = function()
			vim.g.lualine_laststatus = vim.o.laststatus
			if vim.fn.argc(-1) > 0 then
				-- set an empty statusline till lualine loads
				vim.o.statusline = " "
			else
				-- hide the statusline on the starter page
				vim.o.laststatus = 0
			end
		end,
		config = function()
			local icons = {
				misc = {
					dots = "󰇘",
				},
				ft = {
					octo = "",
				},
				dap = {
					Stopped = { "󰁕 ", "DiagnosticWarn", "DapStoppedLine" },
					Breakpoint = " ",
					BreakpointCondition = " ",
					BreakpointRejected = { " ", "DiagnosticError" },
					LogPoint = ".>",
				},
				diagnostics = {
					Error = " ",
					Warn = " ",

					Hint = " ",

					Info = " ",
				},
				git = {
					added = " ",
					modified = " ",
					removed = " ",
					changedelete = "󱕖 ", --~󱕖
				},
				kinds = {
					Array = " ",

					Boolean = "󰨙 ",
					Class = " ",
					Codeium = "󰘦 ",
					Color = " ",
					Control = " ",
					Collapsed = " ",
					Constant = "󰏿 ",
					Constructor = " ",
					Copilot = " ",
					Enum = " ",
					EnumMember = " ",
					Event = " ",
					Field = " ",
					File = " ",
					Folder = " ",
					Function = "󰊕 ",
					Interface = " ",
					Key = " ",
					Keyword = " ",

					Method = "󰊕 ",
					Module = " ",
					Namespace = "󰦮 ",
					Null = " ",
					Number = "󰎠 ",

					Object = " ",

					Operator = " ",
					Package = " ",
					Property = " ",
					Reference = " ",
					Snippet = " ",
					String = " ",
					Struct = "󰆼 ",

					TabNine = "󰏚 ",
					Text = " ",
					TypeParameter = " ",
					Unit = " ",

					Value = " ",

					Variable = "󰀫 ",
				},
			}
			-- local function get_fg_color(group)
			-- local hl = vim.api.nvim_get_hl_by_name(group, true)

			--   if hl then
			--     print(vim.inspect(hl))  -- Debugging: Print the highlight group details
			--     if hl.foreground then
			--       return string.format("#%06x", hl.foreground)
			--     end
			--   else
			--     print("Highlight group not found: " .. group)  -- Debugging: Print if the group is not found
			--   end
			--   return nil
			-- end
			-- local function get_fg_color(group)
			--   local hl = vim.api.nvim_get_hl_by_name(group, true)
			--
			--   if hl and hl.foreground then
			--     return string.format("#%06x", hl.foreground)
			--   end
			--   return nil
			-- end

			local function get_root_dir()
				local clients = vim.lsp.get_active_clients()
				if next(clients) == nil then
					return vim.fn.getcwd()
				end
				for _, client in pairs(clients) do
					if client.config.root_dir then
						return client.config.root_dir
					end
				end
				return vim.fn.getcwd()
			end
			-- local function get_fg_color(group)
			--   local hl = vim.api.nvim_get_hl_by_name(group, true)
			--
			--   if hl and hl.foreground then
			--     return string.format("#%06x", hl.foreground)
			--   end
			--   return nil
			-- end
			local function pretty_path()
				local filepath = vim.fn.expand("%:p")
				local cwd = vim.fn.getcwd()
				local root_dir = cwd

				-- If using LSP, get the root directory

				local clients = vim.lsp.get_active_clients()
				if next(clients) ~= nil then
					for _, client in pairs(clients) do
						if client.config.root_dir then
							root_dir = client.config.root_dir
							break
						end
					end
				end

				-- Make the path relative to the root directory
				local relative_path = vim.fn.fnamemodify(filepath, ":~:.")
				return relative_path
			end

			-- local function get_fg_color(group)
			--   local hl = vim.api.nvim_get_hl_by_name(group, true)
			--
			--         if hl then
			--           print(vim.inspect(hl))  -- Debugging: Print the highlight group details
			--           if hl.foreground then
			--             return string.format("#%06x", hl.foreground)
			--           end
			--         else
			--           print("Highlight group not found: " .. group)  -- Debugging: Print if the group is not found
			--         end
			--         return nil
			--       end

			vim.o.laststatus = vim.g.lualine_laststatus
			require("lualine").setup({
				--   options = {
				--   icons_enabled = true,
				--     theme = 'auto',
				--     globalstatus = vim.o.laststatus == 3,
				--     component_separators = { left = ' ', right = ' '},
				--     section_separators = { left = '', right = '' },
				--     disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
				--     -- disabled_filetypes = {},
				--   },
				--   sections = {
				--     lualine_a = { { 'mode', separator = { left = '' }, right_padding = 2 } },
				--     -- lualine_b = { 'filename', 'branch' },
				--     lualine_b = {
				--       { 'filename', color = { bg = '#303030' } },
				--       { 'branch', color = { bg = '#303030' } },
				--       -- { 'diagnostics', color = { bg = '#303030' } },
				--     },
				--     lualine_c = {
				--       '%=', --[[ add your center compoentnts here in place of this comment ]]
				--       { get_root_dir() },
				--       {
				--         "diagnostics",
				--         symbols = {
				--           error = icons.diagnostics.Error,
				--           warn = icons.diagnostics.Warn,
				--           info = icons.diagnostics.Info,
				--           hint = icons.diagnostics.Hint,
				--         },
				--       },
				--     },
				--    --  lualine_x = {
				--    --    {
				--    --      function() return "  " .. require("dap").status() end,
				--    --      cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
				--    --      color = function() return get_fg_color("Debug") end,
				--    --    },
				--    --    {
				--    --      require("lazy.status").updates,
				--    --      cond = require("lazy.status").has_updates,
				-- 			--
				--    --      color = function() return get_fg_color("Special") end,
				--    --    },
				--    --    {
				--    --      "diff",
				--    --      symbols = {
				--    --        added = icons.git.added,
				--    --        modified = icons.git.modified,
				--    --        removed = icons.git.removed,
				--    --      },
				--    --    },
				--    -- source = function()
				--    --      local gitsigns = vim.b.gitsigns_status_dict
				--    --      if gitsigns then
				-- 			--
				--    --        return {
				--    --        added = gitsigns.added,
				--    --        modified = gitsigns.changed,
				--    --        removed = gitsigns.removed,
				--    --        }
				--    --      end
				--    -- end,
				--    --  },
				--    lualine_x = {
				--     -- stylua: ignore
				--     -- {
				--     --
				--     --   function() return require("noice").api.status.command.get() end,
				--     --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
				--     --   color = function() return LazyVim.ui.fg("Statement") end,
				--     -- },
				--     -- stylua: ignore
				--     -- {
				--     --   function() return require("noice").api.status.mode.get() end,
				--     --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
				--     --   color = function() return LazyVim.ui.fg("Constant") end,
				--     -- },
				--     -- stylua: ignore
				--     {
				--       function() return "  " .. require("dap").status() end,
				--       cond = function() return package.loaded["dap"] and require("dap").status() ~= "" end,
				--       color = function() return get_fg_color("Debug") end,
				--     },
				--     -- stylua: ignore
				--     {
				--       require("lazy.status").updates,
				--       cond = require("lazy.status").has_updates,
				--       color = function() return get_fg_color("Special") end,
				--     },
				--     {
				--       "diff",
				--       symbols = {
				--         added = icons.git.added,
				--         modified = icons.git.modified,
				--         removed = icons.git.removed,
				--       },
				--       source = function()
				--         local gitsigns = vim.b.gitsigns_status_dict
				--         if gitsigns then
				--           return {
				--
				--             added = gitsigns.added,
				--             modified = gitsigns.changed,
				--             removed = gitsigns.removed,
				--           }
				--         end
				--       end,
				--       },
				--     },
				--     lualine_y = { {'filetype', color = { bg = '#303030' } },
				--     {'progress', color = { bg = '#303030' } },
				--     {'encoding', color = { bg = '#303030' } },
				--     {'fileformat', color = { bg = '#303030' } },
				--   },
				--  lualine_z = {
				--       { 'location', separator = { right = '' }, left_padding = 2 },
				--     },
				--   -- inactive_sections = {
				--   --   lualine_a = { 'filename' },
				--   --   lualine_b = {},
				--   --   lualine_c = {},
				--   --   lualine_x = {},
				--   --   lualine_y = {},"#303030"Green
				--   --   lualine_z = { 'location',},
				--   -- },
				--   -- tabline = {},
				--   extensions = { "lazy" },
				-- }}
				options = {
					theme = "auto",
					component_separators = { left = " ", right = " " },
					section_separators = { left = "", right = "" },
					globalstatus = vim.o.laststatus == 3,
					disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter" } },
				},
				sections = {
					lualine_a = { { "mode", icon = "", separator = { right = "" }, right_padding = 2 } }, --
					lualine_b = {
					-- section_separators = { left = "", right = "" },--
						{ "branch", color = { bg = "#303030" }, separator = { left = "",right = "", } },
						{
							"diff",
							symbols = {
								added = icons.git.added,
								modified = icons.git.modified,
								removed = icons.git.removed,
								changedelete = icons.git.changedelete,
							},
							separator = { right = "" },
							color = { bg = "#303030" },
							source = function()
								local gitsigns = vim.b.gitsigns_status_dict
								if gitsigns then
									return {

										added = gitsigns.added,
										modified = gitsigns.changed,
										removed = gitsigns.removed,
										changedelete = gitsigns.changeddelete, --
										--changedelete = { text = '󱕖' },--~󱕖
									}
								end
							end,
						},
						-- {
						--   "diagnostics",
						--   symbols = {
						--     error = icons.diagnostics.Error,
						--     warn = icons.diagnostics.Warn,
						--     info = icons.diagnostics.Info,
						--     hint = icons.diagnostics.Hint,
						--   },
						--  color = { bg = '#303030' },
						--  padding = { left = 0, right = 0 },
						-- },
					},

					lualine_c = {
						-- '%=', --[[ add your center compoentnts here in place of this comment ]]
						{ "filetype", icon_only = true, separator = "", padding = { left = 2, right = -2 } }, --, icon_only = true
						{ pretty_path },
						{
							"diagnostics",
							icon = " :",
							symbols = {
								error = icons.diagnostics.Error,
								warn = icons.diagnostics.Warn,
								info = icons.diagnostics.Info,
								hint = icons.diagnostics.Hint,
							},
							padding = { left = 0, right = 0 },
						},

						-- { get_root_dir },
					},

					lualine_x = {
            -- stylua: ignore
            -- {
            --   function() return require("noice").api.status.command.get() end,
            --   cond = function() return package.loaded["noice"] and require("noice").api.status.command.has() end,
            --   color = function() return LazyVim.ui.fg("Statement") end,
            --
            -- },
            -- stylua: ignore
            -- {
            --   function() return require("noice").api.status.mode.get() end,
            --   cond = function() return package.loaded["noice"] and require("noice").api.status.mode.has() end,
            --   color = function() return LazyVim.ui.fg("Constant") end,
            -- },
            -- stylua: ignore
            {
              function() return "  " .. require("dap").status() end,
              cond = function()
                return package.loaded["dap"] and
                    require("dap").status() ~= ""
              end,

              -- color = function() return get_fg_color("Debug") end,
            },
            -- stylua: ignore
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff7d50" },
              -- separator = { left = '' },
              -- component_separators = { left = '', right = ''},
              --     section_separators = { left = '', right = ''},
            },
						--     {
						--       "diff",
						--       symbols = {
						--         added = icons.git.added,
						--         modified = icons.git.modified,
						--         removed = icons.git.removed,
						--         changedelete = icons.git.changedelete,
						--       },
						--       source = function()
						--         local gitsigns = vim.b.gitsigns_status_dict
						--         if gitsigns then
						--           return {
						--
						--             added = gitsigns.added,
						--             modified = gitsigns.changed,
						--             removed = gitsigns.removed,
						--             changedelete = gitsigns.changeddelete,--
						-- --changedelete = { text = '󱕖' },--~󱕖
						--           }
						--         end
						--
						--       end,
						--     },
					},
					lualine_y = {
						{ "encoding", color = { bg = "#303030" }, padding = { left = 1, right = 1 } },
						{ "fileformat", color = { bg = "#303030" }, padding = { left = 1, right = 1 } },
						{
							"filetype",
							color = { bg = "#303030" },
							separator = "",
							padding = { left = 1, right = 1 },
						}, --, icon_only = true
						{
							"progress",
							color = { bg = "#303030" },
							separator = " ",
							padding = { left = 1, right = 1 },
						},
						-- "progress",
					},
					lualine_z = {
						{ "location", padding = { left = 1, right = 1 } },
						-- function()
						--   return " " .. os.date("%R")
						--
						-- end,
					},
				},
				extensions = { "lazy" },
			})
		end,
	},

	{
		-- {"folke/which-key.nvim",
		--  event = "VimEnter",
		-- -- config = function()
		-- --     require("which-key").setup()
		-- --
		-- --     require("which-key").register({
		-- --         ["<Leader><Leader>"] = { name = }
		-- --   end,
		-- --  })
		-- },
		{
			"lukas-reineke/indent-blankline.nvim",
			event = { "BufNewFile", "BufReadPre" },
			main = "ibl",
			opts = {},
			config = function()
				local highlight = {
					"RainbowRed",
					"RainbowYellow",
					"RainbowBlue",
					"RainbowOrange",
					"RainbowGreen",
					"RainbowViolet",
					"RainbowCyan",
				}

				local hooks = require("ibl.hooks")
				-- create the highlight groups in the highlight setup hook, so they are reset
				-- every time the colorscheme changes
				hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
					vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
					vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
					vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
					vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
					vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
					vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
					vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
				end)

				require("ibl").setup({ indent = { highlight = highlight } }) --{ indent = { highlight = highlight } }
			end,
		},
		{ "folke/neoconf.nvim", cmd = "Neoconf" },
		"folke/lazydev.nvim",
	},
	{
		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup({
					ui = {
						icons = {
							package_pending = " ",
							package_installed = " ",
							package_uninstalled = " ",
						},
					},
				})
			end,
		},
		{
			"williamboman/mason-lspconfig.nvim",
			lazy = false,
			opts = {
				auto_install = true,
			},
			config = function()
				require("mason-lspconfig").setup({ --"standardrb","java_language_server","ruby_lsp","nil_ls"
					ensure_installed = {
						-- "solargraph",
						"typos_lsp",
						"lua_ls",
						"rust_analyzer",
						"arduino_language_server",
						-- "angularls",
						-- "asm_lsp",
						"astro",
						"bashls",
						"clangd",
						-- "csharp_ls",
						"neocmake",
						"cssls",
						"cssmodules_ls",
						"css_variables",
						"unocss",
						"omnisharp",
						"dockerls",
						"docker_compose_language_service",
						"elixirls",
						"lexical",
						"golangci_lint_ls",
						"gopls",
						"graphql",
						"html",
						"htmx",
						-- "hls",
						"jsonls",
						"biome",
						"jdtls",
						"quick_lint_js",
						"tsserver",
						-- "vtsls",
						"julials",
						"kotlin_language_server",
						"ltex",
						"texlab",
						"autotools_ls",
						"markdown_oxide",
						-- "matlab_ls",
						-- "ocamllsp",
						-- "nimls",
						-- "nim_langserver",
						"rnix",
						"perlnavigator",
						-- "psalm",
						-- "phpactor",
						-- "intelephense",
						-- "powershell_es",
						"marksman",
						"prosemd_lsp",
						"remark_ls",
						"vale_ls",
						-- "zk",
						"basedpyright",
						"jedi_language_server",
						"pyre",
						"pyright",
						"pylyzer",
						"sourcery",
						"pylsp",
						-- "ruff",
						-- "ruff_lsp",
						-- "r_language_server",
						"sqlls",
						"sqls",
						-- "rubocop",
						"sorbet",
						"taplo",
						"tailwindcss",
						"lemminx",
						"hydra_lsp",
						-- "yamlls",
						"zls",
						"diagnosticls",
						"nil_ls",
					},
				})
			end,
		},
		{
			"neovim/nvim-lspconfig",
			config = function()
				-- setup() is also available as an alias
				require("lspkind").init({
					-- DEPRECATED (use mode instead): enables text annotations
					--
					-- default: true
					-- with_text = true,

					-- defines how annotations are shown
					-- default: symbol
					-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
					mode = "symbol_text",

					-- default symbol map
					-- can be either 'default' (requires nerd-fonts font) or
					-- 'codicons' for codicon preset (requires vscode-codicons font)
					--
					-- default: 'default'
					preset = "codicons",

					-- override preset symbols

					--
					-- default: {}
					symbol_map = {

						Text = "󰉿",

						Method = "󰆧",
						Function = "󰊕",
						Constructor = "",
						Field = "󰜢",
						Variable = "󰀫",
						Class = "󰠱",
						Interface = "",
						Module = "",

						Property = "󰜢",
						Unit = "󰑭",
						Value = "󰎠",
						Enum = "",
						Keyword = "󰌋",

						Snippet = "",
						Color = "󰏘",
						File = "󰈙",
						Reference = "󰈇",

						Folder = "󰉋",
						EnumMember = "",

						Constant = "󰏿",
						Struct = "󰙅",
						Event = "",
						Operator = "󰆕",
						TypeParameter = "",
					},
				})
				local capabilities = require("cmp_nvim_lsp").default_capabilities()
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup({
					capabilities = capabilities,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
				lspconfig.typos_lsp.setup({
					capabilities = capabilities,
				})
				-- lspconfig.snyk_ls.setup({})
				lspconfig.diagnosticls.setup({
					capabilities = capabilities,
				})
				lspconfig.rust_analyzer.setup({
					settings = {
						["rust-analyzer"] = {},
					},
					capabilities = capabilities,
				})
				lspconfig.html.setup({
					capabilities = capabilities,
				})
				lspconfig.bashls.setup({
					capabilities = capabilities,
				})
				lspconfig.arduino_language_server.setup({
					capabilities = capabilities,
				})
				lspconfig.angularls.setup({
					capabilities = capabilities,
				})
				lspconfig.asm_lsp.setup({
					capabilities = capabilities,
				})
				lspconfig.astro.setup({
					capabilities = capabilities,
				})
				lspconfig.clangd.setup({
					capabilities = capabilities,
				})
				lspconfig.csharp_ls.setup({
					capabilities = capabilities,
				})
				lspconfig.neocmake.setup({
					capabilities = capabilities,
				})
				lspconfig.cssls.setup({
					capabilities = capabilities,
				})
				lspconfig.cssmodules_ls.setup({
					capabilities = capabilities,
				})
				lspconfig.css_variables.setup({
					capabilities = capabilities,
				})
				lspconfig.unocss.setup({
					capabilities = capabilities,
				})
				lspconfig.omnisharp.setup({
					capabilities = capabilities,
				})
				lspconfig.dockerls.setup({
					capabilities = capabilities,
				})
				lspconfig.docker_compose_language_service.setup({
					capabilities = capabilities,
				})
				lspconfig.elixirls.setup({
					capabilities = capabilities,
				})
				lspconfig.lexical.setup({
					capabilities = capabilities,
				})
				lspconfig.golangci_lint_ls.setup({
					capabilities = capabilities,
				})
				lspconfig.gopls.setup({
					capabilities = capabilities,
				})
				lspconfig.graphql.setup({
					capabilities = capabilities,
				})
				lspconfig.htmx.setup({
					capabilities = capabilities,
				})
				lspconfig.hls.setup({
					capabilities = capabilities,
				})
				lspconfig.jsonls.setup({
					capabilities = capabilities,
				})
				lspconfig.biome.setup({
					capabilities = capabilities,
				})
				lspconfig.jdtls.setup({
					capabilities = capabilities,
				})
				-- lspconfig.quick_lint_js.setup({
				--       capabilities = capabilities,
				--     })
				lspconfig.tsserver.setup({
					capabilities = capabilities,
				})
				-- lspconfig.vtsls.setup({})
				lspconfig.julials.setup({
					capabilities = capabilities,
				})
				lspconfig.kotlin_language_server.setup({
					capabilities = capabilities,
				})
				lspconfig.ltex.setup({
					capabilities = capabilities,
				})
				lspconfig.texlab.setup({
					capabilities = capabilities,
				})
				lspconfig.autotools_ls.setup({
					capabilities = capabilities,
				})
				lspconfig.markdown_oxide.setup({
					capabilities = capabilities,
				})
				lspconfig.matlab_ls.setup({
					capabilities = capabilities,
				})
				lspconfig.ocamllsp.setup({
					capabilities = capabilities,
				})
				lspconfig.nimls.setup({
					capabilities = capabilities,
				})
				lspconfig.nim_langserver.setup({
					capabilities = capabilities,
				})
				lspconfig.rnix.setup({
					capabilities = capabilities,
				})
				-- lspconfig.nil_ls.setup({
				--       capabilities = capabilities,
				--     })
				-- lspconfig.nixpkgs-fmt.setup({
				--       capabilities = capabilities,
				--     })
				lspconfig.perlnavigator.setup({
					capabilities = capabilities,
				})
				lspconfig.psalm.setup({
					capabilities = capabilities,
				})
				lspconfig.phpactor.setup({
					capabilities = capabilities,
				})
				-- lspconfig.intelephense.setup({})
				lspconfig.powershell_es.setup({
					capabilities = capabilities,
				})
				lspconfig.marksman.setup({
					capabilities = capabilities,
				})
				lspconfig.prosemd_lsp.setup({
					capabilities = capabilities,
				})
				lspconfig.remark_ls.setup({
					capabilities = capabilities,
				})
				lspconfig.vale_ls.setup({
					capabilities = capabilities,
				})
				-- lspconfig.zk.setup({})
				lspconfig.basedpyright.setup({
					capabilities = capabilities,
				})
				lspconfig.jedi_language_server.setup({
					capabilities = capabilities,
				})
				lspconfig.pyre.setup({
					capabilities = capabilities,
				})
				lspconfig.pyright.setup({
					capabilities = capabilities,
				})
				lspconfig.pylyzer.setup({
					capabilities = capabilities,
				})
				lspconfig.sourcery.setup({
					capabilities = capabilities,
				})
				lspconfig.pylsp.setup({
					capabilities = capabilities,
				})
				-- lspconfig.ruff.setup({
				--       capabilities = capabilities,
				--     })
				-- lspconfig.ruff_lsp.setup({
				--       capabilities = capabilities,
				--     })
				lspconfig.r_language_server.setup({
					capabilities = capabilities,
				})
				lspconfig.sqlls.setup({
					capabilities = capabilities,
				})
				lspconfig.sqls.setup({
					capabilities = capabilities,
				})
				lspconfig.rubocop.setup({
					capabilities = capabilities,
				})
				lspconfig.sorbet.setup({
					capabilities = capabilities,
				})
				lspconfig.taplo.setup({
					capabilities = capabilities,
				})
				lspconfig.tailwindcss.setup({
					capabilities = capabilities,
				})
				lspconfig.lemminx.setup({
					capabilities = capabilities,
				})
				-- lspconfig.gitlab_ci_ls.setup({})
				lspconfig.hydra_lsp.setup({
					capabilities = capabilities,
				})
				lspconfig.yamlls.setup({
					capabilities = capabilities,
				})
				lspconfig.nil_ls.setup({
					capabilities = capabilities,
				})
				lspconfig.zls.setup({
					capabilities = capabilities,
				})
				lspconfig.diagnosticls.setup({
					capabilities = capabilities,
				})
				-- vim.lsp.diagnostic.config({
				--     virtual_text = {
				--         prefix = '●', -- Change this to any symbol you prefer
				--         spacing = 4, -- Adjust the spacing between the text and the symbol
				--         -- severity_limit = 'Warning', -- Only show warnings and errors
				--     },
				--     signs = true,
				--     underline = true,
				--     update_in_insert = false,
				-- })
				-- Define custom signs
				vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticSignError" })
				vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticSignWarn" })
				vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticSignInfo" })
				vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })
				vim.lsp.handlers["textDocument/publishDiagnostics"] = function(uri, result, ctx, config)
					if not result or not result.uri then
						return
					end
					local uri = result.uri
					local bufnr = vim.uri_to_bufnr(uri)
					local filetype = vim.api.nvim_buf_get_option(bufnr, "filetype")

					if filetype == "markdown" then
						-- Custom settings for markdown files
						vim.lsp.diagnostic.on_publish_diagnostics(uri, result, ctx, {

							underline = true,
							virtual_text = true,
							signs = true,
							update_in_insert = true,
						})
					else
						-- Default settings for other file types
						vim.lsp.diagnostic.on_publish_diagnostics(uri, result, ctx, {
							underline = true,
							virtual_text = {

								spacing = 4,
								prefix = function(diagnostic)
									if diagnostic.severity == vim.diagnostic.severity.ERROR then
										return "" -- Error icon
									elseif diagnostic.severity == vim.diagnostic.severity.WARN then
										return "" -- Warning icon
									elseif diagnostic.severity == vim.diagnostic.severity.INFO then
										return "" -- Info icon
									elseif diagnostic.severity == vim.diagnostic.severity.HINT then
										return "" --💡 Hint icon
									end
								end, --●
							},
							signs = true,
							update_in_insert = false,
						})
					end
				end
				vim.diagnostic.config({
					virtual_text = true,
					signs = {
						priority = 8,
					},
					underline = true,
					update_in_insert = true,
				})

				function show_line_diagnostics()
					local opts = {
						focusable = false,
						close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
						border = "rounded",

						source = "always",
						prefix = " ",
						scope = "line",
					}

					vim.diagnostic.open_float(nil, opts)
				end

				--setting up lsp config keymaps
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "H", vim.lsp.buf.hover, opts) -- IMPORTANT: this is the keymap for hovering over a symbol.
				vim.keymap.set("n", "K", "<cmd>lua show_line_diagnostics()<CR>", opts) -- IMPORTANT: this is the keymap for hovering over a symbol.
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				-- vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
				vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
				vim.keymap.set("n", "<space>wl", function()
					print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
				end, opts)
				vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)
				vim.keymap.set({ "n", "v" }, " ca", vim.lsp.buf.code_action, opts)
			end,
		},
	},
	{
		"onsails/lspkind-nvim",
		config = function()
			require("lspkind").init({
				-- DEPRECATED (use mode instead): enables text annotations
				--

				-- default: true

				-- with_text = true,

				-- defines how annotations are shown
				-- default: symbol
				-- options: 'text', 'text_symbol', 'symbol_text', 'symbol'

				mode = "symbol_text",

				-- default symbol map
				-- can be either 'default' (requires nerd-fonts font) or
				-- 'codicons' for codicon preset (requires vscode-codicons font)
				--
				-- default: 'default'
				preset = "codicons",

				-- override preset symbols
				--
				-- default: {}
				symbol_map = {
					Text = "󰉿",
					Method = "󰆧",
					Function = "󰊕",
					Constructor = "",

					Field = "󰜢",

					Variable = "󰀫",
					Class = "󰠱",
					Interface = "",
					Module = "",
					Property = "󰜢",

					Unit = "󰑭",

					Value = "󰎠",

					Enum = "",

					Keyword = "󰌋",
					Snippet = "",
					Color = "󰏘",
					File = "󰈙",
					Reference = "󰈇",
					Folder = "󰉋",
					EnumMember = "",
					Constant = "󰏿",

					Struct = "󰙅",
					Event = "",
					Operator = "󰆕",
					TypeParameter = "",
				},
			})
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		lazy = true,
		config = function()
			--setting up transparent.nvim
			require("transparent").setup({
				-- enable = true,
				extra_groups = { -- table/string: additional groups that should be cleared
					"BufferLineTabClose",
					"BufferlineBufferSelected",
					"BufferLineFill",
					"BufferLineBackground",
					"BufferLineSeparator",
					"BufferLineIndicatorSelected",

					-- "IndentBlanklineChar",

					-- make floating windows transparent
					"LspFloatWinNormal",
					"Normal",
					"NormalFloat",
					"FloatBorder",
					"TelescopeNormal",
					"TelescopeBorder",
					"TelescopePromptBorder",
					"SagaBorder",
					"CursorLine",
					"SagaNormal",
				},
				exclude_groups = {
					"Comment",
					"String",
					"Constant",
					"Special",
					-- "CursorLine",
					"ColorColumn",
					"colorizer.highlight_buffer",
					"Colorize",
				}, -- table: groups you don't want to clear
			})
			-- require("transparent").clear_prefix("NeoTree")
			require("transparent").clear_prefix("Lualine")
			require("transparent").clear_prefix("BufferLine")
			-- require('transparent').clear_prefix("mason")
			--vim.keymap.set("n", "<Space>te", ":TransparentEnable<CR>", {})
			vim.keymap.set("n", "<Space>td", ":TransparentDisable<CR>", {})
		end,
	},
	-- {
	-- 	"norcalli/nvim-colorizer.lua",
	-- 	opts = {},
	-- 	config = function()
	-- 		require("colorizer").setup({
	--            '*';
	--            css = { rgb_fn = true; };
	--        }, {
	--            mode = 'foreground';
	--           -- mode = 'virtual_text';
	--        })
	-- 	end,
	-- },
	-- TODO: fix this
	{
		"NvChad/nvim-colorizer.lua",
		opts = {},
		config = function()
			require("colorizer").setup({})
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		build = "make",
		opts = {
			-- add any opts here
		},
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			{
				"grapp-dev/nui-components.nvim",
				dependencies = {
					"MunifTanjim/nui.nvim",
				},
			},
			--- The below is optional, make sure to setup it properly if you have lazy=true
			{
				"MeanderingProgrammer/render-markdown.nvim",
				dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" },
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante", "latex" },
				latex = {
					enabled = true, -- Set to false if you want to disable LaTeX support
					config = function(_, opts)
						require("render-markdown").setup(opts)
					end,
				},
			},
		},
	},
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
		config = function()
			--setting up fidget
			require("fidget").setup({})
		end,
	},
	{
		"vhyrro/luarocks.nvim",
		priority = 1000, -- Very high priority is required, luarocks.nvim should run as the first plugin in your config.
		config = true,
	},
	{
		"RRethy/vim-illuminate",
		config = function()
			require("illuminate").configure({
				providers = {
					"lsp",
					"treesitter",
					"regex",
				},
			})
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		config = function()
			--setting up none-ls
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.formatting.robocop,
					null_ls.builtins.formatting.prettier,
					null_ls.builtins.formatting.black,
					-- null_ls.builtins.diagnostics.rubocop,
					-- null_ls.builtins.diagnostics.quick-lint-js,
					-- null_ls.builtins.diagnostics.isort,
					-- none_ls.builtins.formatting.prettierd,
					-- none_ls.builtins.formatting.shfmt,
					-- none_ls.builtins.formatting.markdownlint,
					-- none_ls.builtins.formatting.mix,
					-- none_ls.builtins.formatting.sqlformat,
					-- none_ls.builtins.formatting.bacon,
					-- -- none_ls.builtins.formatting.quick-lint-js,
					-- -- none_ls.builtins.formatting.terraform_tflint,
					-- none_ls.builtins.formatting.rubocop,
					-- -- none_ls.builtins.formatting.standardrb,--not working
					-- -- none_ls.builtins.formatting.stylelint,
					-- none_ls.builtins.formatting.eslint_d,
					-- none_ls.builtins.diagnostics.rubocop,
					-- -- none_ls.builtins.diagnostics.stylelint,
					-- -- none_ls.builtins.diagnostics.eslint,
					-- require("none-ls.diagnostics.eslint_d"),
				},
			})
			vim.keymap.set("n", "<leader>lgf", vim.lsp.buf.format, {})
		end,
	},
	--[[
    ◍ golangci-lint
    ◍ htmlhint
    ◍ trivy
    ◍ snyk
    ◍ ast-grep ast_grep
    ◍ stylelint
    ◍ shellcheck
    ◍ sonarlint-language-server
    ◍ vale
    ◍ ktlint
    ◍ eslint_d
    ◍ bacon
    ◍ swiftlint
    ◍ luacheck
    ◍ checkstyle
    ◍ actionlint
    ◍ cpplint
    ◍ biome
    ◍ pyre
    ◍ quick-lint-js quick_lint_js
    ◍ rubocop
    ]]
	--
	{
		"rcarriga/nvim-notify",
		opts = {},
		config = function()
			local function get_background_color()
				local bg_color = vim.api.nvim_get_hl_by_name("Normal", true).background
				if bg_color then
					return string.format("#%06x", bg_color)
				else
					return "#000000" -- Default to black if no background color is found
				end
			end
			require("notify").setup({
				stages = "fade_in_slide_out",
				timeout = 6000,
				background_colour = get_background_color(),
			})
			vim.notify = require("notify")
		end,
	},
	{
		"goolord/alpha-nvim",
		event = "VimEnter",
		enabled = true,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			"echasnovski/mini.icons",
		},
		config = function()
			local alpha = require("alpha")
			local dashboard = require("alpha.themes.dashboard")
			math.randomseed(os.time())
			-- Set header
			local function pick_color()
				local colors = { "String", "Identifier", "Keyword", "Number" }
				return colors[math.random(#colors)]
			end
			local function footer()
				-- local total_plugins = #vim.tbl_keys(packer_plugins)
				local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
				local version = vim.version()
				local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
				local stats = require("lazy").stats()
				local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)

				return datetime
					.. nvim_version_info
					.. "\n⚡ Neovim loaded "
					.. stats.loaded
					.. "/"
					.. stats.count
					.. " plugins in "
					.. ms
					.. "ms"
			end
			dashboard.section.header.val = {
				[[                                                                      =====================================================================]],
				[[      ████ ██████           █████      ██                       =====================================================================]],
				[[     ███████████             █████                               ==================== READ THIS BEFORE CONTINUING ====================]],
				[[     █████████ ███████████████████ ███   ███████████     =====================================================================]],
				[[    █████████  ███    █████████████ █████ ██████████████     ========                                    .-----.          ========]],
				[[   █████████ ██████████ █████████ █████ █████ ████ █████     ========         .----------------------.   | === |          ========]],
				[[ ███████████ ███    ███ █████████ █████ █████ ████ █████    ========         |.-''''''''''''''''''-.|   |-----|          ========]],
				[[██████  █████████████████████ ████ █████ █████ ████ ██████   ========         ||                    ||   | === |          ========]],
				[[             ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆                                     ========         ||                    ||   | === |          ========]],
				[[              ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦                                  ========         ||     MINE.NVIM      ||   |-----|          ========]],
				[[                  ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷     ⠻⠿⢿⣿⣧⣄                                 ========         ||                    ||   | === |          ========]],
				[[                   ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀ ⠈⠙⠿⠄                                ========         ||                    ||   |-----|          ========]],
				[[                   ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀                               ========         ||:Tutor              ||   |:::::|          ========]],
				[[            ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄                              ========         |'-..................-'|   |____o|          ========]],
				[[           ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄                               ========         `"")----------------(""`   ___________      ========]],
				[[          ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄                              ========        /::::::::::|  |::::::::::\  \ no mouse \     ========]],
				[[          ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿⣿⣿⡇  ⠛⠻⢷⣄                             ========       /:::========|  |==hjkl==:::\  \ required \    ========]],
				[[               ⢻⣿⣿⣄  ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟⠫⢿⣿⡆                                   ========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========]],
				[[               ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⣤⣾⡿⠃                                    ========                                                     ========]],
				[[           __  __                                                       =====================================================================]],
				[[          |  \/  |_   _  __      ____ _ _   _                           =====================================================================]],
				[[          | |\/| | | | | \ \ /\ / / _` | | | |                          +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++]],
				[[          | |  | | |_| |  \ V  V / (_| | |_| |                          +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++]],
				[[          |_|  |_|\__, |   \_/\_/ \__,_|\__, |                          +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++]],
				[[                  |___/                 |___/                           +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++]],
				[[                                                                        +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++]],
			} --⢀⣀
			dashboard.section.header.opts.hl = pick_color()
			dashboard.section.footer.val = footer()
			dashboard.section.footer.opts.hl = "Constant"
			-- Set menu
			dashboard.section.buttons.val = {
				dashboard.button("f", "🔍📄  > Find file", ":Telescope find_files<CR>"), --cd $HOME/Workspace |
				dashboard.button("r", "🕒📋  > Recent", ":Telescope oldfiles<CR>"),
				dashboard.button(
					"s",
					"⚙️ 🚪  > Settings",
					":e $MYVIMRC | let &splitright = 1 | vsplit . | wincmd l | vertical resize 30 | wincmd h | pwd<CR>"
				), -- :cd %:p:h |
				dashboard.button("e", "➕📄  > New file", ":ene <BAR> startinsert <CR>"),
				dashboard.button("q", "🔌   > Quit NVIM", ":qa<CR>"), --🔌󰚰⏻
			}
			-- Send config to alpha
			alpha.setup(dashboard.opts)
			-- require'alpha'.setup(require'alpha.themes.dashboard'.config)
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"rcarriga/nvim-dap-ui",
			"leoluz/nvim-dap-go",
		},
		config = function()
			local dap, dapui = require("dap"), require("dapui")
			require("dapui").setup()
			require("dap-go").setup()
			dap.listeners.before.attach.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.launch.dapui_config = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated.dapui_config = function()
				dapui.close()
			end
			dap.listeners.before.event_exited.dapui_config = function()
				dapui.close()
			end
			vim.keymap.set("n", "<leader>dt", require("dap").toggle_breakpoint, {})
			vim.keymap.set("n", "<leader>dc", require("dap").continue, {})
		end,
	},
	{
		{
			"hrsh7th/cmp-nvim-lsp",
		},
		{
			"L3MON4D3/LuaSnip",
			dependencies = {
				"saadparwaiz1/cmp_luasnip",
				"rafamadriz/friendly-snippets",
				"petertriho/cmp-git",
			},
		},
		{
			"hrsh7th/nvim-cmp",
			config = function()
				local lspkind = require("lspkind")
				local cmp = require("cmp")
				require("luasnip.loaders.from_vscode").lazy_load()
				cmp.setup({
					formatting = {
						format = lspkind.cmp_format({
							mode = "symbol_text", -- show both symbol and text
							maxwidth = 50, -- prevent the popup from showing more than provided characters
							ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
						}),
					},
					snippet = {
						-- REQUIRED - you must specify a snippet engine
						expand = function(args)
							--   vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
							require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
							-- require('snippy').expand_snippet(args.body) -- For `snippy` users.
							-- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
							-- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
						end,
					},
					window = {
						completion = cmp.config.window.bordered(),
						documentation = cmp.config.window.bordered(),
					},
					mapping = cmp.mapping.preset.insert({
						["<C-b>"] = cmp.mapping.scroll_docs(-4),
						["<C-f>"] = cmp.mapping.scroll_docs(4),
						["<C-Space>"] = cmp.mapping.complete(),
						["<C-e>"] = cmp.mapping.abort(),
						["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "luasnip" }, -- For luasnip users.
						--{ name = 'vsnip' }, -- For vsnip users.
						-- { name = 'ultisnips' }, -- For ultisnips users.
						-- { name = 'snippy' }, -- For snippy users.
					}, {
						{ name = "buffer" },
						-- { name = "supermaven" },
					}),
				})
			end,
		},
	},
}
local opts = {
	checker = { enabled = true, notify = false },
	ui = {
		icons = {
			ft = "",
			lazy = "󰂠 ",
			loaded = "",
			not_loaded = "",
		},
	},
	performance = {
		rtp = {
			reset = true, -- Reset runtime path to improve startup time
		},
		cache = {
			enabled = true, -- Enable caching for faster startup
		},
	},
}
require("lazy").setup(plugins, opts)
function rand_colorscheme()
	local less_preferred_colorschemes = {
		"blue",
		"zaibatsu",
		"darkblue",
		"default",
		"delek",
		"base46-ayu_light",
		"desert",
		"elflord",
		"evening",
		"base46-oceanic-light",
		"habamax",
		"industry",
		"koehler",
		"lunaperche",
		"base46-flexoki-light",
		"morning",
		"murphy",
		"pablo",
		"peachpuff",
		"base46-flex-light",
		"base46-one_light",
		"quiet",
		"retrobox",
		"base46-rosepine-dawn",
		"ron",
		"base46-blossom_light",
		"shine",
		"slate",
		"sorbet",
		"catppuccin-latte",
		"base46-github_light",
		"torte",
		"base46-everforest_light",
		"base46-material-lighter",
		"base46-gruvbox_light",
		"base46-nano-light",
		"base46-onenord_light",
		"base46-penumbra_light",
		"vim",
		"wildcharm",
		"tokyonight-day",
	}
	local colorschemes = less_preferred_colorschemes[math.random(#less_preferred_colorschemes)]
	local more_preferred_colorschemes = {
		"tokyonight",
		"tokyodark",
		"tokyonight-moon",
		"tokyonight-night",
		"tokyonight-storm",
		"tokyodark",
		"catppuccin",
		"tokyodark",
		colorschemes,
		"catppuccin-frappe",
		"catppuccin-macchiato",
		"tokyodark",
		"catppuccin-mocha",
		"base46-aquarium",
		"base46-ashes",
		"base46-ayu_dark",
		"tokyodark",
		"base46-bearded-arc",
		"base46-catppuccin",
		"base46-chadracula",
		"base46-chadracula-evondev",
		"base46-chadtain",
		"tokyodark",
		"base46-chocolate",
		"tokyodark",
		"base46-dark_horizon",
		"base46-decay",
		"tokyodark",
		"base46-doomchad",
		"base46-everblush",
		"tokyodark",
		"base46-everforest",
		"tokyodark",
		"base46-falcon",
		"base46-flexoki",
		"base46-gatekeeper",
		"base46-github_dark",
		"tokyodark",
		"base46-gruvbox",
		"tokyodark",
		"base46-gruvchad",
		"base46-jabuti",
		"tokyodark",
		"base46-jellybeans",
		"base46-kanagawa",
		"tokyodark",
		"base46-material-darker",
		"base46-melange",
		"base46-mito-laser",
		"tokyodark",
		"tokyodark",
		"base46-monekai",
		"tokyodark",
		"base46-monochrome",
		"base46-mountain",
		"tokyodark",
		"base46-nightfox",
		"tokyodark",
		"base46-nightlamp",
		"tokyodark",
		"base46-nightowl",
		"base46-nord",
		"base46-oceanic-next",
		"base46-onedark",
		"base46-onenord",
		"tokyodark",
		"tokyodark",
		"base46-oxocarbon",
		"tokyodark",
		"base46-palenight",
		"base46-pastelDark",
		"tokyodark",
		"base46-pastelbeans",
		"tokyodark",
		"base46-penumbra_dark",
		-- "base46-poimandres",
		"base46-radium",
		"tokyodark",
		"base46-rosepine",
		"tokyodark",
		"base46-rxyhn",
		"tokyodark",
		"tokyodark",
		"tokyodark",
		"base46-solarized_dark",
		"tokyodark",
		"base46-solarized_osaka",
		"base46-sweetpastel",
		"tokyodark",
		"base46-tokyodark",
		"tokyodark",
		"base46-tokyonight",
		"tokyodark",
		"base46-tomorrow_night",
		"base46-tundra",
		"tokyodark",
		"base46-vscode_dark",
		"base46-wombat",
		"tokyodark",
		"base46-yoru",
	}
	return more_preferred_colorschemes[math.random(#more_preferred_colorschemes)]
end

vim.cmd("colorscheme " .. rand_colorscheme())
-- vim.cmd("colorscheme tokyonight-storm")
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
function TE()
	vim.cmd("Lazy load transparent.nvim")
	vim.cmd("set nocursorcolumn")
	vim.cmd("TransparentEnable")
end

vim.keymap.set("n", "<leader>te", ":lua TE()<CR>")
-- function FI()
-- -- --   vim.cmd("Lazy load neo-tree.nvim")
-- -- --   vim.cmd("Neotree toggle")
-- local enable = false
-- if enable then
--   vim.cmd("Oil --float"); enable = true
-- else
--
-- end
-- end
-- -- vim.keymap.set("n", "<leader>fi", ":let &splitright = 1 | vsplit . | wincmd l | vertical resize 30 | pwd<cr>", {})
-- vim.keymap.set("n", "<leader>fi",":lua FI()<CR>")
-- function toggle_oil()
--     local oil_open = false
--     for _, win in ipairs(vim.api.nvim_list_wins()) do
--         local buf = vim.api.nvim_win_get_buf(win)
--         local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
--         if ft == 'oil' then
--             oil_open = true
--             vim.api.nvim_win_close(win, true)
--         end
--     end
--     if not oil_open then
--             require('oil').setup({float = {
--       padding = -2,  -- Remove padding to make it more like a sidebar
--       max_width = -30,  -- Adjust width to match typical sidebar width
--       -- max_height = vim.o.lines,  -- Use full height of the editor
--       border = "none",  -- Remove border for a cleaner look
--       win_options = {
--   winblend = 0,  -- No transparency
--       },
--     },
--     })
--         vim.cmd('vsplit | wincmd l | Oil --float')
--     end
-- end
-- local function open_file_in_new_window()
--   local file = vim.fn.expand("<cfile>")
--   local filetype = vim.filetype.match({ filename = file })
--     if not filetype == "oil" then
--       -- vim.cmd("e " .. file)
--       vim.cmd("wincmd p | e " .. file)
--     -- else
--     end
-- end
--
-- _G.open_file_in_new_window = open_file_in_new_window
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--     pattern = "*",
--     callback = function()
--         if vim.bo.filetype == "oil" then
--             vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', ':lua open_file_in_new_window()<CR>', { noremap = true, silent = true })
--     -- if vim.bo.filetype == "oil" then
--     -- vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', ':<CR>', { noremap = true, silent = true })
--     -- end
--         end
--     end,
-- })
-- local function open_file_in_new_window()
--   local file = vim.fn.expand("<cfile>")
--   local filetype = vim.filetype.match({ filename = file })
--   if filetype ~= "oil" then
--     vim.cmd("wincmd :e $MYVIMRC | let &splitleft = 1 | vsplit . | wincmd h | e" .. file " | wincmd l | vertical resize 30 | wincmd h | pwd<CR>" .. file)
--
--   end
--
-- end
--
-- _G.open_file_in_new_window = open_file_in_new_window
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "*",
--   callback = function()
--     if vim.bo.filetype == "oil" then
--       vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', ':lua open_file_in_new_window()<CR>', { noremap = true, silent = true })
--     end
--   end,
-- })

--
vim.api.nvim_set_keymap("n", "<leader>fi", ":Oil<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>foi", ":Oil --float<CR>", { noremap = true, silent = true })

vim.keymap.set({ "n", "v", "i" }, "<C-c>", "<Esc>")
-- vim.keymap.set("n", " nc", ":set nocursorcolumn<cr>", {})
-- vim.keymap.set("n", " cc", ":set cursorcolumn<cr>", {})
-- vim.keymap.set("n", " cc", ":set cursorcolumn<cr>", {})
-- for toggling cursorcolumn
function toggle_cursorcolumn()
	local cursorcolumn_enabled = vim.api.nvim_get_option_value("cursorcolumn", {})
	if cursorcolumn_enabled then
		vim.cmd("set nocursorcolumn")
	else
		vim.cmd("set cursorcolumn")
	end
end

vim.keymap.set("n", "<leader>cc", ":lua toggle_cursorcolumn()<cr>", {})
-- for toggling hlsearch
function toggle_hlsearch()
	local hlsearch_enabled = vim.api.nvim_get_option_value("hlsearch", {})
	if hlsearch_enabled then
		vim.cmd("set nohlsearch")
	else
		vim.cmd("set hlsearch")
	end
end

vim.keymap.set("n", "<leader>hl", ":lua toggle_hlsearch()<cr>", {})
vim.keymap.set("n", "<leader>bn", ":bn<CR>", { noremap = true, silent = true }) --uffernext<cr>", {})
vim.keymap.set("n", "<leader>bp", ":bp<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>so", "<cmd>source $MYVIMRC<CR>", { noremap = true, silent = true })
-- vim.g.transparent_groups = vim.list_extend(
--   vim.g.transparent_groups or {},
--   vim.tbl_map(function(v)
--     return v.hl_group
--   end, vim.tbl_values(require('barbar.config').highlights))
-- )
-- might be useful doesn't seem be adding much work
-- vim.cmd("so")
--[[
 lazy
ui = {
    icons = {
      ft = "",
      lazy = "󰂠 ",
      loaded = "",
      not_loaded = "",
    },
  },
  nvimtree
  glyphs = {
        default = "󰈚",
        folder = {
          default = "",
          empty = "",
          empty_open = "",
          open = "",
          symlink = "",
        },
        git = { unmerged = "" },
        mason
        ui = {
    icons = {
      package_pending = " ",
      package_installed = " ",
      package_uninstalled = " ",
    },
  },
]]
--
