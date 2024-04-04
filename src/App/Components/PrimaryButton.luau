local Fuse = script:FindFirstAncestor("Fuse")

local App = Fuse.App
local Components = App.Components
local Utils = Fuse.Utils

local Button = require(Components.Button)
local Theme = require(App.Theme)
local merge = require(Utils.merge)

return function(props: Button.ButtonProps): TextButton
  return Button(merge(
    {
      backgroundColor = Theme "Primary",
      textColor = Color3.new(1, 1, 1),
      overlayColor = Color3.new(1, 1, 1),
      noBorder = true,
      overlayHoverTransparency = .8,
    } :: Button.ButtonProps,
    props
  ))
end