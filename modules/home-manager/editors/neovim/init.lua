vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = "yes"
vim.o.wrap = false
vim.o.tabstop = 4
vim.g.mapleader = " "
vim.o.winborder = "rounded"

vim.keymap.set("n", "<leader>o", ":update<CR> :source<CR>")
vim.keymap.set("n", "<leader>w", ":write<CR>")
vim.keymap.set("n", "<leader>q", ":quit<CR>")

vim.keymap.set({ "n", "v", "x" }, "<leader>y", '"+y<CR>')
vim.keymap.set({ "n", "v", "x" }, "<leader>d", '"+d<CR>')

vim.pack.add({
	{ src = "https://github.com/bluz71/vim-moonfly-colors" },
	-- { src = "https://github.com/stevearc/oil.nvim" },
	-- {src = "https://github.com/echasnovski/mini.pick"},
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim", tag = "0.1.8" },
	{ src = 'https://github.com/hrsh7th/cmp-nvim-lsp' },
	{ src = 'https://github.com/hrsh7th/cmp-path' },
	{
		src = "https://github.com/L3MON4D3/LuaSnip",
		-- follow latest release.
		version = "v2.*"
	},
	{ src = 'https://github.com/saadparwaiz1/cmp_luasnip' },
	{ src = 'https://github.com/hrsh7th/nvim-cmp' },
	{
		src = 'https://github.com/saecki/crates.nvim',
		tag = 'stable',
	}
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		-- if client:supports_method("textDocument/completion") then
		-- 	vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
		-- end
	end
})
vim.cmd("set completeopt+=noselect")


vim.opt.signcolumn = 'yes'
vim.lsp.inlay_hint.enable(true)


vim.lsp.enable({ "lua_ls" })
require('lspconfig').nil_ls.setup({
	settings = {
		['nil'] = {
			formatting = {

				command = { "nixfmt" }
			}
		},
	}

})
vim.lsp.enable('pylsp')
require("crates").setup {
	lsp = {
		enabled = true,
		on_attach = function(client, bufnr)
			-- the same on_attach function as for your other lsp's
		end,
		actions = true,
		completion = true,
		hover = true,
	}

}
vim.lsp.enable('rust_analyzer')
vim.lsp.enable('taplo')
vim.lsp.config("nil_ls",{
	settings = {
		['nil'] = {
			formatting = {

				command = { "nixfmt" }
			}
		},
	}

})
vim.lsp.enable('ccls')
-- vim.lsp.enable("clangd")
-- require("lspconfig").clangd.setup({
--   -- Other settings...
--   cmd = {
--     "clangd",
--     "--background-index",
--     "--query-driver=/nix/store/vr15iyyykg9zai6fpgvhcgyw7gckl78w-gcc-wrapper-14.3.0/bin/g++",-- **CHANGE THIS PATH**
-- 	-- e.g., "--query-driver=/usr/bin/g++" or the specific version
--   },
-- })

vim.cmd("colorscheme moonfly")
vim.cmd("hi statusline guibg=NONE")

local builtin = require("telescope.builtin")
-- require "oil".setup()


vim.keymap.set("n", "<F3>", vim.lsp.buf.format)
vim.keymap.set("n","<F4>",vim.lsp.buf.code_action)
vim.keymap.set("n", "<C-P>", function()
	local res, _ = pcall(builtin.git_files)
	if res ~= true then
		builtin.find_files()
	end
end)
vim.keymap.set("n", "<leader>g", builtin.live_grep)
vim.keymap.set("n", "<leader>h", builtin.help_tags)
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- vim.keymap.set("n", "<leader>e", ":Oil<CR>")


local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
	'force',
	lspconfig_defaults.capabilities,
	require('cmp_nvim_lsp').default_capabilities()
)


-- Autocompletion
local cmp = require('cmp')


cmp.setup({
	sources = {
		{ name = 'path' },
		{ name = 'nvim_lsp' },
		{ name = 'luasnip', keyword_length = 2 },
		{ name = 'buffer',  keyword_length = 3 },
	},
	snippet = {
		expand = function(args)
			-- You need Neovim v0.10 to use vim.snippet
			vim.snippet.expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		['<CR>'] = cmp.mapping.confirm({ select = false }),
		-- ['<Tab>'] = cmp_action.tab_complete(),
		['<C-Space>'] = cmp.mapping.complete(),
		['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),

	}),
})

