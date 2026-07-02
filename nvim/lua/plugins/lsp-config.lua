return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup()
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "cssls",
                    "dockerls",
                    "docker_compose_language_service",
                    "eslint",
                    "html",
                    "pylsp",
                    -- "pyright",
                    "jsonls",
                    "lua_ls",
                    "prismals",
                    "ts_ls",
                    "tailwindcss",
                    "taplo",
                },
                automatic_installation = true,
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

            local on_attach = function(client, bufnr)
                if client:supports_method("textDocument/formatting") then
                    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = augroup,
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.format({ async = false })
                        end,
                    })
                end
            end

            vim.lsp.config("clangd", { capabilities = capabilities })
            vim.lsp.enable("clangd")

            vim.lsp.config("cssls", { capabilities = capabilities })
            vim.lsp.enable("cssls")

            vim.lsp.config("dockerls", { capabilities = capabilities })
            vim.lsp.enable("dockerls")

            vim.lsp.config("docker_compose_language_service", { capabilities = capabilities })
            vim.lsp.enable("docker_compose_language_service")

            vim.lsp.config("eslint", {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        buffer = bufnr,
                        command = "EslintFixAll",
                    })
                end,
            })
            vim.lsp.enable("eslint")

            vim.lsp.config("html", { capabilities = capabilities })
            vim.lsp.enable("html")

            vim.lsp.config("jsonls", { capabilities = capabilities })
            vim.lsp.enable("jsonls")

            vim.lsp.config("prismals", { capabilities = capabilities })
            vim.lsp.enable("prismals")

            -- vim.lsp.config("pyright", { capabilities = capabilities })
            vim.lsp.config("pylsp", { capabilities = capabilities })
            vim.lsp.enable("pylsp")

            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
                on_attach = on_attach,
            })
            vim.lsp.enable("rust_analyzer")

            vim.lsp.config("ts_ls", {
                capabilities = capabilities,
                on_attach = on_attach,
            })
            vim.lsp.enable("ts_ls")

            vim.lsp.config("tailwindcss", { capabilities = capabilities })
            vim.lsp.enable("tailwindcss")

            vim.lsp.config("taplo", { capabilities = capabilities })
            vim.lsp.enable("taplo")

            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
            vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
            vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

            vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
            vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
        end,
    },
}
