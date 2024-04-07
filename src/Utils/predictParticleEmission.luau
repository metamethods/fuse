return function(particle: ParticleEmitter): number
  return (math.clamp(particle.Rate, 0, 500) * particle.TimeScale) * ((particle.Lifetime.Min + particle.Lifetime.Max) / 2)
end