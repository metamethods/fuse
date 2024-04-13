local Packages = script.Packages
local Components = script.App.Components

local App = require(script.App)
local Toolbar = require(Components.Studio.Toolbar)
local Widget = require(Components.Studio.Widget)
local ButtonToggle = require(Components.Studio.ButtonToggle)

local State = require(script.State)

local config = require(script.Config)
local vide = require(Packages.vide)

function mount<A...>(component: (A...) -> Instance, parent: Instance, ...: A...)
  local arguments = table.pack(...)
  return vide.mount(function()
    return component(table.unpack(arguments))
  end, parent)
end

local pluginState = State.new({
  tabIndex = 1
}, plugin:GetSetting("FuseState") or {})

local toolbar = Toolbar {
  plugin = plugin,
  name = `Fuse {config.version}`
}

local widget = Widget {
  plugin = plugin,

  id = "Fuse",
  title = `Fuse {config.version}`,
  dockState = Enum.InitialDockState.Float,
  enabled = false,
  floatSize = Vector2.new(400, 400),
  minSize = Vector2.new(200, 200),
}

local widgetButton = ButtonToggle {
  toolbar = toolbar,

  id = "Fuse",
  tooltip = "Click to toggle the Fuse window",
  icon = "rbxassetid://17002766001",

  state = true,

  toggled = function(state)
    widget.Enabled = state
  end
}

widget.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
widget.Name = "Fuse"
widget:BindToClose(function()
  widgetButton.setState(false)
end)

pluginState.changed = function(new)
  plugin:SetSetting("FuseState", new)
end

mount(App, widget, {
  state = pluginState
})