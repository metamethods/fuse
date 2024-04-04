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

      HeaderText "Ore Validator" {},
      Text "Welcome to the ore validator! This is where you can check if your ore is valid, in which it can be uploaded for a submission to REx: Reincarnated. Though, if you are an Ore Curator, you can use this to see if people's submissions are valid" {},
      HeaderText "Usage" {},
      Text "Its pretty simple, all you have to do is select the main <b>BasePart</b> (or <i>MeshPart</i>) of the Ore, and then click the button \"Run Tests\"." {},
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