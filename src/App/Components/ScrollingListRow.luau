local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Components = Fuse.App.Components

local ScrollingFrame = require(Components.ScrollingFrame)
local Padding = require(Components.Padding)
local List = require(Components.List)

local vide = require(Packages.vide)

export type ScrollingListRowProps = {
  Layout: vide.vScrollingFrame?,
  Padding: {UDim}?,
  Children: {Instance} | () -> {Instance}
}

local function ScrollingListRow(props: ScrollingListRowProps): ScrollingFrame
  return ScrollingFrame {
    Size = UDim2.fromScale(1, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.X,

    props.Layout,

    Padding { 
      props.Padding 
        and table.unpack(props.Padding) 
        or UDim.new(0, 8)
    },

    List {
      Layout = {
        Size = UDim2.fromScale(1, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
      },
      ListLayout = {
        Padding = UDim.new(0, 8),
        FillDirection = Enum.FillDirection.Horizontal
      },
      Children = props.Children
    }
  }
end

return ScrollingListRow