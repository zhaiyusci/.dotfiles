local opt = vim.opt
local keymap = vim.keymap
local g = vim.g
local cmd = vim.cmd
local api = vim.api

--Language settings
opt.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"
opt.encoding = "utf-8"
-- opt.termencoding = "utf-8"
opt.fileformat = "unix"

opt.backspace = "indent,eol,start"
opt.backup = false
opt.mouse = ""


local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path, 0, 0, 0)) > 0 then
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
  use 'lambdalisue/suda.vim'
  use 'junegunn/fzf'
  use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

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
-- opt.foldmethod = "syntax"
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

keymap.set("n", "<F3>", ":set nu! <CR>", { desc = "Toggle line number.", silent = true })
keymap.set("n", "<F4>", ":set rnu! <CR>", { desc = "Toggle relative line number.", silent = true })
keymap.set("n", "<F5>", ":set hlsearch! <CR>", { desc = "Toggle highlight search.", silent = true })
keymap.set("n", "<F6>", ":set wrap! <CR>", { desc = "Toggle wrap lines.", silent = true })
keymap.set("n", "<F7>", ":set spell! <CR>", { desc = "Toggle spell check.", silent = true })
keymap.set("", "j", "gj", { silent = true })
keymap.set("", "k", "gk", { silent = true })

keymap.set("", "<c-h>", "<c-w>h", { silent = true })
keymap.set("", "<c-j>", "<c-w>j", { silent = true })
keymap.set("", "<c-k>", "<c-w>k", { silent = true })
keymap.set("", "<c-l>", "<c-w>l", { silent = true })

-- opt.pastetoggle = "<F2>"

keymap.set("n", "<leader>m",
  function()
    --print("Mouse" .. opt.mouse)
    if vim.api.nvim_get_option("mouse") == "" then
      opt.mouse = "a"
      print("Mouse enabled.")
    else
      opt.mouse = ""
      print("Mouse disabled.")
    end
  end,
  { silent = true }
)

g.niji_matching_filetypes = { 'lisp', 'scheme', 'clojure', 'haskell' }
g.NERDSpaceDelims = 1
g.rust_recommended_style = 0

g.fortran_do_enddo = 1
g.fortran_more_precise = 1

g.latex_to_unicode_auto = 1

-- api.nvim_create_user_command("SaveWithSudo", ":w !sudo tee > /dev/null %:p:S", {})
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
