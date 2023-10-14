return {
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require("tokyonight").setup({
                -- use the night style
                style = "night",
                -- disable italic for functions
                styles = {
                    comments = { italic = true },
                    keywords = { italic = true },
                    functions = {},
                    variables = {},
                },
                terminal_colors = true,
                sidebars = { "qf", "vista_kind", "terminal", "packer" },
                on_colors = function(colors)
                    colors.black = "#000000"
                    colors.nearly_black = "#080808"
                    colors.charcoal = "#111111"
                    colors.blue = "#0099FF"
                    colors.cyan = "#0AF7EF"
                    colors.gray = "#666666"
                    colors.green = "#00FF00"
                    colors.purple = "#AA00AA"
                    colors.teal = colors.cyan
                    colors.red = "#FF0033"
                    colors.yellow = "#FFFF00"
                    colors.white = "#FFFFFF"
                    colors.bg = colors.charcoal
                    colors.fg = colors.white
                    colors.border = colors.purple
                end,
                on_highlights = function(highlights, colors)
                    highlights["DiagnosticUnnecessary"] = { fg = colors.gray }
                    highlights["@keyword.function"] = { fg = colors.yellow, italic = true }
                    highlights["@parameter"] = { fg = colors.yellow }
                    highlights["@property"] = { fg = colors.orange }
                    highlights["@string.regex"] = { fg = colors.orange }
                    highlights["@type.builtin"] = { fg = colors.green }
                    highlights["@keyword"] = { fg = colors.green }
                    highlights["@string"] = { fg = colors.blue }
                    highlights["@comments"] = { fg = colors.gray }
                    highlights["@number"] = { fg = colors.orange }
                    highlights["@type.definition"] = { fg = colors.red }
                end,
            })
            vim.cmd([[colorscheme tokyonight]])
        end,
    },
}
