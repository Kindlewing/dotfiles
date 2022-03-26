local M = {}

function M.config()
    local g = vim.g
    local fn = vim.fn
    local plugins_count = fn.len(vim.fn.globpath(fn.stdpath "data" .. "/site/pack/packer/start", "*", 0, 1))

    g.dashboard_default_executive = 'telescope'
  
    g.dashboard_custom_section = {
        a = { description = { "   Find File                Binding: <Space> f f" }, command = "Telescope find_files" },
        b = { description = { "   Recents                  Binding: <Space> f o" }, command = "Telescope oldfiles" },
        c = { description = { "   Find Word                Binding: <Space> f w" }, command = "Telescope live_grep" },
        d = { description = { "   New File                 Binding: <Space> f n" }, command = "DashboardNewFile" },
        e = { description = { "   Bookmarks                Binding: <Space> b m" }, command = "Telescope marks" },
        f = { description = { "   Last Session             Binding: <Space> s l" }, command = "SessionLoad" },
    }

    g.dashboard_custom_footer = {
        " ",
        " Neovim loaded " .. plugins_count .. " plugins ",
    }
end

return M
