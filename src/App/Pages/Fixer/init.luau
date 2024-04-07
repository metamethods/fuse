local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Components = App.Components

local Fusion = require(Packages.fusion)
local ListLayout = require(Components.ListLayout)

local Fixes = require(script.Fixes)
local Header = require(script.Header)

local New = Fusion.New
local Children = Fusion.Children

export type FixerProps = {
  ore: Fusion.Value<BasePart?>
}

return function(props: FixerProps)
  return New "ScrollingFrame" {
    Name = "OreFixer",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(1, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    ScrollBarThickness = 0,

    [Children] = {
      ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 8)),

      Header { ore = props.ore },
      Fixes { ore = props.ore }
    }
  }
end