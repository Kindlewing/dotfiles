local bindings = require('keymaps')

require('packer-plugins')
require('theme')
require('settings')
require('plugins.dashboard').config()
require('plugins.treesitter')
require('plugins.telescope').config()


bindings.setCocBindings()
bindings.setSplitNavigationBindings()
bindings.setTelescopeBindings()
bindings.setDashboardBindings()
