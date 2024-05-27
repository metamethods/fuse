local Modifier = require(script.Parent.Parent.Modifier)

return Modifier.define("Randomize Size", "Randomizes all of the sizes of every single BasePart in your ore", function(ore: BasePart)
  for _, instance in ore:GetDescendants() do
    if not instance:IsA("BasePart") then continue end
    local random = Random.new()
    instance.Size = Vector3.new(random:NextNumber() * 10, random:NextNumber() * 10, random:NextNumber() * 10)
  end
end)