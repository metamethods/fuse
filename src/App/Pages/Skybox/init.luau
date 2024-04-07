local Lighting = game:GetService("Lighting")

local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Components = App.Components

local Fusion = require(Packages.fusion)
local HeaderText = require(Components.HeaderText)
local Text = require(Components.Text)
local ListLayout = require(Components.ListLayout)
local Rounded = require(Components.Rounded)
local Border = require(Components.Border)
local Theme = require(App.Theme)

local New = Fusion.New
local ForPairs = Fusion.ForPairs
local OnEvent = Fusion.OnEvent
local Children = Fusion.Children

export type SkyboxProps = {}

-- TODO: Refactor later
return function(props: SkyboxProps)
  return New "ScrollingFrame" {
    Name = "Skybox",
    BackgroundTransparency = 1,
    Size = UDim2.new(1, 0, 1, 0),
    CanvasSize = UDim2.new(1, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    ScrollBarThickness = 0,

    [Children] = {
      ListLayout(Enum.FillDirection.Vertical, UDim.new(0, 8)),
      HeaderText "Welcome to the Skyboxes tab!" {},
      Text "This is where you can change your skybox to our presets shown below. Just click on one and done" {},

      New "Frame" {
        Name = "Skyboxes",
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,

        [Children] = {
          New "UIListLayout" {
            Wraps = true,
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 8)
          },

          ForPairs(script.Skyboxes:GetChildren(), function(i, skybox: Sky)
            return i, New "ImageButton" {
              Name = "Button",
              BackgroundColor3 = Theme "Background",
              Size = UDim2.new(.333, -8, 1, 0),

              Image = skybox.SkyboxBk,

              [OnEvent "MouseButton1Click"] = function()
                local originalSky = Lighting:FindFirstChildOfClass("Sky")
                if originalSky then originalSky:Destroy() end
                skybox:Clone().Parent = Lighting
              end,
    
              [Children] = {
                Rounded(),
                Border(1),
    
                New "UIAspectRatioConstraint" {
                  AspectRatio = 1,
                  DominantAxis = Enum.DominantAxis.Width
                },
              }
            }
          end, Fusion.cleanup)
        }
      }
    }
  }
end