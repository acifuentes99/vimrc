# VimRc
My own Neovim configurations, for everyday workflows.

## Idea/Context
* Have some custom functions for everyday confort when programming (exmaple: A macro selector using fzflua)
* Make nvim, a editor that helps me see the opened files (Custom sidebar implementation using Neotree to see buffers. Press enter and jump to them. And Aerial to jump to functions)
* Used for mutiple programming languages
* Salesforce compatible (for now, Apex language code)

## Installation
* Ensure having installed at least nvim 0.12
* Clone repo as "nvim" folder on nvim folder (`git clone https://github.com/acifuentes99/vimrc nvim`)
* Start vim (Lazy.nvim installs at first config load)
* Enjoy magical Neovim experience

* Optional : also, `ln -s -r nvim $HOME/.config/nvim` can be used to create folder that sync file changes

## Plugin configuration
* The idea of the configuration, is that can be dynamic depending on your devices, and what plugins you would need
* Go to "nvim/lua/plugins.lua"
* Define your plugins as you would do in Lazy.nvim
* Then, defina a table lua, with the name of the plugins to use in the system. (in my case, its "personal" list)
* Then, return the pluginlist, returned by last function* Then, return the pluginlist, returned by last function

```lua
local plugin_list = {}
local plugin_table = utils.filter_table_by_keys(plugins, personal)
utils.tableMerge(plugin_list, themes, plugin_table)
return plugin_list
```

## ToDo
* [ ] Lazy loading of modes/plugins (Related to previous note)
* [ ] Git subfolder, or other functionality, to reference ohter repos, and install (for snippets for example, and syntax, currently copy/pasted from other repos)
* [ ] More crazy stuff
