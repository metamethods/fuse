local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes
local Utils = Fuse.Utils

local DescribableObject = require(Classes.DescribableObject)
local concatTruncate = require(Utils.concatTruncate)
local unconstraintedToPart = require(Utils.unconstraintedToPart)

return DescribableObject.new()
  :setName("Descendants are Welded to the Core/Ore")
  :setDescription("Checks if all of the descendants of the ore are constrained to the core/ore.")
  :setObject(function(ore: BasePart)
    local unconstraintedParts = unconstraintedToPart(ore)

    if #unconstraintedParts <= 0 then return true, "All descendants are welded to the ore." end
    return false, `The following parts are not welded to the ore: {concatTruncate(unconstraintedParts, ", ", 20, function(part) return part:GetFullName() end)}`
  end)