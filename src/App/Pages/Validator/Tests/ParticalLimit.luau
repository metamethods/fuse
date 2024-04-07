local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes
local Utils = Fuse.Utils

local DescribableObject = require(Classes.DescribableObject)
local predictParticleEmission = require(Utils.predictParticleEmission)

-- The limit is 16k, however one of the developers said that if two times of the predicted
-- particle emission is greater than 16k, them it would be considered invalid.
-- Thus I changed the limit to 8k as that would be the maximum amount of particles
-- a ore can have
local PARTICLE_LIMIT = 8_000
local PARTICLE_LIMIT_WARNING = 4_000

return DescribableObject.new()
  :setName("Ore Particle Limit")
  :setDescription(`Checks if the ore emits more than <b>{PARTICLE_LIMIT} particles.</b>`)
  :setObject(function(ore: BasePart)
    local particleEmitters = {}
    for _, instance in ore:GetDescendants() do
      if instance:IsA("ParticleEmitter") then table.insert(particleEmitters, instance) end
    end

    local total = 0
    for _, particleEmitter in particleEmitters do
      total += predictParticleEmission(particleEmitter)
    end
    total = math.floor(total)

    if total > PARTICLE_LIMIT then return false, `This ore emits <b>{total - PARTICLE_LIMIT} particles/s</b> more than the {PARTICLE_LIMIT} particle/s limit.` end
    if total > PARTICLE_LIMIT_WARNING then return true, `This ore emits <b>{total} particles/s</b>, which is in the <b>non recomended range of particle emission</b> (<b>{PARTICLE_LIMIT_WARNING} particles/s</b>). Do note that this ore has a <b><i>high</i></b> chance of being <b>rejected</b> for this high count.` end
    return true, `This ore emits currently emits {total} particles/s on average, which is well under the {PARTICLE_LIMIT} particles/s limit.`
  end)