return {
  -- catppuccin
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin-latte",
    },
  },
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000, -- ensure it loads before everything else
    name = "catppuccin",
    opts = {
      color_overrides = {
        latte = {
          -- flamingo, sapphire, overlay1 also are pre-built usable choices
          base = "#ffffff",
          mantle = "#ffffff",
          crust = "#f2f2f2",
        },
      },
      highlight_overrides = {
        -- Increase contrast, which is not enough by default:
        latte = function(colors)
          return {
            ["@property"]                 = { fg = "#ff0000" },
            ["@property.css"]             = { fg = "#ff0000" }, -- CSS properties - sky blue
            ["@property.class.css"]       = { fg = "#D000ED" }, -- Tag attribute - blue
            ["@property.id.css"]          = { fg = "#2DC427" }, -- Tag attribute - blue
            ["@tag.attribute"]            = { fg = "#D000ED" }, -- Tag attribute - blue

            ["@keyword.conditional"]      = { fg = "#2DC427" },
            ["@keyword.repeat"]           = { fg = "#005CFF" },
            ["@keyword.function"]         = { fg = "#D000ED" },
            ["@keyword.import"]           = { fg = "#D000ED" },
            ["@keyword.export"]           = { fg = "#2DC427" },
            ["@keyword.return"]           = { fg = "#D000ED" },
            ["@keyword.operator"]         = { fg = "#8c8fa1" },
            ["@keyword"]                  = { fg = "#C7B700" },
            ["type"]                      = { fg = "#fe640b" },

            ["@boolean"]                  = { fg = "#2DC427" },
            ["@namespace"]                = { fg = "#fe640b" },
            ["@float"]                    = { fg = "#D000ED" },
            ["@lsp.type.method"]          = { fg = "#dd7878" },
            ["@variable.parameter"]       = { fg = "#209fb5" },
            ["@number"]                   = { fg = "#D000ED" },
            ["@string"]                   = { fg = "#000000" },
            ["@comment"]                  = { fg = "#8c8fa1", italic = true },
            FlashLabel                    = { bg = "#000000", fg = "#ffffff" },
            Substitute                    = { bg = colors.crust },
            MatchParen                    = { fg = "#000000", bg = "#C9EAFF" },
            LspReferenceText              = { bg = colors.crust },
            LspReferenceRead              = { bg = colors.crust },
            LspReferenceWrite             = { bg = colors.crust },
            LspSignatureActiveParameter   = { bg = colors.crust },
            IncSearch                     = { bg = "#FFD1FE", fg = "#000000" },
            CurSearch                     = { bg = "#C9EAFF", fg = "#000000" },
            Search                        = { bg = "#f8fcc0", fg = "#000000" },
            Visual                        = { bg = "none", undercurl = true, sp = "#FFADAD" },
            VisualNOS                     = { bg = "none", undercurl = true, sp = "#FFADAD" },
            SnacksPickerListCursorLine    = { bg = "none", bold = true, undercurl = true, sp = "#FFADAD" },
            SnacksPickerPreviewCursorLine = { bg = "none", bold = true, undercurl = true, sp = "#FFADAD" },
            AerialLine                    = { fg = "none", bg = "none", bold = true, undercurl = true, sp = "#FF7D7D" },
            NeoTreeCursorLine             = { bg = "none", bold = true, undercurl = true, sp = "#FF7D7D" },
            NeoTreeIndentMarker           = { fg = "#E61E00" },
            NeoTreeWinSeparator           = { fg = "#000000", bg = "NONE" },
            ["DiagnosticDeprecated"]      = { cterm = { underline = true }, sp = "#590008", underline = true },
          }
        end,
      },
      lsp_styles = {
        underlines = {
          errors = { "italic" },
          IncSearch = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
      },
    },
  },
}
