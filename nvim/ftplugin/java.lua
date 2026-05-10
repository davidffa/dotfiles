local bundles = {
    vim.fn.glob("/opt/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar", 1),
}

local config = {
    cmd = {
        "jdtls",
        -- "--jvm-arg=-javaagent:/Users/david/.local/share/java/lombok.jar",
    },
    root_dir = vim.fs.dirname(vim.fs.find({ "gradlew", ".git", "mvnw" }, { upward = true })[1]),
    init_options = {
        bundles = bundles,
    },
    settings = {
        java = {
            format = {
                insertSpaces = true,
                tabSize = 4,
            },
            project = {
                referencedLibraries = {
                    -- "/usr/local/lib/antlr-4.13.1-complete.jar",
                    -- "/usr/local/lib/ST-4.3.4.jar",
                },
            },
        },
    },
    on_attach = function(client, bufnr)
        require("jdtls.dap").setup_dap_main_class_configs()

        local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false })

        if client.supports_method("textDocument/formatting") then
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
}

require("jdtls").start_or_attach(config)
