local Modifier = require(script.Parent.Parent.Modifier)
local transformDescendantsColors = require(script.Parent.Parent.Parent.Parent.Parent.util.transformDescendantsColors)

return Modifier.define("Randomize Color", "Picks a random color for your ore", function(ore: BasePart)
  local random = Random.new() -- OMG ITS RANDOM LIKE THE PERSON FROM REX NAMED KINGRANDOM!!1111
  local color = Color3.new(random:NextNumber(), random:NextNumber(), random:NextNumber())
  
  transformDescendantsColors(ore, function() return color end)
end)