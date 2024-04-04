local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Components = App.Components

local Fusion = require(Packages.fusion)
local PrimaryButton = require(Components.PrimaryButton)

local New  = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children

export type ActionsProps = {
  ore: Fusion.Value<BasePart??>,
  onRunTestsClicked: () -> ()
}

return function(props: ActionsProps)
  return New "Frame" {
    Name = "Actions",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      New "UIListLayout" {
        Padding = UDim.new(0, 8),
        FillDirection = Enum.FillDirection.Horizontal,
      },

      PrimaryButton {
        text = "Run Tests",

        disabled = Computed(function()
          return not props.ore:get()
        end),

        onClicked = props.onRunTestsClicked
      }
    }
  }
end