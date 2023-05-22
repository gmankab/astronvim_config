return {
  updater = {
    remote = "origin",     -- remote to use
    channel = "stable",    -- "stable" or "nightly"
    version = "latest",    -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "nightly",    -- branch name (NIGHTLY ONLY)
    commit = nil,          -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil,     -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false,  -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
    auto_quit = false,     -- automatically quit the current session after a successful update
    remotes = {            -- easily add new remotes to track
      --   ["remote_name"] = "https://remote_url.come/repo.git", -- full remote url
      --   ["remote2"] = "github_user/repo", -- GitHub user/repo shortcut,
      --   ["remote3"] = "github_user", -- GitHub user assume AstroNvim fork
    },
  },

  -- Set colorscheme to use

  colorscheme = "gruvbox-material",
  plugins = {
    {
      "sainnhe/gruvbox-material",
      name = "gruvbox-material",
      config = function()
        require("gruvbox-material").setup {}
      end,
    },
    {
      "wfxr/minimap.vim",
      config = function()
        vim.g.minimap_width = 10
        vim.g.minimap_auto_start = 1
        vim.g.minimap_auto_start_win_enter = 1
      end,
    },
  },

  -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  diagnostics = {
    virtual_text = true,
    underline = true,
  },

  lsp = {
    -- customize lsp formatting options
    formatting = {
      -- control auto formatting on save
      format_on_save = {
        enabled = false,     -- enable or disable format on save globally
        allow_filetypes = { -- enable format on save for specified filetypes only
          -- "go",
        },
        ignore_filetypes = { -- disable format on save for specified filetypes
          -- "python",
        },
      },
      disabled = { -- disable formatting capabilities for the listed language servers
        -- disable lua_ls formatting capability if you want to use StyLua to format your lua code
        -- "lua_ls",
      },
      timeout_ms = 1000, -- default format timeout
      -- filter = function(client) -- fully override the default formatting function
      --   return true
      -- end
    },
    -- enable servers that you already have installed without mason
    servers = {
      -- "pyright"
    },
  },

  -- Configure require("lazy").setup() options
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = {
          "tohtml",
          "gzip",
          "matchit",
          "zipPlugin",
          "netrwPlugin",
          "tarPlugin",
        },
      },
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
    vim.api.nvim_set_keymap(
      'n',
      '<C-BS>',
      'db',
      {
        noremap = true,
        silent = true
      }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>w',
      '<C-w>w',
      {
        noremap = true,
        silent = true
      }
    )
    vim.api.nvim_set_keymap(
      'i',
      '<C-BS>',
      '<C-w>',
      {
        noremap = true,
        silent = true
      }
    )
    vim.api.nvim_set_keymap(
      'c',
      '<C-BS>',
      '<C-w>', {
        noremap = true,
        silent = true
      }
    )
    vim.api.nvim_set_keymap(
      't',
      '<Esc>',
      '<C-\\><C-n>',
      {
        noremap = true
      }
    )
    vim.api.nvim_set_keymap(
      'n', '<C-a>', 'ggVG', {
        noremap = true,
        silent = true,
      }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>s',
      ':tabnew ~/.config/nvim/lua/user/init.lua<CR>',
      {
        noremap = true,
        silent = true,
      }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>tt',
      ':term<CR>',
      {
        noremap = true,
        silent = true,
      }
    )
    vim.api.nvim_set_keymap(
      'n',
      '<leader>s',
      ':tabnew ~/.config/nvim/lua/user/init.lua<CR>',
      {
        noremap = true,
        silent = true,
      }
    )
    vim.api.nvim_set_keymap(
      'n', 'q', ':bd<CR>', {
        noremap = true,
        silent = true,
      }
    )
    require("neo-tree").setup({
      filesystem = {
        window = {
          width = 20,
        },
        filtered_items = {
          visible = true,
          show_hidden = true,
          hide_dotfiles = false,
          hide_gitignored = true,
        },
      },
    })
    local lspconfig = require('lspconfig')
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    }
    local ts = require 'nvim-treesitter.configs'
    ts.setup {
      indent = {
        enable = true,
        disable = {},
      },
      highlight = {
        enable = true,
        disable = {},
      },
    }
    require("neo-tree").setup({
      window = {
        mappings = {
          ["P"] = function(state)
            local node = state.tree:get_node()
            require("neo-tree.ui.renderer").focus_node(state, node:get_parent_id())
          end
        }
      }
    })
    vim.api.nvim_exec([[
      autocmd FocusLost * silent! w
    ]], false)
    vim.cmd('set indentexpr=')
    vim.cmd('filetype indent off')
    vim.cmd('set nofoldenable')
    vim.cmd('set foldcolumn=0')
    vim.cmd([[autocmd FocusLost * silent! wall]])
    vim.api.nvim_command("cnoremap <C-v> <C-r>+")
    vim.opt.autoindent = true
    vim.opt.smartindent = true
    vim.wo.signcolumn = "yes"
    vim.wo.wrap = true
    vim.wo.linebreak = true
    vim.o.encoding = "UTF-8"
    vim.o.autowriteall = true
  end,
}

