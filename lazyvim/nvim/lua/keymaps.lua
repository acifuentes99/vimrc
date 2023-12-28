local map = require("utils").mapKey

--vim.g.mapleader = ','

map('n', '<leader>1', '1gt')
map('n', '<leader>2', '2gt')
map('n', '<leader>3', '3gt')
map('n', '<leader>4', '4gt')
map('n', '<leader>5', '5gt')
map('n', '<leader>6', '6gt')
map('n', '<leader>7', '7gt')
map('n', '<leader>8', '8gt')
map('n', '<leader>9', '9gt')
map('n', '<leader>t', ':tabnew<CR>')
map('n', '<leader>x', ':tabclose<CR>')

map('n', '<leader>p', ':FzfLua files<CR>')
map('n', '<leader>h', ':FzfLua oldfiles<CR>')
map('n', '<leader>b', ':FzfLua buffers<CR>')
map('n', '<leader>w', ':FzfLua tabs<CR>')
map('n', '<leader>f', ':FzfLua commands<CR>')

map('n', '<leader>e', ':Explore<CR>')
map('n', '<A-x>', ':close<CR>')

--map('n', '<A-p>', ':FzfLua files<CR>')
--map('n', '<A-h>', ':FzfLua oldfiles<CR>')
--map('n', '<A-b>', ':FzfLua buffers<CR>')
--map('n', '<A-w>', ':FzfLua tabs<CR>')
    --map('n', '<A-f>', ':FzfLua commands<CR>')
