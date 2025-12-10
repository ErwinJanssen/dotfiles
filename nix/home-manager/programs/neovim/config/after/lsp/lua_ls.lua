return {
    settings = {
        Lua = {
            diagnostics = {
                globals = {
                    -- Suppress "Undefined global `vim`" error
                    "vim",
                },
            },
        },
    },
}
