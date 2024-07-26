vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.cmd("set relativenumber")
vim.cmd("set cursorline")
vim.cmd("set cursorcolumn")
vim.cmd("set termguicolors")
vim.cmd("set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf")
vim.wo.number = true
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.pumblend = 0
vim.o.winblend = 0
vim.o.background = "dark"
vim.opt.hlsearch = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
-- listchars
vim.opt.list = true
vim.opt.listchars = {
    eol = '↴',
    tab = '» ',
    trail = '·',
    nbsp = '␣',
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
vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = '*',  -- Apply to all file types (customize as needed)
    callback = function()
        local mode = vim.fn.mode()
        if mode == 'v' or mode == 'V' then
          enable_list()
        else
          disable_list()
        end
    end
})

vim.opt.incsearch = true
vim.opt.swapfile = false
-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- Decrease update time
vim.opt.updatetime = 50
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true
-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
-- keymaps
vim.keymap.set("x", "<leader>p", "\"_dp")
vim.keymap.set("n", "<leader>y", "\"+y" )
vim.keymap.set("v", "<leader>y", "\"+y" )
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")
vim.keymap.set("n", "<Esc>", "cmd>nohlsearch<CR>", {})
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {})
vim.keymap.set("n", "<Esc>", "cmd>nohlsearch<CR>", {})
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("my-highlight-on-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
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
      'tpope/vim-sleuth',
    { 'numToStr/Comment.nvim', opts = {} },
   { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
    { 'mbbill/undotree',
      opts = {},
      config = function ()
        vim.keymap.set("n","<leader>u", vim.cmd.UndotreeToggle)
      end
    },
  {
    'tpope/vim-fugitive',
    opts = {},
    config = function ()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git ) 

    end,
  },
    -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      -- opts = {},
    },
	    {
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 10000,
	--config = function()
	--	--setting up the colorscheme
	--	require("catppuccin").setup()
	--	vim.o.background = "dark"
	--	vim.cmd.colorscheme("catppuccin")
	--end,
	},
  {
    "tiagovla/tokyodark.nvim",
    priority = 10000,
    opts = {
        -- custom options here
    },
    config = function(_, opts)
        require("tokyodark").setup(opts) -- calling setup is optional
        -- vim.cmd [[colorscheme tokyodark]]
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
        'nvim-telescope/telescope.nvim',
        event = 'VimEnter',
        branch = '0.1.x',
        dependencies = {
          'nvim-lua/plenary.nvim',
          { -- If encountering errors, see telescope-fzf-native README for installation instructions
            'nvim-telescope/telescope-fzf-native.nvim',

            -- `build` is used to run some command when the plugin is installed/updated.
            -- This is only run then, not every time Neovim starts up.
            build = 'make',

            -- `cond` is a condition used to determine whether this plugin should be
            -- installed and loaded.
            cond = function()
              return vim.fn.executable 'make' == 1
            end,
          },
          { 'nvim-telescope/telescope-ui-select.nvim' },

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
          require('telescope').setup {
            -- You can put your default mappings / updates / etc. in here
            --  All the info you're looking for is in `:help telescope.setup()`
            --
            -- defaults = {
            --   mappings = {
            --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
            --   },
            -- },
            -- pickers = {}
            extensions = {
              ['ui-select'] = {
                require('telescope.themes').get_dropdown(),
              },
            },
          }

          -- Enable Telescope extensions if they are installed
          pcall(require('telescope').load_extension, 'fzf')
          pcall(require('telescope').load_extension, 'ui-select')

          -- See `:help telescope.builtin`
          local builtin = require 'telescope.builtin'
          vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[S]earch [H]elp' })
          vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
          vim.keymap.set('n', '<leader><leader>', builtin.find_files, { desc = '[S]earch [F]iles' })
          vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
          vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
          vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
          vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
          vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[S]earch [R]esume' })
          vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
          vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[ ] Find existing buffers' })

          -- Slightly advanced example of overriding default behavior and theme
          vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to Telescope to change the theme, layout, etc.
            builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
              winblend = 10,
              previewer = false,
            })
          end, { desc = '[/] Fuzzily search in current buffer' })

          -- It's also possible to pass additional configuration options.
          --  See `:help telescope.builtin.live_grep()` for information about particular keys
          vim.keymap.set('n', '<leader>s/', function()
            builtin.live_grep {
              grep_open_files = true,
              prompt_title = 'Live Grep in Open Files',
            }
          end, { desc = '[S]earch [/] in Open Files' })

          -- Shortcut for searching your Neovim configuration files
          vim.keymap.set('n', '<leader>fmn', function()
            builtin.find_files { cwd = vim.fn.stdpath 'config' }
          end, { desc = '[S]earch [N]eovim files' })
        end,
      },
  { 'ThePrimeagen/harpoon',
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function ()
      local harpoon = require("harpoon")
      -- REQUIRED
      harpoon:setup()
      -- REQUIRED

      -- local mark = require("harpoon.mark")
      -- local ui = require("harpoon.ui")
      vim.keymap.set("n","<leader>+", function() harpoon:list():add() end)
      vim.keymap.set("n","<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n","<C-Up>", function() harpoon:list():select(1) end, { noremap = true, silent = true })
      vim.keymap.set("n","<C-Down>", function() harpoon:list():select(2) end, { noremap = true, silent = true })
      vim.keymap.set("n","<C-Left>", function() harpoon:list():select(3) end, { noremap = true, silent = true })
      vim.keymap.set("n","<C-Right>", function() harpoon:list():select(4) end, { noremap = true, silent = true })
    end,
  },
	{
                {'folke/playground',},
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
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
			local configs = require("nvim-treesitter.configs")
			configs.setup({
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
					"go",
					"json",
					"htmldjango",
					"java",
					"json5",
					"julia",
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
				highlight = { enable = true,
        additional_vim_regex_highlighting = { 'ruby' },},
				indent = { enable = true, disable = {'ruby'} },
			})
        -- Prefer git instead of curl in order to improve connectivity in some environments
        -- require('nvim-treesitter.install').prefer_git = true
		end,
	},
	{
		"nvim-tree/nvim-web-devicons",
                opts = {},
		-- config = function(_, opts)
		-- 	--setting up web dev icons
  --                       dofile(vim.g.base46_cache .. "devicons")
		-- 	require("nvim-web-devicons").setup(opts)
		-- end,
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
			"3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
		},
		config = function()
			--setting up neotree
			require("neo-tree").setup({
				window = {
					position = "right",
					width = 40,
					mapping_options = {
						noremap = true,
						nowait = true,
					},
				},
				filesystem = {
					filtered_items = {
						visible = false,
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_by_name = {
							-- Add any specific filenames you want to hide here
							-- e.g., ".git", ".DS_Store", "thumbs.db"
						},
					},
				},
				never_show = {},
			})
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			config = function()
				--setting up lualine
				require("lualine").setup({
					options = {
						theme = iceberg_dark,
						component_separators = { left = "", right = "" },
						section_separators = { left = "", right = "" },
						disabled_filetypes = {
							statusline = {},
							winbar = {},
						},
						ignore_focus = {},
						always_divide_middle = true,
						globalstatus = false,
						refresh = {
							statusline = 1000,
							tabline = 1000,
							winbar = 1000,
						},
					},
					sections = {
						lualine_a = { "mode" },
						lualine_b = { "branch", "diff", "diagnostics" },
						lualine_c = { "filename" },
						lualine_x = { "encoding", "fileformat", "filetype" },
						lualine_y = { "progress" },
						lualine_z = { "location" },
					},
					inactive_sections = {
						lualine_a = {},
						lualine_b = {},
						lualine_c = { "filename" },
						lualine_x = { "location" },
						lualine_y = {},
						lualine_z = {},
					},
					tabline = {},
					winbar = {},
					inactive_winbar = {},
					extensions = {},
				})
			end,
		},
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
    { "lukas-reineke/indent-blankline.nvim", main = "ibl",
      opts = {},
      config = function ()
        local highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
      }

      local hooks = require "ibl.hooks"
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

      require("ibl").setup({ indent = { highlight = highlight } })
      end
    },
		{ "folke/neoconf.nvim", cmd = "Neoconf" },
		"folke/lazydev.nvim",

	},
	{
		{
			"williamboman/mason.nvim",
			config = function()
				require("mason").setup()
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
						"asm_lsp",
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
					},
				})
			end,
		},
		{
			"neovim/nvim-lspconfig",
			config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
				local lspconfig = require("lspconfig")
				lspconfig.lua_ls.setup({
          capabilities = capabilities,
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
				lspconfig.nil_ls.setup({
          capabilities = capabilities,
        })
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
				lspconfig.zls.setup({
          capabilities = capabilities,
        })
				lspconfig.diagnosticls.setup({
          capabilities = capabilities,
        })
				--setting up lsp config keymaps
				local opts = { buffer = bufnr, noremap = true, silent = true }
				vim.keymap.set("n", "H", vim.lsp.buf.hover, opts) -- IMPORTANT: this is the keymap for hovering over a symbol.
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
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

					"IndentBlanklineChar",

					-- make floating windows transparent
					"LspFloatWinNormal",
					"Normal",
					"NormalFloat",
					"FloatBorder",
					"TelescopeNormal",
					"TelescopeBorder",
					"TelescopePromptBorder",
					"SagaBorder",
					"SagaNormal",
				},
				exclude_groups = {}, -- table: groups you don't want to clear
			})
			require("transparent").clear_prefix("NeoTree")
			require("transparent").clear_prefix("lualine")
   -- require('transparent').clear_prefix("mason")
    --vim.keymap.set("n", "<Space>te", ":TransparentEnable<CR>", {})
			vim.keymap.set("n", "<Space>td", ":TransparentDisable<CR>", {})
		end,
	},
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({})
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			--setting up bufferline
			require("bufferline").setup({})
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
			vim.keymap.set("n", "<leader>bgf", vim.lsp.buf.format, {})
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
    ]]--
  {
    "goolord/alpha-nvim",
    event = "VimEnter",
    enabled = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")
      math.randomseed(os.time())
      -- Set header
      local function pick_color()
                local colors = {"String", "Identifier", "Keyword", "Number"}
                return colors[math.random(#colors)]
            end
      local function footer()
                -- local total_plugins = #vim.tbl_keys(packer_plugins)
                local datetime = os.date(" %d-%m-%Y   %H:%M:%S")
                local version = vim.version()
                local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch

                return datetime .. nvim_version_info
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
          dashboard.button( "f", "  > Find file", ":Telescope find_files<CR>"),--cd $HOME/Workspace | 
          dashboard.button( "r", "  > Recent"   , ":Telescope oldfiles<CR>"),
          dashboard.button( "s", "  > Settings" , ":e $MYVIMRC | :cd %:p:h | split . | wincmd k | pwd<CR>"),
          dashboard.button( "e", "  > New file" , ":ene <BAR> startinsert <CR>"),
          dashboard.button( "q", "  > Quit NVIM", ":qa<CR>"),
      }
      -- Send config to alpha
      alpha.setup(dashboard.opts)
      -- require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end,
  },
  {
    'mfussenegger/nvim-dap',
    dependencies = {
    "nvim-neotest/nvim-nio",
    "rcarriga/nvim-dap-ui",
    'leoluz/nvim-dap-go',
    },
    config = function ()
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
      vim.keymap.set('n', '<leader>dt', require('dap').toggle_breakpoint, {})
      vim.keymap.set('n', '<leader>dc', require('dap').continue, {})
    end,
  },
  {
    {
      'hrsh7th/cmp-nvim-lsp',
    },
    {
      'L3MON4D3/LuaSnip',
      dependencies = {
        'saadparwaiz1/cmp_luasnip',
        'rafamadriz/friendly-snippets',
        'petertriho/cmp-git'
      },
    },
    {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require'cmp'
      require("luasnip.loaders.from_vscode").lazy_load()
      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
       --   vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
             require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
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
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' }, -- For luasnip users.
        --{ name = 'vsnip' }, -- For vsnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
        }, {
          { name = 'buffer' },
          -- { name = "supermaven" },
        })
	  })
	    end,
	    }
	 },
 }
    local opts = {}
    require('lazy').setup(plugins, opts)
local function rand_colorscheme()
  local less_preferred_colorschemes = {
    "blue",
    "zaibatsu",
    "darkblue",
    "default",
    "delek",
    "desert",
    "elflord",
    "evening",
    "habamax",
    "industry",
    "koehler",
    "lunaperche",
    "morning",
    "murphy",
    "pablo",
    "peachpuff",
    "quiet",
    "retrobox",
    "ron",
    "shine",
    "slate",
    "sorbet",
    "catppuccin-latte",
    "torte",
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
  }
  return more_preferred_colorschemes[math.random(#more_preferred_colorschemes)]
end
vim.cmd("colorscheme " .. rand_colorscheme())
function TE()
  vim.cmd("Lazy load transparent.nvim")
  vim.cmd("set nocursorcolumn")
  vim.cmd("TransparentEnable")
end
vim.keymap.set("n", "<leader>te",":lua TE()<CR>")
function FI()
  vim.cmd("Lazy load neo-tree.nvim")
  vim.cmd("Neotree toggle")
end
vim.keymap.set("n", "<leader>fi",":lua FI()<CR>")
-- vim.keymap.set("n", " nc", ":set nocursorcolumn<CR>", {})
-- vim.keymap.set("n", " cc", ":set cursorcolumn<CR>", {})
-- vim.keymap.set("n", " cc", ":set cursorcolumn<CR>", {})
-- for toggling cursorcolumn
function toggle_cursorcolumn()
   local cursorcolumn_enabled = vim.api.nvim_get_option_value('cursorcolumn', {})
   if cursorcolumn_enabled then
      vim.cmd('set nocursorcolumn')
   else
     vim.cmd('set cursorcolumn')
   end
end
vim.keymap.set("n", "<leader>cc", ":lua toggle_cursorcolumn()<CR>", {})
-- for toggling hlsearch
function toggle_hlsearch()
   local hlsearch_enabled = vim.api.nvim_get_option_value('hlsearch', {})
   if hlsearch_enabled then
      vim.cmd('set nohlsearch')
   else
     vim.cmd('set hlsearch')
   end
end
vim.keymap.set("n", "<leader>hl", ":lua toggle_hlsearch()<CR>", {})
