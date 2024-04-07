local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes

local DescribableObject = require(Classes.DescribableObject)

return DescribableObject.new()
  :setName("Removes all welds (Not WeldConstraints)")
  :setDescription(`Helps remove all welds from the ore`)
  :setObject(function(ore: BasePart)
    for _, instance in ore:GetDescendants() do
      if not instance:IsA("Weld") then continue end
      instance:Destroy()
    end
  end)