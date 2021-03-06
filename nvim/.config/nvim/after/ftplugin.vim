" Set formatoptions
au FileType * setlocal formatoptions-=cro

" Set filetypes
au BufNewFile,BufRead *.ejs,*.hbs set filetype=html
au BufNewFile,BufRead .prettierrc,.eslintrc set filetype=json
au BufNewFile,BufRead tsconfig.json set filetype=jsonc
au BufRead,BufNewFile *.svx,*.mdx set ft=markdown
au BufRead,BufNewFile *.svelte set ft=svelte

" Set github text field to markdown (firenvim stuff)
au BufEnter github.com_*.txt set filetype=markdown

" Set tabsize for each filetype
au FileType go setlocal sw=4 ts=4 sts=4 noexpandtab
au FileType lua setlocal sw=2 ts=2 sts=2
au FileType java setlocal sw=4 ts=4 sts=4
au FileType c,cpp setlocal sw=4 ts=4 sts=4
au FileType php setlocal sw=4 ts=4

" Enable emmet.vim on these filetypes
au FileType html,javascript,php,xml,svelte,typescriptreact EmmetInstall

" enable spelling in markdown
au FileType markdown setlocal conceallevel=3 concealcursor=nc spell

" Remove trailing whitespace on save
au BufWritePre * %s/\s\+$//e

" Set PHP indentation
let b:PHP_default_indenting = 1

" automatically go to insert mode on terminal buffer
autocmd TermOpen * startinsert

" enable/disable wordwrap
augroup Goyo
  au!
  au User GoyoEnter setlocal linebreak wrap
  au User GoyoLeave setlocal nolinebreak nowrap
augroup END

" disable nvim-compe inside telescope
augroup Compe
  au!
  au BufEnter * let g:compe_enabled = v:true
  au FileType TelescopePrompt let g:compe_enabled = v:false
augroup END

" hide the cursor if we're inside NvimTree
augroup HideCursor
  au!
  au WinLeave,FileType NvimTree set guicursor=n-v-c-sm:block,i-ci-ve:ver2u,r-cr-o:hor20,
  au WinEnter,FileType NvimTree set guicursor=n-c-v:block-Cursor/Cursor-blinkon0,
augroup END
au FileType NvimTree hi Cursor blend=100
