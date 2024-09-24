return {
  {
    'stevearc/oil.nvim',
    event = 'VeryLazy',
    opts = {},
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        float = {
          max_height = 45,
          max_width = 72,
        },
        use_default_keymaps = false,
        keymaps = {
          ['g?'] = 'actions.show_help',
          ['<CR>'] = 'actions.select',
          ['<C-x>'] = 'actions.select_split',
          ['<C-v>'] = 'actions.select_vsplit', -- this is used to navigate left
          ['<C-t>'] = 'actions.select_tab',
          ['<C-p>'] = 'actions.preview',
          ['<C-c>'] = 'actions.close',
          ['<C-r>'] = 'actions.refresh',
          ['-'] = 'actions.parent',
          ['_'] = 'actions.open_cwd',
          ['`'] = 'actions.cd',
          ['~'] = 'actions.tcd',
          ['gs'] = 'actions.change_sort',
          ['gx'] = 'actions.open_external',
          ['g.'] = 'actions.toggle_hidden',
        },
        view_options = {
          -- show_hidden = true,
        },
        -- columns = {
        --   "icon",
        --   "permissions",
        --   "size",
        --   "mtime",
        -- },
      }
    end,
  },
}
