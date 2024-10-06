vim.g["loaded_python3_provider"] = 0
vim.g["loaded_perl_provider"] = 0
vim.g["loaded_ruby_provider"] = 0
vim.g["loaded_node_provider"] = 0

vim.g["config"] = vim.fn.expand("~/.config/nvim")
vim.g["cache"] = vim.fn.expand("~/.cache/nvim")
vim.g["denops#debug"] = 1

function DppInitPlugin(plugin)
	local src = vim.g["cache"] .. "/dpp/repos/github.com/" .. plugin
	if not vim.loop.fs_stat(src) then
		vim.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/" .. plugin .. ".git",
			src,
		})
	end
	vim.opt.runtimepath:prepend(src)
end

DppInitPlugin("Shougo/dpp.vim")
DppInitPlugin("Shougo/dpp-ext-lazy")

local dpp = require("dpp")

local dpp_base = vim.g["cache"] .. "/dpp"
local dpp_config = vim.g["config"] .. "/dpp.ts"

function DppMakeState()
	dpp.make_state(dpp_base, dpp_config)
end


if dpp.load_state(dpp_base) then
	local plugins = {
		"Shougo/dpp-ext-installer",
		"Shougo/dpp-ext-local",
		"Shougo/dpp-ext-toml",
		"Shougo/dpp-protocol-git",
		"vim-denops/denops.vim",
	}
	for i = 1, #plugins do
		DppInitPlugin(plugins[i])
	end
	vim.fn["denops#server#wait_async"](function()
		vim.api.nvim_echo({{"dpp.load_state() is failed.", "WarningMsg"}}, true, {})
		DppMakeState()
	end)
else
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "*.lua", "*.vim", "*.toml", "*.ts", "vimrc", ".vimrc" },
		callback = function()
			dpp.check_files()
		end
	})
	vim.api.nvim_create_autocmd("BufWritePost", {
		pattern = { "*.toml" },
		callback = function()
			if 0 < #dpp.sync_ext_action("installer", "getNotInstalled") then
				dpp.async_ext_action("installer", "install")
			end
		end
	})
end

vim.api.nvim_create_autocmd("User", {
	pattern = "Dpp:makeStatePost",
	callback = function()
		vim.api.nvim_echo({{"dpp.make_state() is done."}}, true, {})
	end
})

vim.opt["fileformat"] = "unix"
vim.opt["fileencodings"] = { "utf-8", "sjis", "cp932" }
vim.opt["confirm"] = true
vim.opt["number"] = true
vim.opt["numberwidth"] = 6
vim.opt["title"] = true
vim.opt["titlestring"] = "%f"
vim.opt["mouse"] = "a"
vim.opt["wrap"]= false
vim.opt["list"] = true
vim.opt["listchars"] = { tab = "|-", eol = "$", precedes = "<", extends = ">" }
vim.opt["tabstop"] = 4
vim.opt["shiftwidth"] = 4
vim.opt["softtabstop"] = 0
vim.opt["expandtab"] = false
vim.opt["virtualedit"] = "onemore"
vim.opt["incsearch"] = true
vim.opt["hlsearch"] = true
vim.opt["ignorecase"] = true
vim.opt["wrapscan"] = true
vim.opt["syntax"] = "on"
vim.cmd("filetype indent plugin on")
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { noremap = true })
vim.keymap.set("i", "==", ":LspDocumentFormat<CR>", { noremap = true })

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 or vim.fn.has("mac") == 1 then
	vim.opt.clipboard = "unnamed"
else
	vim.opt.clipboard = "unnamedplus"
end
