local Modifier = require(script.Parent.Parent.Modifier)

return Modifier.define(
	"Randomize Size",
	"Randomizes all of the sizes of every single BasePart in your ore",
	function(ore: BasePart)
		local instances = ore:GetDescendants()
		table.insert(instances, ore)
		for _, instance in instances do
			if not instance:IsA("BasePart") then
				continue
			end
			local random = Random.new()
			instance.Size = Vector3.new(random:NextNumber() * 10, random:NextNumber() * 10, random:NextNumber() * 10)
		end
	end
)
