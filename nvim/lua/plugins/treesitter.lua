return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        local ts = require('nvim-treesitter')

        ts.setup()

        ts.install({
            "bash", "c", "cmake", "cpp", "css", "dockerfile",
            "gitignore", "html", "java", "javascript", "jsdoc",
            "json", "lua", "make", "prisma", "python", "rust",
            "toml", "typescript", "yaml"
        })

        vim.api.nvim_create_autocmd('FileType', {
            group = vim.api.nvim_create_augroup('TreesitterFeatures', { clear = true }),
            callback = function(event)
                local ok = pcall(vim.treesitter.start, event.buf)

                if ok then
                    vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                    -- vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
                    -- vim.wo[0][0].foldmethod = 'expr'
                end
            end,
        })
    end
}
