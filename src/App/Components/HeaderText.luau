local Fuse = script:FindFirstAncestor("Fuse")

local Utils = Fuse.Utils
local App = Fuse.App
local Components = App.Components

local Text = require(Components.Text)
local merge = require(Utils.merge)

return function(text: string): (props: Text.TextProps) -> TextLabel
  return function(props: Text.TextProps)
    return Text(text)(merge(
      {
        FontFace = Font.fromEnum(Enum.Font.GothamMedium),
        TextSize = 18
      },
      props
    ))
  end
end