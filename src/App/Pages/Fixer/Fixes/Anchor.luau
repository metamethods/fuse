local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes

local DescribableObject = require(Classes.DescribableObject)

return DescribableObject.new()
  :setName("Disable descendant's anchor properties")
  :setDescription(`Disables the anchor property of all descendants of the ore.`)
  :setObject(function(ore: BasePart)
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("BasePart") then continue end
      instance.Anchored = false
    end
  end)