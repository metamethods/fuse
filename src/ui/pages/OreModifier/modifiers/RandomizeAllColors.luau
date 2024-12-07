local Modifier = require(script.Parent.Parent.Modifier)
local transformDescendantsColors = require(script.Parent.Parent.Parent.Parent.Parent.util.transformDescendantsColors)

return Modifier.define("Randomize All Colors", "Randomizes all of the colors in your ore!", function(ore: BasePart)
	transformDescendantsColors(ore, function(_)
		local random = Random.new() -- OMG ITS RANDOM LIKE THE PERSON FROM REX NAMED KINGRANDOM!!1111
		return Color3.new(random:NextNumber(), random:NextNumber(), random:NextNumber())
	end)
end)
