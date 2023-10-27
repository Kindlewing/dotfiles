_G.neovim = {}

-- Sets the keymaps in the given table
function neovim.set_keymaps(map_table, base_options)
  for mode, maps in pairs(map_table) do
    for keymap, options in pairs(maps) do
      if options then
        local cmd = options
        local keymap_opts = base_options or {}
        if type(options) == "table" then
          cmd = options[1]
          keymap_opts = vim.tbl_deep_extend("force", options, keymap_opts)
          keymap_opts[1] = nil
        end
        vim.keymap.set(mode, keymap, cmd, keymap_opts)
      end
    end
  end
end

return neovim
