local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes
local Utils = Fuse.Utils

local DescribableObject = require(Classes.DescribableObject)
local concatTruncate = require(Utils.concatTruncate)

return DescribableObject.new()
  :setName("Contains Anchored Descendants")
  :setDescription("Checks if the object contains any anchored descendants")
  :setObject(function(ore: BasePart)
    local affectedInstances = {}

    for _, instance in ore:GetDescendants() do
      if not instance:IsA("BasePart") then continue end
      if not instance.Anchored then continue end
      table.insert(affectedInstances, instance)
    end

    if #affectedInstances <= 0 then return true, "No anchored instances found" end
    return false, concatTruncate(affectedInstances, ", ", 20, function(part) return part:GetFullName() end)
  end)