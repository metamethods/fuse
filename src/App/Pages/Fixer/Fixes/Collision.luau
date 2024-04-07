local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes

local DescribableObject = require(Classes.DescribableObject)

return DescribableObject.new()
  :setName("Disables CanCollide & CanQuery on all of the descendants")
  :setDescription(`Disables the properties CanCollide & CanQuery on all of the ore's descendants`)
  :setObject(function(ore: BasePart)
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("BasePart") then continue end
      instance.CanCollide = false
      instance.CanQuery = false
    end
  end)