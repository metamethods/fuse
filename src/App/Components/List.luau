local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local vide = require(Packages.vide)

local create = vide.create

export type ListProps = {
  ListLayout: vide.vUIListLayout?,
  Layout: vide.vFrame?,
  Children: {Instance} | () -> {Instance}
}

local function List(props: ListProps): Frame
  return create "Frame" {
    Name = "List",
    BackgroundTransparency = 1,

    props.Layout,
    props.Children,

    create "UIListLayout" {
      SortOrder = Enum.SortOrder.LayoutOrder,

      props.ListLayout
    }
  }
end

return List