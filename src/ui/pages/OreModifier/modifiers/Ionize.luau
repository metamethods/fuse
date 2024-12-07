local Modifier = require(script.Parent.Parent.Modifier)
local transformDescendantsColors = require(script.Parent.Parent.Parent.Parent.Parent.util.transformDescendantsColors)

return Modifier.define("Ionize", "Ionize your ore", function(ore: BasePart)
	transformDescendantsColors(ore, function(color)
		return Color3.new(1 - color.B, 1 - color.R, 1 - color.G)
	end)

	ore:SetAttribute("Spectral", nil)
	ore:SetAttribute("Ionized", true)
end)
