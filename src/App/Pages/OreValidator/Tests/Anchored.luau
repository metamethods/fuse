local OreValidator = script:FindFirstAncestor("OreValidator")

local Test = require(OreValidator.Test)

return Test.new(
  "Anchored Descendants",
  "Checks if there are any anchored descendants within the ore."
)
  :setTestFn(function(ore: BasePart)
    local anchoredParts: {BasePart} = {}
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("BasePart") then continue end
      if instance.Anchored then
        table.insert(anchoredParts, instance)
      end
    end
    if #anchoredParts == 0 then return true, "This ore has no anchored descendants." end
    return false, `This ore has {#anchoredParts} anchored descendants.`
  end)
  :setFixFn(function(ore: BasePart)
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("BasePart") then continue end
      instance.Anchored = false
    end
  end)