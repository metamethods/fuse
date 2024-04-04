local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Fusion = require(Packages.fusion)

local New = Fusion.New

return function(size: UDim?)
  return New "UICorner" {
    CornerRadius = size or UDim.new(0, 4)
  }
end