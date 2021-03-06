vim.cmd[[packadd gitsigns.nvim]]

require'gitsigns'.setup {
  signs = {
    add          = {hl = 'SignAdd'   , text = '┃'},
    change       = {hl = 'SignChange', text = '┃'},
    delete       = {hl = 'SignDelete', text = '┃'},
    topdelete    = {hl = 'SignDelete', text = '┃'},
    changedelete = {hl = 'SignChange', text = '┃'},
  },
  sign_priority = 5,
}
