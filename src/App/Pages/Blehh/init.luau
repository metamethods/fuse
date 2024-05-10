local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local vide = require(Packages.vide)

local create = vide.create

export type Props = {}

local function Page(props: Props): ImageLabel
  return create "ImageLabel" {
    Name = "Image",
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,

    Image = "rbxassetid://15003866942"
  }
end

return Page