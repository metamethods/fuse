local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Hooks = App.Hooks

local Fusion = require(Packages.fusion)
local useOre = require(Hooks.useOre)

local Header = require(script.Header)
local Tests = require(script.Tests)
local Actions = require(script.Actions)

local New = Fusion.New
local Children = Fusion.Children

return function()
  local ore = useOre()
  local testsFunction, testComponent = Tests {
    ore = ore
  }

  return New "ScrollingFrame" {
    Name = "OreValidator",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(1, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    ScrollBarThickness = 0,

    [Children] = {
      New "UIListLayout" {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
      },

      Header { ore = ore },
      Actions {
        ore = ore,
        onRunTestsClicked = testsFunction
      },
      testComponent
    }
  }
end