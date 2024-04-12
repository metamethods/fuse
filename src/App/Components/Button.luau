local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Components = Fuse.App.Components

local Text = require(Components.Text)
local Padding = require(Components.Padding)
local Rounded = require(Components.Rounded)
local Border = require(Components.Border)
local Theme = require(Fuse.App.Theme)

local vide = require(Packages.vide)

local create = vide.create
local source = vide.source
local spring = vide.spring

export type ButtonProps = {
  Text: string | () -> string,
  BackgroundColor: (() -> Color3)?,
  TextColor: (() -> Color3)?,

  Layout: vide.vTextButton?,

  Active: (() -> boolean)?,
  Disabled: (() -> boolean)?,

  clicked: (() -> ())?,
}

local function Button(props: ButtonProps): TextButton
  local hovering = source(false)
  local pressed = source(false)
  local disabled = props.Disabled or source(false)
  local active = props.Active or source(false)

  local overlayTransparency = function()
    return hovering() and not pressed() and not disabled()
      and .5 or 1
  end

  local activeBorderTransparency = function()
    if disabled() then
      return active() and .5 or 1
    end
    return active() and 0 or 1
  end

  local disabledTransparency = function()
    return disabled() and .5 or 0
  end

  return create "TextButton" {
    Name = "Button",
    BackgroundColor3 = props.BackgroundColor or Theme "BackgroundTertiary",
    BackgroundTransparency = spring(disabledTransparency, .15, 1),
    AutomaticSize = Enum.AutomaticSize.XY,

    props.Layout,

    MouseEnter = function()
      hovering(true)
    end,

    MouseLeave = function()
      hovering(false)
      pressed(false)
    end,

    MouseButton1Down = function()
      pressed(true)
    end,

    MouseButton1Up = function()
      pressed(false)
    end,
    
    Activated = function()
      if props.clicked and not disabled() then
        props.clicked()
      end
    end,

    Rounded {},
    Border {
      Color = Theme "Primary",
      Thickness = 2,
      Transparency = spring(activeBorderTransparency, .15, 1)
    },
    Text {
      Size = UDim2.fromScale(1, 1),

      TextTransparency = spring(disabledTransparency, .15, 1),
      TextColor3 = props.TextColor,
      Text = props.Text,
      TextWrapped = false,

      ZIndex = 3,

      Padding { UDim.new(0, 8) },
    },

    create "Frame" {
      Name = "Overlay",
      BackgroundColor3 = Theme "Overlay",
      BackgroundTransparency = spring(overlayTransparency, .15, 1),
      Size = UDim2.fromScale(1, 1),

      ZIndex = 2,

      Rounded {}
    },
  }
end

return Button