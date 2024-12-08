return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

        null_ls.setup({
            sources = {
                null_ls.builtins.formatting.stylua,
                null_ls.builtins.formatting.isort,
                -- null_ls.builtins.formatting.google_java_format,
                null_ls.builtins.formatting.clang_format.with({
                    disabled_filetypes = { "java" },
                }),
                null_ls.builtins.formatting.prisma_format,
                -- null_ls.builtins.formatting.prettier,
            },
            on_attach = function(client, bufnr)
                if vim.bo.filetype ~= "java" and client.supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end,
        })

        vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
}
