local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App

local Fusion = require(Packages.fusion)
local Theme = require(App.Theme)

local New = Fusion.New
local ForPairs = Fusion.ForPairs
local OnEvent = Fusion.OnEvent
local Computed = Fusion.Computed
local Children = Fusion.Children

export type TabProps = {
  name: string,
  order: number,
  tabIndex: Fusion.Value<number>,
}

function Tab(props: TabProps)
  return New "TextButton" {
    Name = "Tab",
    BackgroundColor3 = Theme "Tab",
    Size = UDim2.new(0, 0, 1, 0),
    AutomaticSize = Enum.AutomaticSize.X,
    AutoButtonColor = true,

    Text = props.name,
    TextColor3 = Theme "Text",

    [OnEvent "MouseButton1Click"] = function()
      props.tabIndex:set(props.order)
    end,

    [Children] = {
      New "UIPadding" {
        PaddingLeft = UDim.new(0, 10),
        PaddingRight = UDim.new(0, 10)
      },
      New "Frame" {
        Name = "Ribbon",
        BackgroundColor3 = Theme "RibbonTabTopBar",
        Size = UDim2.new(1, 20, 0, 2),
        Position = UDim2.new(.5, 0, 0, 0),
        AnchorPoint = Vector2.new(.5, 0),
        Visible = Computed(function()
          return props.tabIndex:get() == props.order
        end)
      }
    }
  }
end

export type Tab = {
  name: string,
  order: number
}

export type TabsProps = {
  tabs: {Tab},
  tabIndex: Fusion.Value<number>,

  height: number?,
}

return function(props: TabsProps)
  return New "ScrollingFrame" {
    Name = "Tabs",
    BackgroundColor3 = Theme "TabBar",
    Size = UDim2.new(1, 0, 0, props.height or 30),
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.X,

    ScrollBarThickness = 0,

    [Children] = {
      New "UIListLayout" {
        SortOrder = Enum.SortOrder.LayoutOrder,
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
      },
      ForPairs(props.tabs, function(i, tab)
        return i, Tab {
          name = tab.name,
          order = tab.order,
          tabIndex = props.tabIndex,
        }
      end, Fusion.Cleanup)
    }
  }
end