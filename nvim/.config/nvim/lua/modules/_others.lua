-- Specifies python and node provider path to make startup faster
vim.g.python3_host_prog = '/usr/bin/python3'
vim.g.node_host_prog = '/home/elianiva/.local/npm/bin/neovim-node-host'

-- gitlens(blamer) delay
vim.g.blamer_delay = 250

-- time format for gitlens(blamer)
vim.g.blamer_relative_time = 1

-- not sure what this does, might delete this later
vim.g.htl_all_templates = 1

-- svelte
vim.g.vim_svelte_plugin_has_init_indent = 0

-- lexima
vim.g.lexima_accept_pum_with_enter = 1