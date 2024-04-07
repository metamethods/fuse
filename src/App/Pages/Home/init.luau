local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Components = App.Components

local Fusion = require(Packages.fusion)
local HeaderText = require(Components.HeaderText)
local Text = require(Components.Text)
local ListLayout = require(Components.ListLayout)

local New = Fusion.New
local Children = Fusion.Children

export type HomeProps = {}

return function(props: HomeProps)
  return New "Frame" {
    Name = "Home",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),

    [Children] = {
      ListLayout(Enum.FillDirection.Vertical),

      HeaderText "Welcome to Fuse!" {},
      Text "Uhh placeholder text here, idk what to put here ngl" {}
    }
  }
end