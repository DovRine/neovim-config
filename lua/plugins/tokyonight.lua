return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            style = "night",      -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            light_style = "day",  -- The theme is used when the background is set to light
            transparent = false,  -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                comments = { italic = true },
                keywords = { italic = true },
                functions = {},
                variables = {},
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "dark",          -- style for sidebars, see below
                floats = "dark",            -- style for floating windows
            },
            sidebars = { "qf", "help" },    -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
            day_brightness = 0.3,           -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
            hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
            dim_inactive = false,           -- dims inactive windows
            lualine_bold = false,           -- When `true`, section headers in the lualine theme will be bold

            --- You can override specific color groups to use other groups or a hex color
            --- function will be called with a ColorScheme table
            ---@param colors table<string, string>
            on_colors = function(colors)
                colors.bg = "#111111"
                colors.yellow = "#F4EEA6"
                colors.purple = "#C700FC"
                colors.pink = "#F4A6E5"
                colors.dodgerblue = "#18B5FF"
                colors.green = "#02FA00"
                colors.white = "#ffffff"
                colors.red = "#ff0000"
                colors.silver = "#888888"
            end,

            --- You can override specific highlights to use other groups or a hex color
            --- function will be called with a Highlights and ColorScheme table
            ---@param highlights table<string, table<string, string>>
            ---@param colors table<string, string>
            on_highlights = function(highlights, colors)
                highlights.Function = { fg = colors.yellow }
                highlights.String = { fg = colors.pink }
                highlights.Number = { fg = colors.dodgerblue }
                highlights.Identifier = { fg = colors.green }
                highlights.Statement = { fg = colors.purple }
                highlights.Operator = { fg = colors.dodgerblue }
                highlights.Type = { fg = colors.red }
                highlights.Exception = { fg = colors.red }
                -- highlights.Character = { fg = colors.white }
                -- highlights.Keyword = { fg = colors.dodgerblue }
                highlights.Comment = { fg = colors.silver }
                highlights.Directory = { fg = colors.yellow }
                highlights.LspDiagnosticsUnused = { fg = colors.silver }
                highlights.DiagnosticUnnecessary = { fg = colors.silver }
            end,
        })
        vim.cmd('colorscheme tokyonight')
    end,
}
