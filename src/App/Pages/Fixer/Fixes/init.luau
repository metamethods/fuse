local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Classes = Fuse.Classes
local Components = App.Components

local Fusion = require(Packages.fusion)
local DescribableObject = require(Classes.DescribableObject)
local Types = require(Fuse.Types)
local HeaderText = require(Components.HeaderText)
local Text = require(Components.Text)
local ListLayout = require(Components.ListLayout)
local Padding = require(Components.Padding)
local PrimaryButton = require(Components.PrimaryButton)
local Rounded = require(Components.Rounded)
local Border = require(Components.Border)
local Theme = require(App.Theme)

local New = Fusion.New
local ForPairs = Fusion.ForPairs
local Computed = Fusion.Computed
local Children = Fusion.Children

export type FixActionsProps = {
  ore: Fusion.Value<BasePart?>,
  fixObject: DescribableObject.DescribableObject<Types.FixFunction>
}

function FixActions(props: FixActionsProps)
  return New "Frame" {
    Name = "Actions",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      ListLayout(Enum.FillDirection.Horizontal, UDim.new(0, 8)),
     PrimaryButton {
      text = "Run",
      disabled = Computed(function() return not props.ore:get() end),
      onClicked = function()
        local ore = props.ore:get()
        if not ore then return end
        props.fixObject.object(ore)
      end
     }
    }
  }
end

export type FixProps = {
  ore: Fusion.Value<BasePart?>,
  fixObject: DescribableObject.DescribableObject<Types.FixFunction>
}

function Fix(props: FixProps)
  return New "Frame" {
    Name = "Fix",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 8)),

      New "Frame" {
        Name = "FixBody",
        BackgroundColor3 = Theme "Background",
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,

        [Children] = {
          ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 4)),
          Rounded(),
          Border(1),
          Padding(UDim.new(0, 8)),

          HeaderText "" { Text = props.fixObject.name },
          Text "" { Text = props.fixObject.description }
        }
      },
      FixActions {
        ore = props.ore,
        fixObject = props.fixObject
      }
    }
  }
end

export type FixesProps = {
  ore: Fusion.Value<BasePart?>
}

return function(props: FixesProps)
  return New "Frame" {
    Name = "Fixes",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 8)),
      ForPairs(script:GetChildren(), function(i, fixModule: ModuleScript)
        return i, Fix {
          ore = props.ore,
          fixObject = require(fixModule)
        }
      end, Fusion.cleanup)
    }
  }
end