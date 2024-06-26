local Modifier = require(script.Parent.Parent.Modifier)
local transformDescendantsColors = require(script.Parent.Parent.Parent.Parent.Parent.util.transformDescendantsColors)

return Modifier.define("Spectralize", "Spectralize your ore", function(ore: BasePart)
  transformDescendantsColors(ore, function(color)
    return Color3.new(color.G, 1 - color.R, 1 - color.B)
  end)

  ore:SetAttribute("Spectral", true)
  ore:SetAttribute("Ionized", nil)
end)