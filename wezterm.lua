local wezterm = require 'wezterm';
local scheme = wezterm.get_builtin_color_schemes()["OneHalfDark"]
scheme.brights[1] = "#5c6370"

return {
  font_size = 10.0,
  font = wezterm.font_with_fallback({ {
    family = "JuliaMono",
    weight = "Medium",
    harfbuzz_features = {
      "aalt=0", --	Access All Alternates
      "afrc=0", --	Alternative Fractions
      "c2sc=0", --	Small Capitals From Capitals
      "calt=0", --	Contextual Alternates
      "case=0", --	Case-Sensitive Forms
      "ccmp=0", --	Glyph Composition/Decomposition
      "dlig=0", --	Discretionary Ligatures
      "dnom=0", --	Denominators
      "frac=0", --	Fractions
      "fwid=0", --	Full Widths
      "hlig=0", --	Historical Ligatures
      "hwid=0", --	Half Widths
      "lnum=0", --	Lining Figures
      "mark=0", --	Mark Positioning
      "mkmk=0", --	Mark to Mark Positioning
      "numr=0", --	Numerators
      "onum=0", --	Oldstyle Figures
      "ordn=0", --	Ordinals
      "pnum=0", --	Proportional Figures
      "sinf=0", --	Scientific Inferiors
      "smcp=0", --	Small Capitals
      "ss01=0", --	Stylistic Set 1
      "ss02=0", --	Stylistic Set 2
      "ss03=0", --	Stylistic Set 3
      "ss04=0", --	Stylistic Set 4
      "ss05=0", --	Stylistic Set 5
      "ss06=0", --	Stylistic Set 6
      "ss07=0", --	Stylistic Set 7
      "ss08=0", --	Stylistic Set 8
      "ss09=0", --	Stylistic Set 9
      "ss10=0", --	Stylistic Set 10
      "ss11=0", --	Stylistic Set 11
      "ss12=0", --	Stylistic Set 12
      "ss13=0", --	Stylistic Set 13
      "ss14=0", --	Stylistic Set 14
      "ss15=0", --	Stylistic Set 15
      "ss20=0", --	Stylistic Set 20
      "subs=0", --	Subscript
      "sups=0", --	Superscript
      "tnum=0", --	Tabular Figures
      "vert=0", --	Vertical Writing
      "vrt2=0", --	Vertical Alternates and Rotation
      "zero=1", --	Slashed Zero
      "agilr034679~@$%&*(){}[]|𝒜ℬ𝒞", -- example
      "<= >= >= =< == != !== /= >>= .- :- .= {. .} ", -- example
    },
  }, "WenQuanYi Micro Hei Mono" }),
  -- color_scheme = "Andromeda",
  color_schemes = {
    -- Override the builtin Gruvbox Light scheme with our modification.
    ["OneDarkModified"] = scheme,
  },
  color_scheme = "OneDarkModified",
  -- color_scheme = "Seafoam Pastel",
  initial_cols = 120,
  initial_rows = 36,
  check_for_updates = false,
  audible_bell = "Disabled",
}
