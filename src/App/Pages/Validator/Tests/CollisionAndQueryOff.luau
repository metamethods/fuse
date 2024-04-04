local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes
local Utils = Fuse.Utils

local DescribableObject = require(Classes.DescribableObject)
local concatTruncate = require(Utils.concatTruncate)

return DescribableObject.new()
  :setName("All Descendants Have CanCollide & CanQuery Off")
  :setDescription(`Checks if all of the descendants of the object have CanCollide and CanQuery off.`)
  :setObject(function(ore: BasePart)
    local affectedInstances = {}
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("BasePart") then continue end
      if instance.CanCollide or instance.CanQuery then
        table.insert(affectedInstances, instance)
      end
    end
    if #affectedInstances <= 0 then return true, `All descendants have CanCollide and CanQuery off.` end
    return false, `The following instances have CanCollide and/or CanQuery on: {concatTruncate(affectedInstances, ", ", 20, function(part) return part:GetFullName() end)}`
  end)