local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Fusion = require(Packages.fusion)

local Header = require(script.Header)
local Tests = require(script.Tests)
local Actions = require(script.Actions)

local New = Fusion.New
local Children = Fusion.Children

export type ValidatorProps = {
  ore: Fusion.Value<BasePart?>
}

return function(props: ValidatorProps)
  local testsFunction, testComponent = Tests {
    ore = props.ore
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

      Header { ore = props.ore },
      Actions {
        ore = props.ore,
        onRunTestsClicked = testsFunction
      },
      testComponent
    }
  }
end