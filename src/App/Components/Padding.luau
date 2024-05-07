local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local vide = require(Packages.vide)

local create = vide.create

export type PaddingProps = {UDim}

local function Padding(padding: PaddingProps): UIPadding
  assert(#padding >= 1, "Padding must have 1 argument")
  assert(#padding <= 4, "Padding cannot take more than 4 arguments")
  
  return create "UIPadding" {
    PaddingTop = padding[1],
    PaddingRight = padding[2] or padding[1],
    PaddingBottom = padding[3] or padding[1],
    PaddingLeft = padding[4] or padding[2] or padding[1]
  }
end

return Padding