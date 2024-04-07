local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Components = App.Components
local Hooks = App.Hooks

local Fusion = require(Packages.fusion)
local Theme = require(App.Theme)
local Padding = require(Components.Padding)
local useSpring = require(Hooks.useSpring)
local Rounded = require(Components.Rounded)
local HeaderText = require(Components.HeaderText)

local Value = Fusion.Value
local New = Fusion.New
local OnEvent = Fusion.OnEvent
local Observer = Fusion.Observer
local Computed = Fusion.Computed
local Children = Fusion.Children

export type ButtonProps = {
  text: string?,
  textSize: number?,
  position: UDim2?,
  size: UDim2?,
  automaticSize: Enum.AutomaticSize?,

  textColor: Color3?,
  disabledButtonColor: Color3?,
  backgroundColor: Color3?,
  overlayColor: Color3?,
  noBorder: boolean?,
  overlayHoverTransparency: number?,

  disabled: boolean?,
  onClicked: () -> ()?
}

return function(props: ButtonProps)
  local disabled = props.disabled or Value(false)
  local hovering = Value(false)

  local overlayTransparency, setOverlayTransparency = useSpring(1)

  Observer(hovering):onChange(function()
    setOverlayTransparency(hovering:get() and (props.overlayHoverTransparency or .9) or 1)
  end)

  return New "TextButton" {
    Name = "Button",
    -- Theres possibly a better way to do this, but oh well
    BackgroundColor3 = Computed(function()
      local backgroundColor = props.backgroundColor or Theme("ButtonBackground"):get()

      if typeof(backgroundColor) ~= "Color3" and backgroundColor then
        backgroundColor = backgroundColor:get()
      end

      return backgroundColor
    end),
    BackgroundTransparency = Computed(function()
      if disabled:get() then return .8 end
      return props.backgroundColor and 0 or 1
    end),
    Size = props.size or UDim2.new(0, 0, 0, 0),
    Position = props.position,
    AutomaticSize = Enum.AutomaticSize.XY,

    [OnEvent "MouseEnter"] = function()
      if disabled:get() then return end
      hovering:set(true)
    end,

    [OnEvent "MouseLeave"] = function()
      hovering:set(false)
    end,

    [OnEvent "MouseButton1Click"] = function()
      if disabled:get() or not props.onClicked then return end
      props.onClicked()
    end,
    
    [Children] = {
      New "UIStroke" {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Thickness = props.noBorder and 0 or 1,
        Color = Theme "ButtonBorder"
      },
      New "Frame" {
        Name = "Overlay",
        BackgroundColor3 = props.overlayColor or Theme "Overlay",
        BackgroundTransparency = overlayTransparency,
        Size = UDim2.new(1, 0, 1, 0),

        [Children] = Rounded()
      },
      HeaderText "" {
        Text = props.text,
        TextColor3 = props.textColor and props.textColor or Theme "ButtonText",
        TextTransparency = Computed(function()
          return disabled:get() and .5 or 0
        end),

        ZIndex = 2,

        [Children] = Padding(UDim.new(0, 8), UDim.new(0, 12)),
      },
      Rounded()
    }
  }
end