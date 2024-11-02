local dppSrc = vim.fn.stdpath("cache") .. "/dpp/repos/github.com/Shougo/dpp.vim"
local denopsSrc = vim.fn.stdpath("cache") .. "/dpp/repos/github.com/vim-denops/denops.vim"

vim.opt.runtimepath:prepend(dppSrc)

if not vim.loop.fs_stat(denopsSrc) then
 	vim.fn.system({
 		"git",
 		"clone",
 		"https://github.com/vim-denops/denops.vim.git",
 		denopsSrc
 	})
end

if not vim.loop.fs_stat(dppSrc) then
 	vim.fn.system({
 		"git",
 		"clone",
 		"https://github.com/Shougo/dpp.vim.git",
 		dppSrc
 	})
end



local dpp = require("dpp")

local dppBase = vim.fn.stdpath("cache") .. "/dpp"
local dppConfig = vim.fn.stdpath("config") .. "/config.ts"

-- option.
local ext_installer = vim.fn.stdpath("cache") .. "/dpp/repos/github.com/Shougo/dpp-ext-installer"
local ext_toml = vim.fn.stdpath("cache") .. "/dpp/repos/github.com/Shougo/dpp-ext-toml"
local ext_git = vim.fn.stdpath("cache") .. "/dpp/repos/github.com/Shougo/dpp-protocol-git"
local ext_lazy = vim.fn.stdpath("cache") .. "/dpp/repos/github.com/Shougo/dpp-ext-lazy"
local ext_local = vim.fn.stdpath("cache") .. "/dpp/repos/github.com/Shougo/dpp-ext-local"

if not vim.loop.fs_stat(ext_installer) then
 	vim.fn.system({
 		"git",
 		"clone",
 		"https://github.com/Shougo/dpp-ext-installer.git",
 		ext_installer
 	})
end

if not vim.loop.fs_stat(ext_toml) then
 	vim.fn.system({
 		"git",
 		"clone",
 		"https://github.com/Shougo/dpp-ext-toml.git",
 		ext_toml
 	})
end

if not vim.loop.fs_stat(ext_git) then
 	vim.fn.system({
 		"git",
 		"clone",
 		"https://github.com/Shougo/dpp-protocol-git.git",
 		ext_git
 	})
end

if not vim.loop.fs_stat(ext_lazy) then
 	vim.fn.system({
 		"git",
 		"clone",
 		"https://github.com/Shougo/dpp-ext-lazy.git",
 		ext_lazy
 	})
end


if not vim.loop.fs_stat(ext_local) then
 	vim.fn.system({
 		"git",
 		"clone",
 		"https://github.com/Shougo/dpp-ext-local.git",
 		ext_local
 	})
end


vim.opt.runtimepath:append(ext_installer)
vim.opt.runtimepath:append(ext_toml)
vim.opt.runtimepath:append(ext_git)
vim.opt.runtimepath:append(ext_lazy)
vim.opt.runtimepath:append(ext_local)

-- vim.g.denops_server_addr = "127.0.0.1:32123"
-- vim.g["denops#debug"] = 1


if dpp.load_state(dppBase) then
  vim.notify('load state run');
  vim.opt.runtimepath:prepend(denopsSrc)
  vim.opt.runtimepath:prepend(ext_installer)
  vim.api.nvim_create_augroup("ddp", {})

  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsReady",
    callback = function()
      vim.notify("dpp load_state() is failed")
      dpp.make_state(dppBase, dppConfig)
    end,
  })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "Dpp:makeStatePost",
  callback = function()
    vim.notify("dpp make_state() is done")
  end,
})


if vim.fn["dpp#min#load_state"](dppBase) then
  vim.opt.runtimepath:prepend(denopsSrc)

  vim.api.nvim_create_autocmd("User", {
    pattern = "DenopsReady",
    callback = function()
      vim.notify("dpp#min#load_state load_state() is failed")
      dpp.make_state(dppBase, dppConfig)
    end,
  })

end


vim.cmd("filetype indent plugin on")
vim.cmd("syntax on")

-- install
vim.api.nvim_create_user_command('DppInstall', "call dpp#async_ext_action('installer', 'install')", {})

-- update
vim.api.nvim_create_user_command(
    'DppUpdate', 
    function(opts)
        local args = opts.fargs
        vim.fn['dpp#async_ext_action']('installer', 'update', { names = args })
    end, 
    { nargs = '*' }
)
