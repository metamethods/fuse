local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes
local Utils = Fuse.Utils

local DescribableObject = require(Classes.DescribableObject)
local unconstraintedToPart = require(Utils.unconstraintedToPart)

return DescribableObject.new()
  :setName("Weld all parts to the ore")
  :setDescription(`Helps add all weld constraints to any part in the ore that isn't currently welded to the ore.`)
  :setObject(function(ore: BasePart)
    for _, instance in unconstraintedToPart(ore) do
      local weld = Instance.new("WeldConstraint")
      weld.Part0 = instance
      weld.Part1 = ore
      weld.Parent = instance
    end
  end)