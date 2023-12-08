local dpp_base      = "~/.config/nvim/dpp/"
local dpp_config    = "~/.config/nvim/dpp.ts"

local dpp_src       = dpp_base .. "repos/github.com/Shougo/dpp.vim"
local ext_toml      = dpp_base .. "repos/github.com/Shougo/dpp-ext-toml"
local ext_lazy      = dpp_base .. "repos/github.com/Shougo/dpp-ext-lazy"
local ext_installer = dpp_base .. "repos/github.com/Shougo/dpp-ext-installer"
local ext_git       = dpp_base .. "repos/github.com/Shougo/dpp-protocol-git"
local denops_src    = dpp_base .. "repos/github.com/vim-denops/denops.vim"

vim.opt.runtimepath:prepend(dpp_src)
vim.opt.runtimepath:append(ext_toml)
vim.opt.runtimepath:append(ext_git)
vim.opt.runtimepath:append(ext_lazy)
vim.opt.runtimepath:append(ext_installer)

if vim.fn["dpp#min#load_state"](dpp_base) then
	vim.opt.runtimepath:prepend(denops_src)

	vim.cmd(string.format("autocmd User DenopsReady call dpp#make_state('%s', '%s')", dpp_base, dpp_config))
end

vim.cmd("filetype indent plugin on")

if vim.fn.has("syntax") then
	vim.cmd("syntax on")
end

-- provider disable
vim.g['loaded_python3_provider'] = 0
vim.g['loaded_ruby_provider'] = 0
vim.g['loaded_node_provider'] = 0
vim.g['loaded_perl_provider'] = 0

-- file
vim.opt.binary         = false
vim.opt.fileformat     = "unix"
vim.opt.fileignorecase = false
vim.opt.fileencodings = { 'utf-8', 'sjis', 'cp932' }
--vim.opt.fileencoding  = ""
--vim.opt.encoding      = ""
-- save
vim.opt.confirm        = true
-- line number
vim.opt.number         = true
vim.opt.numberwidth    = 6
-- title
vim.opt.title          = true
vim.opt.titlestring    = "%f"
-- cmd
vim.opt.showcmd        = true
-- tab char
vim.opt.tabstop        = 4
vim.opt.shiftwidth     = 4
vim.opt.softtabstop    = 0
vim.opt.expandtab      = false
-- indent
vim.opt.autoindent     = true
vim.opt.smartindent    = true
-- visual
vim.opt.ambiwidth      = "double"
vim.opt.wrap           = false
vim.opt.list           = true
vim.opt.listchars      = { tab = '|-', eol = '$', precedes = '<', extends = '>' }
vim.opt.virtualedit    = "onemore"
vim.opt.showmatch      = true
vim.opt.matchpairs     = { "(:)", "{:}", "[:]" }
vim.opt.showmode       = true
-- status line
vim.opt.laststatus     = 2
vim.opt.statusline     = "%F[%R%M] %= %4l,%4c 0x04B"
-- tab line
vim.opt.showtabline    = 0
-- vim.opt.tabline        = ""
-- cursor
vim.opt.cursorline     = true
vim.opt.cursorcolumn   = false
vim.opt.signcolumn     = "yes" --?
-- mouse
vim.opt.mouse          = "a"
-- search
vim.opt.incsearch      = true
vim.opt.hlsearch       = true
vim.opt.ignorecase     = true
vim.opt.smartcase      = false --ignorecaseと逆
vim.opt.wrapscan       = true
-- complement
vim.opt.wildmenu       = true
vim.opt.wildmode       = "longest"
vim.opt.wildoptions    = ""
vim.opt.wildignorecase = true
-- clipboard
if vim.fn.has('wsl') == 1 then
	vim.opt.clipboard = "unnamedplus"
	-- apt install xclip
elseif vim.fn.has('win32') == 1 or vim.fn.has('win64') == 1 or vim.fn.has('mac') == 1 then
	vim.opt.clipboard = "unnamed"
else
	vim.opt.clipboard = "unnamedplus"
end

-- keymap
-- vim.g.mapleader = vim.keycode'<Space>'
vim.keymap.set('n','<Esc><Esc>', ':nohlsearch<CR>', { noremap = false })
vim.keymap.set('n','==','gg=G',{noremap = true})

vim.keymap.set('n','<F2>',':!typst compile %<CR>',{noremap = true})

