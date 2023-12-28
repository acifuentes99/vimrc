# VimRc

My own NeoVim configurations, now migrated into Lua

## Idea/Context

* Used for mutiple programming languages
* Salesforce compatible (for now, Apex language code)

## Installation

* Clone repo as "nvim" folder on nvim folder (`git clone https://github.com/acifuentes99/vimrc nvim`)
* Start nvim with Packer Sync (`nvim +PackerSync`)
* Enjoy magical Neovim experience

## ToDo

* [ ] Script installation for Apex language server, or integrate to some LSP Installer
* [ ] More clean configs and plugins loadings (some are in init.lua, and others in packer_init.lua)
* [ ] "Notes mode" and " 'NeoVim IDE Mode' " (As my previous configurations)
* [ ] Lazy loading of modes/plugins (Related to previous note)
* [ ] Git subfolder, or other functionality, to reference ohter repos, and install (for snippets for example, and syntax, currently copy/pasted from other repos)

## Lazyvim

* A migration must be done, from packer to Lazyvim.
* Lazyvim folder on Repo, has an stable configuration (working on my tablet) for extending to other uses (work, personal, etc)
* Still, has to be some thing migrated from old configuration (plugins, keybidings, autocommand, etc...). In the meantime. The old configuration files will be where are.
