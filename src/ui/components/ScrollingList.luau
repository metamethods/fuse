local List = require(script.Parent.List)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local types = require(script.Parent.Parent.Parent.types)

export type ScrollingListProps = {
  layout: vide.vScrollingFrame?,
  listLayout: vide.vUIListLayout?,
  direction: ("Vertical" | "Horizontal")?,

  children: types.Components
}

local function ScrollingList(props: ScrollingListProps): ScrollingFrame
  return vide.create "ScrollingFrame" {
    Name = "ScrollingList",
    BackgroundTransparency = 1,
    Size = UDim2.fromScale(1, 1),
    CanvasSize = UDim2.fromScale(0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize[props.direction == "Horizontal" and "X" or "Y"],
    ScrollBarThickness = 0,
    ScrollingDirection = Enum.ScrollingDirection[props.direction == "Horizontal" and "X" or "Y"],
    
    List {
      layout = props.listLayout,
      direction = props.direction,
    },

    props.children,
    props.layout
  }
end

return ScrollingList