-- local filetype_tabstop = { lua=2, markdown=2,js=4 }

-- augroup の定義
vim.api.nvim_create_augroup("typescript", { clear = true })

-- ファイルの読み込みや新規作成時のファイルタイプ設定
vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  group = "typescript",
  pattern = "*.tsx",
  callback = function()
    vim.bo.filetype = "typescript"
    vim.bo.syntax = "typescriptreact"
  end
})

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  group = "typescript",
  pattern = "*.ts",
  callback = function()
    vim.bo.filetype = "typescript"
    vim.bo.syntax = "javascript"
  end
})

-- for buffer
-- au BufNewFile,BufRead * set tabstop=4 shiftwidth=4
-- au BufNewFile,BufRead *.rb set tabstop=2 shiftwidth=2
-- au BufNewFile,BufRead *.yml set tabstop=2 shiftwidth=2
-- au BufNewFile,BufRead *.js set tabstop=4 shiftwidth=4 filetype=javascript
-- au BufNewFile,BufRead *.css set tabstop=4 shiftwidth=2
-- au BufNewFile,BufRead *.html set tabstop=4 shiftwidth=2
-- au BufNewFile,BufRead *.php set tabstop=4 shiftwidth=2

-- augroup typescript
--   au!
--   autocmd BufNewFile,BufRead *.tsx   set filetype=typescript
--   autocmd BufNewFile,BufRead *.tsx   set syntax=typescriptreact
--   autocmd BufNewFile,BufRead *.ts   set filetype=typescript
--   autocmd BufNewFile,BufRead *.ts   set syntax=javascript
-- augroup END

