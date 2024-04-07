local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes
local Utils = Fuse.Utils

local DescribableObject = require(Classes.DescribableObject)
local concatTruncate = require(Utils.concatTruncate)

return DescribableObject.new()
  :setName("Weld Checker")
  :setDescription(`Checks if there are any welds in the ore (Not weld constraints)`)
  :setObject(function(ore: BasePart)
    local welds = {}
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("Weld") then continue end
      table.insert(welds, instance)
    end
    if #welds <= 0 then return true, "This ore contains no weld instances!" end
    return false, `This ore contains {#welds} welds. Please remove them via going to the "Ore Fixer" tab. Affected instances: {concatTruncate(welds, ", ", 20, function(instance) return instance:GetFullName() end)}`
  end)