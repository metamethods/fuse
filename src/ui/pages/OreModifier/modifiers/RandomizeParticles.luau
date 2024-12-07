local Modifier = require(script.Parent.Parent.Modifier)

return Modifier.define(
	"Randomize Particles",
	"Randomizes the lifetime and rate values for all particle emitters in your ore",
	function(ore: BasePart)
		local instances = ore:GetDescendants()
		table.insert(instances, ore)
		for _, instance in instances do
			if not instance:IsA("ParticleEmitter") then
				continue
			end
			local random = Random.new()
			local min = random:NextNumber() * 20
			local max = random:NextNumber() * (20 - min) + min
			instance.Lifetime = NumberRange.new(min, max)
			instance.Rate = random:NextNumber() * 500
		end
	end
)
