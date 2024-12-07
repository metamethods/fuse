local types = require(script.Parent.Parent.Parent.Parent.types)

local Modifier = {}

function Modifier.define(title: string, description: string, fn: (ore: BasePart) -> ()): types.ModifierDefinition
	return {
		title = title,
		description = description,
		fn = fn,
	}
end

return Modifier
