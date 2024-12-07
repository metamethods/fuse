local particleEmission = require(script.Parent.Parent.particleEmission)
local Test = require(script.Parent.Parent.Test)

local PARTICLE_LIMIT = 8_000

return Test.define(
	`Average Particles < {PARTICLE_LIMIT}`,
	`Checks if your ore is under {PARTICLE_LIMIT} particles on average`,
	function(ore)
		local averageTotal = 0

		for _, instance in ore:GetDescendants() do
			if not instance:IsA("ParticleEmitter") or not instance.Enabled then
				continue
			end
			averageTotal += math.floor(particleEmission(instance))
		end

		if averageTotal > PARTICLE_LIMIT then
			return Test.fail(
				`The ore is emitting <b>{averageTotal} particles on average</b>, which is over the limit of <b>{PARTICLE_LIMIT} particles</b>`
			)
		elseif averageTotal > PARTICLE_LIMIT / 2 then
			return Test.warn(
				`The ore is emitting <b>{averageTotal} particles on average</b>, its recommended to optimize the ore to keep it under <b>{PARTICLE_LIMIT / 2} particles</b>`
			)
		else
			return Test.ok(
				`The ore is emitting <b>{averageTotal} particles on average</b> which is well under the limit of <b>{PARTICLE_LIMIT} particles</b>`
			)
		end
	end
)
