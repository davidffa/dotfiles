return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function ()
        local config = require("nvim-treesitter.configs")
        config.setup({
            auto_install = true,
            ensure_installed = {"bash", "c", "cmake", "cpp", "css", "dockerfile", "gitignore", "html", "java", "javascript", "jsdoc", "json", "lua", "make", "prisma", "python", "rust", "toml", "typescript", "yaml"},
            highlight = { enable = true },
            indent = { enable = true },
            autotag = { enable = true },
        })
    end
}
