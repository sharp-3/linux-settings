return {
	{
		"tomasr/molokai",
		lazy = true,
		event = "VimEnter",
		config = function()
			vim.cmd.colorscheme("molokai")
		end,
	},{
		"rust-lang/rust.vim",
		lazy = true,
		ft = "rust",
	},{
		"kaarmu/typst.vim",
		lazy = true,
		ft = "typst",
	},{
		"vim-denops/denops.vim",
		lazy = true,
		config = function()
				vim.g["denops#debug"] = 1
		end,
	},{
		"Shougo/ddc.vim",
		lazy = true,
		dependencies = {
			"denops.vim",
			"ddc-ui-pum",
			--"ddc-source-vim-lsp",
			"ddc-source-lsp-setup",
			"denops-popup-preview.vim",
			"denops-signature_help",
			"ddc-source-dictionary",
			"ddc-source-around",
			"ddc-filter-matcher_head",
			"ddc-filter-sorter_rank",
			"ddc-fuzzy",
		},
		--event = "VimEnter",
		ft = { "c", "cpp", "rust", "typst", "java" },
		config = function()
			vim.fn["ddc#custom#patch_global"]({
				ui = "pum",
				sources = {
					"lsp",
					--"around",
					--"dictionary",
					--"vim-lsp",
				},
				sourceParams = {
					dictionary = {
						dictPaths = {
							"/usr/share/dict/words",
						},
						smartCase = true,
						isVolatile = true,
					},
					lsp = {
						enableResolveItem = true,
						enableAdditionalTextEdit = true,
					}
				},
				sourceOptions = {
					_ = {
						--matchers = { "matcher_head" },
						--sorters  = { "sorter_rank" },
						matchers   = { "matcher_fuzzy" },
						sorters    = { "sorter_fuzzy" },
						converters = { "converter_fuzzy" },
					},
					around = {
						mark = "A",
					},
					dictionary = {
						mark = "D",
					},
					path = {
						mark = "P",
					},
					--[[
					["vim-lsp"] = {
						mark = "L",
						forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
					},
					]]--
					lsp = {
						mark = "L",
						dup = "keep",
						matchers = { "matcher_head" },
						sorters  = { "sorter_rank" },
						converters = {},
						--keywordPattern = [["\\k+"]],
						--forceCompletionPattern = [["\\.\\w*|:\\w*|->\\w*"]],
					},
				},
				filterParams = {
					matcher_fuzzy = {
						--splitMode = "word",
					},
					converter_fuzzy = {
						--hlGroup = "SpellBad",
					}
				},
			})
			vim.fn["ddc#enable"]()
		end
	},{
		"Shougo/ddc-ui-pum",
		lazy = true,
		dependencies = "pum.vim",
	},{
		"Shougo/pum.vim",
		lazy = true,
		config = function()
			vim.keymap.set('i', '<Tab>',   function() if vim.fn['pum#visible']() == true then vim.call('pum#map#select_relative',  1)     else return '<Tab>'   end end, { expr = true })
			vim.keymap.set('i', '<S-Tab>', function() if vim.fn['pum#visible']() == true then vim.call('pum#map#select_relative', -1)     else return '<S-Tab>' end end, { expr = true })
			vim.keymap.set('i', '<Esc>',   function() if vim.fn['pum#visible']() == true then vim.call('pum#map#cancel')                  else return '<Esc>'   end end, { expr = true })
			vim.keymap.set('i', '<Up>',    function() if vim.fn['pum#visible']() == true then vim.call('pum#map#cancel') return '<Up>'    else return '<Up>'    end end, { expr = true })
			vim.keymap.set('i', '<Down>',  function() if vim.fn['pum#visible']() == true then vim.call('pum#map#cancel') return '<Down>'  else return '<Down>'  end end, { expr = true })
			vim.keymap.set('i', '<Left>',  function() if vim.fn['pum#visible']() == true then vim.call('pum#map#cancel') return '<Left>'  else return '<Left>'  end end, { expr = true })
			vim.keymap.set('i', '<Right>', function() if vim.fn['pum#visible']() == true then vim.call('pum#map#cancel') return '<Right>' else return '<Right>' end end, { expr = true })
			vim.keymap.set('i', '<CR>',    function() if vim.fn['pum#visible']() == true then vim.call('pum#map#confirm')                 else return '<CR>'    end end, { expr = true })
		end
	},{
		"matsui54/ddc-source-dictionary",
		lazy = true,
	},{
		"tani/ddc-fuzzy",
		lazy = true,
	},

--[[
	{
		"shun/ddc-source-vim-lsp",
		lazy = true,
		dependencies = "vim-lsp-settings",
	},{
		"mattn/vim-lsp-settings",
		lazy = true,
		dependencies = "vim-lsp",
	},{
		"prabirshrestha/vim-lsp",
		lazy = true,
		config = function()
			vim.g.lsp_log_verbose = 1
			vim.g.lsp_log_file = vim.fn.expand("~/.config/nvim/vim-lsp.log")
		end,
	},
]]--
	{
		"uga-rosa/ddc-source-lsp-setup",
		lazy = true,
		dependencies = "ddc-source-lsp",
		config = function()
			require("ddc_source_lsp_setup").setup()
			local lspconfig = require("lspconfig")
			lspconfig.rust_analyzer.setup({
				on_attach = function(client, bufnr)
					vim.lsp.inlay_hint.enable(0, true)
				end,
			})
			lspconfig.clangd.setup({
				cmd = {
					"clangd",
					"--header-insertion=never"
				}
			})
			lspconfig.jdtls.setup{}
			lspconfig.typst_lsp.setup({
				settings = {
					exportPdf = "onSave"
				}
			})
		end
	},{
		"Shougo/ddc-source-lsp",
		lazy = true,
		dependencies = "nvim-lspconfig",
	},{
		"neovim/nvim-lspconfig",
		lazy = true,
		--[[
		config = function()
			vim.lsp.set_log_level("debug")
		end,
		]]--
	},{
		"matsui54/denops-popup-preview.vim",
		lazy = true,
		dependencies = "denops.vim",
		config = function()
			vim.fn["popup_preview#enable"]()
		end,
	},{
		"matsui54/denops-signature_help",
		lazy = true,
		dependencies = "denops.vim",
		config = function()
			vim.fn["signature_help#enable"]()

			-- for vim-lsp
			vim.g["lsp_signature_help_enabled"] = 0
		end,
	},{
		"Shougo/ddc-source-around",
		lazy = true,
	},{
		"Shougo/ddc-filter-matcher_head",
		lazy = true,
	},{
		"Shougo/ddc-filter-sorter_rank",
		lazy = true,
	}
}
