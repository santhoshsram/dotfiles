return {
  -- Colorscheme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        background = {
          light = "latte",
          dark = "mocha",
        },
      })
      vim.cmd.colorscheme "catppuccin"
    end,
  },

  -- Lightline statusline
  {
    "itchyny/lightline.vim",
    config = function()
      -- Lightline configuration
      vim.g.lightline = {
        colorscheme = 'catppuccin',
        separator = { left = '', right = '' },
        subseparator = { left = '', right = '' },
        active = {
          left = {
            { 'mode', 'paste' },
            { 'gitbranch', 'readonly', 'filename', 'modified' }
          },
          right = {
            { 'linepos', 'linetotalcount' },
            { 'percent' },
            { 'fileencoding', 'filetype' }
          }
        },
        component_function = {
          linepos = 'LightlineLinePos',
          linetotalcount = 'LightlineTotalLines',
          gitbranch = 'LightlineGitBranch'
        }
      }

      -- Lightline functions
      vim.cmd([[
        function! LightlineGitBranch()
          let branch = FugitiveHead()
          return branch !=# '' ? '' . branch : ''
        endfunction

        function! LightlineLinePos()
          return printf('%d:%d', col('.'), line('.'))
        endfunction

        function! LightlineTotalLines()
          return printf('☰ %d', line('$'))
        endfunction
      ]])
    end,
  },

  -- Git integration
  {
    "tpope/vim-fugitive",
  }
}
