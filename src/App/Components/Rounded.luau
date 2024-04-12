local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local vide = require(Packages.vide)

local create = vide.create

local function Rounded(props: vide.vUICorner): UICorner
  return create "UICorner" {
    CornerRadius = UDim.new(0, 8),
    props
  }
end

return Rounded