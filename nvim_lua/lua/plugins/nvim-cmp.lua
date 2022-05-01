-----------------------------------------------------------
-- Snippets
-----------------------------------------------------------
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

-----------------------------------------------------------
-- Autocomplete configuration file
-----------------------------------------------------------

local res, cmp = pcall(require, "cmp")
if not res then
  return
end

local tab_go_next = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

local tab_go_prev = function(fallback)
  if cmp.visible() then
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

cmp.setup {
  snippet = {
    -- must use a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    -- completion = { border = 'single' },
    -- documentation = { border = 'single' },
  },

  completion = {
    -- start completion immediately
    keyword_length = 1,
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer' },
  },

  mapping = {
    ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
    ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    -- Tab mapping
    ['<Tab>'] = cmp.mapping(tab_go_next, {'i', 'c'}),
    ['<S-Tab>'] = cmp.mapping(tab_go_prev, {'i', 'c'}),
    ['<C-j>'] = cmp.mapping(tab_go_next, {'i', 'c'}),
    ['<C-k>'] = cmp.mapping(tab_go_prev, {'i', 'c'}),
  },

  formatting = {
    deprecated = false,
    format = function(entry, vim_item)
        -- fancy icons and a name of kind
        local idx = vim.lsp.protocol.CompletionItemKind[vim_item.kind] or nil
        if tonumber(idx)>0 then
          vim_item.kind = vim.lsp.protocol.CompletionItemKind[idx]
        end

        -- set a name for each source
        vim_item.menu = ({
          path = "[Path]",
          buffer = "[Buffer]",
          luasnip = "[LuaSnip]",
          nvim_lua = "[Lua]",
          nvim_lsp = "[LSP]",
        })[entry.source.name]
        return vim_item
    end,
  },

  -- DO NOT ENABLE
  -- just for testing with nvim native completion menu
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
