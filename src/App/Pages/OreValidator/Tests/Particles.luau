local OreValidator = script:FindFirstAncestor("OreValidator")

local Test = require(OreValidator.Test)

local PARTICLE_LIMIT = 8_000
local PARTICLE_WARNING_LIMIT = 4_000

function predictParticleEmission(emitter: ParticleEmitter): number
  return (math.clamp(emitter.Rate, 0, 500) * emitter.TimeScale) * ((emitter.Lifetime.Min + emitter.Lifetime.Max) / 2)
end

return Test.new(
  "Particles",
  `Checks if your ore is under {PARTICLE_LIMIT} particles/s`
)
  :setTestFn(function(ore: BasePart)
    local total = 0
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("ParticleEmitter") or not instance.Enabled then continue end
      total += math.round(predictParticleEmission(instance))
    end

    if total > PARTICLE_LIMIT then return false, `This ore emits {total - PARTICLE_LIMIT} particles/s on average over the {PARTICLE_LIMIT} particles/s limit. You MUST reduce this, or it will not get accepted.` end
    if total > PARTICLE_WARNING_LIMIT then return false, `This ore emits {total} particles/s on average. Even though it is less than the {PARTICLE_LIMIT} particles/s limit, it still has a high chance of not be accepted as an ore in REx: Reincarnated. Please reduce this value` end
    return true, `This ore currently emits {total} particles/s on average, which is under the {PARTICLE_LIMIT} particles/s limit.`
  end)