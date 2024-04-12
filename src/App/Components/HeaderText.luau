local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Components = Fuse.App.Components

local Text = require(Components.Text)

local vide = require(Packages.vide)

local function HeaderText(props: vide.vTextLabel): TextLabel
  return Text {
    FontFace = Font.fromEnum(Enum.Font.GothamBold),

    TextSize = 24,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    
    RichText = true,
    
    props
  }
end

return HeaderText