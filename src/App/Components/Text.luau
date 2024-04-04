local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Utils = Fuse.Utils
local App = Fuse.App

local Fusion = require(Packages.fusion)
local merge = require(Utils.merge)
local Theme = require(App.Theme)

local New = Fusion.New

export type TextProps = {[any]: any}

return function(text: string): (props: TextProps) -> TextLabel
  return function(props: TextProps)
    return New("TextLabel")(merge(
      {
        AutomaticSize = Enum.AutomaticSize.XY,

        BackgroundTransparency = 1,
        TextSize = 14,
        Font = Enum.Font.Gotham,
        Text = text,
        TextColor3 = Theme "Text",
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = true,
      },
      props
    ))
  end
end