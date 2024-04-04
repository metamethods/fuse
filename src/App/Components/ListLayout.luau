local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Fusion = require(Packages.fusion)

local New = Fusion.New

return function(direction: Enum.FillDirection, spacing: UDim?, sortOrder: Enum.SortOrder?): UIListLayout
  return New "UIListLayout" {
    FillDirection = direction,
    SortOrder = sortOrder or Enum.SortOrder.LayoutOrder,
    Padding = spacing or UDim.new(0, 0),
  }
end