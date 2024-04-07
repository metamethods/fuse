local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Components = App.Components

local Fusion = require(Packages.fusion)
local Text = require(Components.Text)
local HeaderText = require(Components.HeaderText)

local New = Fusion.New
local Computed = Fusion.Computed
local Children = Fusion.Children

export type HeaderProps = {
  ore: Fusion.Value<BasePart?>
}

return function(props: HeaderProps)
  return New "Frame" {
    Name = "Header",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 0 ,0),
    AutomaticSize = Enum.AutomaticSize.Y,

    [Children] = {
      New "UIListLayout" {
        Padding = UDim.new(0, 4),
        SortOrder = Enum.SortOrder.LayoutOrder,
      },

      HeaderText "Ore Fixer" {},
      Text "Welcome to the ore fixer, this is where you can easily fix your ore with minimal effort." {},
      HeaderText "Usage" {},
      Text "Its pretty simple, all you have to do is select the main <b>BasePart</b> (or <i>MeshPart</i>) of the Ore, then scroll to one of the fix functions below, and finally click the fix button." {},
      Text "" { 
        Text = Computed(function()
          local ore = props.ore:get()
          return ore
            and `Selected ore: {ore:GetFullName()}`
            or `No ore selected. Please select an ore to continue.`
        end),
        FontFace = Font.fromEnum(Enum.Font.GothamBlack)
      }
    }
  }
end