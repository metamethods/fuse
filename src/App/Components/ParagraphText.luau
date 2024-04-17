local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Components = Fuse.App.Components

local Text = require(Components.Text)

local vide = require(Packages.vide)

local function ParagraphText(props: vide.vTextLabel): TextLabel
  return Text {
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    
    RichText = true,
    
    props
  }
end

return ParagraphText