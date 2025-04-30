vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

opt.fileencoding = "utf-8"
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftround = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.numberwidth = 3
opt.mouse = "a"
opt.showmode = false
opt.breakindent = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.backup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 250
opt.timeoutlen = 300
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.cursorline = true
opt.scrolloff = 10
opt.confirm = true
opt.completeopt = "menu,menuone"
opt.ruler = false
