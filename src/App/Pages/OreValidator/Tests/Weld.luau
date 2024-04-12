local OreValidator = script:FindFirstAncestor("OreValidator")

local Test = require(OreValidator.Test)

return Test.new(
  "Weld",
  "Checks if Weld instances exist in your ore"
)
  :setTestFn(function(ore: BasePart)
    local welds: {Weld} = {}
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("Weld") then continue end
      table.insert(welds, instance)
    end
    
    if #welds == 0 then return true, "There were no weld instances found in your ore!" end
    return false, `There are {#welds} welds in your ore.`
  end)
  :setFixFn(function(ore: BasePart)
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("Weld") then continue end
      instance:Destroy()
    end
  end)