local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local vide = require(Packages.vide)

local create = vide.create

export type PaddingProps = {UDim}

local function Padding(PaddingProps): UIPadding
  assert(#PaddingProps >= 1, "Padding must have 1 argument")
  assert(#PaddingProps <= 4, "Padding cannot take more than 4 arguments")
  
  return create "UIPadding" {
    PaddingTop = PaddingProps[1],
    PaddingRight = PaddingProps[2] or PaddingProps[1],
    PaddingBottom = PaddingProps[3] or PaddingProps[1],
    PaddingLeft = PaddingProps[4] or PaddingProps[2] or PaddingProps[1]
  }
end

return Padding