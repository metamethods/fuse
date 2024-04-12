local OreValidator = script:FindFirstAncestor("OreValidator")

local Test = require(OreValidator.Test)

return Test.new(
  "CanCollide & CanQuery",
  "Checks if the ore contains any parts with CanCollide enabled or Query enabled."
)
  :setTestFn(function(ore: BasePart)
    local affectedParts: {BasePart} = {}
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("BasePart") then continue end
      if instance.CanCollide or instance.CanQuery then
        table.insert(affectedParts, instance)
      end
    end
    if #affectedParts == 0 then return true, "This ore has no parts with CanCollide or CanQuery enabled." end
    return false, `This ore has {#affectedParts} parts with CanCollide or CanQuery enabled.`
  end)
  :setFixFn(function(ore: BasePart)
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("BasePart") then continue end
      instance.CanCollide = false
      instance.CanQuery = false
    end
  end)