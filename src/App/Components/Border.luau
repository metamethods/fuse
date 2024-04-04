local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App

local Fusion = require(Packages.fusion)
local Theme = require(App.Theme)

local New = Fusion.New

return function(thickness: number, color: (Color3 | Fusion.Computed<Color3> | Fusion.Value<Color3>)?): UIStroke
  return New "UIStroke" {
    Thickness = thickness,
    Color = color or Theme "Border",
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
  }
end