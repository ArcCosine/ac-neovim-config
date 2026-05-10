-- vim.o.pumborder = 'rounded' -- ポップアップメニューに罫線を追加
vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'fuzzy', 'popup' } -- popupを入れると候補の説明がプレビューされる

-- LSPの補完を自動で有効化
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
