local Fuse = script:FindFirstAncestor("Fuse")

local Components = Fuse.App.Components

local Button = require(Components.Button)
local Theme = require(Fuse.App.Theme)

local function PrimaryButton(props: Button.ButtonProps): TextButton
  return Button {
    BackgroundColor = Theme "Primary",
    TextColor = Theme "Text",

    Text = props.Text,
    Layout = props.Layout,
    Active = props.Active,
    Disabled = props.Disabled,
    clicked = props.clicked,
  }
end

return PrimaryButton