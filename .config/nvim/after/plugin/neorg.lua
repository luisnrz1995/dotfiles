require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.dirman"] = {
            config = {
                workspaces = {
                    work = "~/Documents/neorg/work",
                    home = "~/Documents/neorg/home",
                }
            }
        }
    }
}
