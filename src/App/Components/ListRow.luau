local Fuse = script:FindFirstAncestor("Fuse")

local Components = Fuse.App.Components

local List = require(Components.List)

local function ListRow(props: List.ListProps): Frame
  return List {
    ListLayout = {
      FillDirection = Enum.FillDirection.Horizontal,
      Padding = UDim.new(0, 8),

      props.ListLayout
    },
    Layout = {
      Size = UDim2.fromScale(1, 0),
      AutomaticSize = Enum.AutomaticSize.Y,

      props.Layout
    },
    Children = props.Children
  }
end

return ListRow