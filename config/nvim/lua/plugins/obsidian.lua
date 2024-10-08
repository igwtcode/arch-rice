return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = true,
    -- ft = 'markdown',
    cmd = { 'ObsidianQuickSwitch', 'ObsidianToday', 'ObsidianNew', 'ObsidianOpen' },
    event = { 'BufReadPre ' .. vim.fn.expand '~' .. '/obsidian-vault/**.md' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local obsidian = require 'obsidian'

      vim.keymap.set('n', '<leader>os', '<cmd>ObsidianQuickSwitch<CR>', { desc = 'Obsidian Quick Switch' })
      vim.keymap.set('n', '<leader>od', '<cmd>ObsidianDailies<CR>', { desc = 'Obsidian Dailies' })
      vim.keymap.set('n', '<leader>ot', '<cmd>ObsidianTemplate<CR>', { desc = 'Obsidian Template' })
      vim.keymap.set('n', '<leader>ob', '<cmd>ObsidianBacklinks<CR>', { desc = 'Obsidian Backlinks' })
      -- vim.keymap.set('n', "<leader>on", "<cmd>ObsidianNew<CR>", { desc = "Obsidian New" })
      -- vim.keymap.set('n', "<leader>ow", "<cmd>ObsidianTomorrow<CR>", { desc = "Obsidian Tomorrow" })
      -- vim.keymap.set('n', "<leader>ot", "<cmd>ObsidianToday<CR>", { desc = "Obsidian Today" })

      obsidian.setup {
        workspaces = { { name = 'obsidian-vault', path = '~/obsidian-vault' } },

        disable_frontmatter = true,
        notes_subdir = 'inbox',
        new_notes_location = 'notes_subdir',

        daily_notes = {
          folder = 'daily',
          date_format = '%Y-%m-%d-%a',
          template = 'daily.md',
        },

        templates = {
          folder = 'template',
          date_format = '%Y-%m-%d-%a',
          time_format = '%H:%M',
        },

        note_id_func = function(title)
          return title
        end,
      }
    end,
  },
}
