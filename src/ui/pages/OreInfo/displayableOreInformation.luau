local particleEmission = require(script.Parent.Parent.OreValidator.particleEmission)
local getDescendantsOfClass = require(script.Parent.Parent.Parent.Parent.util.getDescendantsOfClass)

return {
  {
    name = "Descendants",
    fn = function(ore)
      return `<b>{#ore:GetDescendants()}</b> (<i>{#ore:GetDescendants() + 1} Instances</i>)`
    end
  },
  {
    name = "Particle Emitters",
    fn = function(ore)
      return `<b>{#getDescendantsOfClass(ore, "ParticleEmitter")}</b>`
    end
  },
  {
    name = "Particles",
    fn = function(ore)
      local averageParticles = 0

      for _, particleEmitter in getDescendantsOfClass(ore, "ParticleEmitter") do
        if not particleEmitter.Enabled then continue end
        averageParticles += math.floor(particleEmission(particleEmitter))
      end

      return `<b>{averageParticles}</b> Particles/s`
    end
  },
  {
    name = "Attachments",
    fn = function(ore)
      return `<b>{#getDescendantsOfClass(ore, "Attachment")}</b>`
    end
  },
  {
    name = "Constraints",
    fn = function(ore)
      return `<b>{#getDescendantsOfClass(ore, "Constraint", "WeldConstraint")}</b>`
    end
  }
} :: {{
  name: string,
  fn: (ore: BasePart) -> string
}}