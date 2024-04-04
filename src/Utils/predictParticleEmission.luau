return function(particle: ParticleEmitter): number
  return (particle.Rate * particle.TimeScale) * ((particle.Lifetime.Min + particle.Lifetime.Max) / 2)
end