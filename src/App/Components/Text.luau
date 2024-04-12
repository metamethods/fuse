local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Theme = require(Fuse.App.Theme)

local vide = require(Packages.vide)

local create = vide.create

local function Text(props: vide.vTextLabel): TextLabel
  return create "TextLabel" {
    Name = "Text",
    BackgroundTransparency = 1,
    AutomaticSize = Enum.AutomaticSize.XY,

    TextColor3 = props.TextColor3 or Theme "Text",
    TextSize = 18,
    FontFace = Font.fromEnum(Enum.Font.Gotham),

    props
  }
end

return Text