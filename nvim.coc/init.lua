-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)


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


-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
-- vim.g.mapleader = "\\"
-- vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- add your plugins here
    { 'preservim/nerdcommenter' },
    { 'nvim-lualine/lualine.nvim',   requires = { 'nvim-tree/nvim-web-devicons', opt = true } },
    { 'gko/vim-coloresque' },
    { 'losingkeys/vim-niji' },
    { 'tpope/vim-surround' },
    { 'JuliaEditorSupport/julia-vim' },
    -- { 'zhaiyusci/onedark.vim' },
    { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { 'neoclide/coc.nvim',    branch = 'release' },
    { 'mhinz/vim-signify' },
    { 'tommason14/lammps.vim' },
    { 'ollykel/v-vim' },
    { 'luukvbaal/nnn.nvim' },
    { 'lambdalisue/suda.vim' },
    { 'junegunn/fzf' },
    {
      'cameron-wags/rainbow_csv.nvim',
      config = true,
      ft = {
        'csv',
        'tsv',
        'csv_semicolon',
        'csv_whitespace',
        'csv_pipe',
        'rfc_csv',
        'rfc_semicolon'
      },
      cmd = {
        'RainbowDelim',
        'RainbowDelimSimple',
        'RainbowDelimQuoted',
        'RainbowMultiDelim'
      }
    },
    {
      'nvim-treesitter/nvim-treesitter',
      config = {
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "comment" },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = true,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = false,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "javascript" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,

          -- list of language that will be disabled
          disable = { "latex" },

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },
      }
    },
    { 'lervag/vimtex' },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "default" } },
  -- automatically check for plugin updates
  checker = { enabled = false },
})

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

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'onedark',
    component_separators = { left = '\\', right = '/' },
    section_separators = { left = '', right = '' },
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
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding', 'fileformat', 'filetype' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = { 'location' },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}

-- Onedark theme
-- g.onedark_hide_endofbuffer = 1
-- g.onedark_terminal_italics = 1
-- g.onedark_termcolors = 256
-- opt.termguicolors = true

-- cmd("colorscheme onedark")

vim.cmd.colorscheme "catppuccin-macchiato"

keymap.set("n", "<F3>", ":set nu! <CR>", { desc = "Toggle line number.", silent = true })
keymap.set("n", "<F4>", ":set rnu! <CR>", { desc = "Toggle relative line number.", silent = true })
keymap.set("n", "<F5>", ":set hlsearch! <CR>", { desc = "Toggle highlight search.", silent = true })
keymap.set("n", "<F6>", ":set wrap! <CR>", { desc = "Toggle wrap lines.", silent = true })
keymap.set("n", "<F7>", ":set spell! <CR>", { desc = "Toggle spell check.", silent = true })
keymap.set("", "j", "gj", { silent = true })
keymap.set("", "k", "gk", { silent = true })
keymap.set("n", "<m-p>", "ostd::cout << __FILE__ << \" : \" << __LINE__ << std::endl;<esc>", { silent = true })

keymap.set("", "<c-h>", "<c-w>h", { silent = true })
keymap.set("", "<c-j>", "<c-w>j", { silent = true })
keymap.set("", "<c-k>", "<c-w>k", { silent = true })
keymap.set("", "<c-l>", "<c-w>l", { silent = true })

-- opt.pastetoggle = "<F2>"

keymap.set("n", "<leader>m",
  function()
    --print("Mouse" .. opt.mouse)
    if api.nvim_get_option_value("mouse", {}) == "" then
      opt.mouse = "a"
      api.nvim_set_option_value("mouse", "a", {})
      print("Mouse enabled.")
    else
      -- opt.mouse = ""
      api.nvim_set_option_value("mouse", "", {})
      print("Mouse disabled.")
    end
  end,
  { silent = true }
)

g.niji_matching_filetypes = { 'lisp', 'scheme', 'clojure', 'haskell', 'latex' }
g.NERDSpaceDelims = 1
g.rust_recommended_style = 0

g.fortran_do_enddo = 1
g.fortran_more_precise = 1

g.latex_to_unicode_auto = 1

opt.diffopt = { 'internal', 'algorithm:minimal' }

-- api.nvim_create_user_command("SaveWithSudo", ":w !sudo tee > /dev/null %:p:S", {})
