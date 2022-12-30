local opt=vim.opt
local keymap=vim.keymap
local g=vim.g
local cmd=vim.cmd

--Language settings
opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
opt.encoding = "utf-8"
opt.termencoding = "utf-8"
opt.fileformat = "unix"

opt.backspace = "indent,eol,start"
opt.backup = false
opt.mouse = ""


local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print('Installing packer...')
  local packer_url = 'https://github.com/wbthomason/packer.nvim'
  vim.fn.system({ 'git', 'clone', '--depth', '1', packer_url, install_path })
  print('Done.')

  vim.cmd('packadd packer.nvim')
  install_plugins = true
end
--install_plugins = true

require('packer').startup(function(use)
  use 'preservim/nerdcommenter'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'gko/vim-coloresque'
  use 'losingkeys/vim-niji'
  use 'tpope/vim-surround'
  use 'JuliaEditorSupport/julia-vim'
  use { 'joshdick/onedark.vim', branch = 'main' }
  use { 'neoclide/coc.nvim', branch = 'release' }
  use 'mhinz/vim-signify'
  use 'tommason14/lammps.vim'
  use 'ollykel/v-vim'
  use 'luukvbaal/nnn.nvim'

  if install_plugins then
    require('packer').sync()
  end
end)

opt.history = 50
opt.ruler = true
opt.showcmd = true
opt.incsearch = true
opt.hlsearch = false
opt.foldmethod = "marker"
keymap.set("n", "<space>", "za", { desc = "Enable folding with the spacebar." })

opt.number = true
opt.signcolumn = "yes"
opt.showtabline = 2


-- tab settings
opt.smarttab = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true

-- Conquer of Completion (CoC) settings
require("coc")

-- Airline settings
opt.laststatus = 2
g.airline_powerline_fonts = true
opt.showmode = false
g.airline_theme = "onedark"
g.airline_experimental = 0

-- Onedark theme
g.onedark_hide_endofbuffer = 1
g.onedark_terminal_italics = 1
g.onedark_termcolors = 256
opt.termguicolors = true

cmd("colorscheme onedark")
