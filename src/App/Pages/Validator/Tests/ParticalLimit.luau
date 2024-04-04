local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes
local Utils = Fuse.Utils

local DescribableObject = require(Classes.DescribableObject)
local predictParticleEmission = require(Utils.predictParticleEmission)

local PARTICLE_LIMIT = 16_000

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

    if total > PARTICLE_LIMIT then return false, `This ore emits {total - PARTICLE_LIMIT} particles/s more than the {PARTICLE_LIMIT} particle/s limit.` end
    return true, `This ore emits currently emits {total} particles/s on average, which is well under the {PARTICLE_LIMIT} particles/s limit.`
  end)