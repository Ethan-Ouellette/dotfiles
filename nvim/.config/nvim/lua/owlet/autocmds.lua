-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.hl.on_yank()
    end,
})

-- LSP keymaps and document highlight on attach
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
    callback = function(event)
        local map = function(keys, func, desc, mode)
            vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Override built-in gr* defaults to use Telescope pickers
        map("grr", function()
            require("telescope.builtin").lsp_references()
        end, "[G]oto [R]eferences")
        map("gri", function()
            require("telescope.builtin").lsp_implementations()
        end, "[G]oto [I]mplementation")
        map("gO", function()
            require("telescope.builtin").lsp_document_symbols()
        end, "Open Document Symbols")
        map("gW", function()
            require("telescope.builtin").lsp_dynamic_workspace_symbols()
        end, "Open Workspace Symbols")
        map("grt", function()
            require("telescope.builtin").lsp_type_definitions()
        end, "[G]oto [T]ype Definition")
        map("gD", function()
            require("telescope.builtin").lsp_definitions()
        end, "[G]oto [D]efinition")
        -- gD → declaration (not the same as definition above)
        map("grD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
        map("<leader>th", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
        end, "[T]oggle Inlay [H]ints")

        -- Document highlight: illuminate references when cursor rests
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local hl_group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                buffer = event.buf,
                group = hl_group,
                callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                buffer = event.buf,
                group = hl_group,
                callback = vim.lsp.buf.clear_references,
            })
            vim.api.nvim_create_autocmd("LspDetach", {
                group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
                callback = function(ev)
                    vim.lsp.buf.clear_references()
                    vim.api.nvim_clear_autocmds({ group = "lsp-highlight", buffer = ev.buf })
                end,
            })
        end
    end,
})

-- Diagnostic display
vim.diagnostic.config({
    severity_sort = true,
    float = { border = "rounded", source = "if_many" },
    underline = { severity = vim.diagnostic.severity.ERROR },
    signs = vim.g.have_nerd_font and {
        text = {
            [vim.diagnostic.severity.ERROR] = "󰅚 ",
            [vim.diagnostic.severity.WARN] = "󰀪 ",
            [vim.diagnostic.severity.INFO] = "󰋽 ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
        },
    } or {},
    virtual_text = { source = "if_many", spacing = 2 },
})

-- Broadcast blink.cmp capabilities and enable servers after VimEnter.
-- vim.schedule defers until after lazy.nvim's own VimEnter handler fires
-- (which loads blink.cmp), since autocmds.lua is sourced before lazy.lua
-- and our handler is therefore registered — and fires — first.
vim.api.nvim_create_autocmd("VimEnter", {
    once = true,
    callback = function()
        vim.schedule(function()
            vim.lsp.config("*", {
                capabilities = require("blink.cmp").get_lsp_capabilities(),
            })
            vim.lsp.enable({ "clangd", "pyright", "rust_analyzer", "vtsls", "lua_ls" })
        end)
    end,
})
