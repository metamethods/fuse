local Modifier = require(script.Parent.Parent.Modifier)
local transformDescendantsColors = require(script.Parent.Parent.Parent.Parent.Parent.util.transformDescendantsColors)

return Modifier.define("Rainbow", "Make your ore into a rainbow color", function(ore: BasePart)
  local hue = 0
  transformDescendantsColors(ore, function(color)
    local _, saturation, value = color:ToHSV()
    hue += 8
    return Color3.fromHSV((hue - 1) % 361 / 360, saturation, value)
  end)
end)