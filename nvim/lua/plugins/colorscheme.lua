return {
    "catppuccin/nvim",
    -- "folke/tokyonight.nvim",
    -- name = "catppuccin",
    priority = 1000,
    config = function()
        vim.cmd.colorscheme "catppuccin"
        -- vim.cmd.colorscheme "tokyonight-night"
    end
}
