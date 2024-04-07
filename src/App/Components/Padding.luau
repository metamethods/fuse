local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Fusion = require(Packages.fusion)

local New = Fusion.New

export type PaddingProps = (
  a: UDim?,
  b: UDim?,
  c: UDim?,
  d: UDim?
) -> ()

return function(a, b, c, d)
  return New "UIPadding" {
    PaddingTop = a,
    PaddingRight = b or a,
    PaddingBottom = c or a,
    PaddingLeft = d or b or a,
  }
end :: PaddingProps