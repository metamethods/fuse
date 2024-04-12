local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Theme = require(Fuse.App.Theme)

local vide = require(Packages.vide)

local create = vide.create

local function Border(props: vide.vUIStroke): UIStroke
  return create "UIStroke" {
    Thickness = 1,
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Color = props.Color or Theme "Border",

    props
  }
end

return Border