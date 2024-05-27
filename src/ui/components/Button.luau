local Padding = require(script.Parent.Padding)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local types = require(script.Parent.Parent.Parent.types)
local useStudioTheme = require(script.Parent.Parent.Parent.util.useStudioTheme)
local useTheme = require(script.Parent.Parent.Parent.util.useTheme)
local Round = require(script.Parent.Round)

export type ButtonProps = {
  text: string?,
  disabled: vide.Source<boolean>?,
  active: vide.Source<boolean>?,
  onClick: () -> ()?,
  layout: vide.vTextButton?,
  children: types.Components?,
}

local function Button(props: ButtonProps): TextButton
  local hovering = vide.source(false)
  local pressed = vide.source(false)
  local disabled = props.disabled or vide.source(false)
  local active = props.active or vide.source(false)

  local theme = useStudioTheme()

  local backgroundColor = function()
    if disabled() then
      return useTheme(Enum.StudioStyleGuideColor.Button, "Disabled")()
    end

    if active() then
      return useTheme(Enum.StudioStyleGuideColor.Button, "Selected")()
    end

    if hovering() and not pressed() then
      return useTheme(Enum.StudioStyleGuideColor.Button, "Hover")()
    end

    if pressed() then
      return useTheme(Enum.StudioStyleGuideColor.Button, "Pressed")()
    end

    return useTheme(Enum.StudioStyleGuideColor.Button)()
  end

  local textColor = function()
    if disabled() then
      return useTheme(Enum.StudioStyleGuideColor.ButtonText, "Disabled")()
    end

    if active() then
      return useTheme(Enum.StudioStyleGuideColor.ButtonText, "Selected")()
    end

    return useTheme(Enum.StudioStyleGuideColor.ButtonText, "Default")()
  end

  return vide.create "TextButton" {
    Name = "Button",
    BackgroundColor3 = vide.spring(backgroundColor, .1),
    AutomaticSize = Enum.AutomaticSize.XY,

    Text = props.text,
    TextColor3 = vide.spring(textColor, .1),
    TextSize = 16,
    Font = Enum.Font.Gotham,

    vide.create "UIStroke" {
      Color = function()
        return theme().Name == "Light"
          and useTheme(Enum.StudioStyleGuideColor.ButtonBorder)()
          or Color3.new()
      end,
      ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
      Transparency = function()
        return theme().Name == "Dark" and 1 or 0
      end
    },

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
      if not disabled() and props.onClick then
        props.onClick()
      end
    end,

    Padding { UDim.new(0, 8) },
    Round {},

    props.layout,
    props.children,
  }
end

return Button