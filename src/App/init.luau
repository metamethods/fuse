local Fuse = script:FindFirstAncestor("Fuse")
local App = Fuse.App
local Hooks = App.Hooks
local Packages = Fuse.Packages
local Components = App.Components

local Types = require(Fuse.Types)
local Store = require(Fuse.Store)
local Fusion = require(Packages.fusion)
local Config = require(Fuse.Config)
local Theme = require(App.Theme)
local Toolbar = require(Components.Studio.Toolbar)
local Widget = require(Components.Studio.Widget)
local ButtonToggle = require(Components.Studio.ButtonToggle)
local Pages = require(Components.Pages)
local Padding = require(Components.Padding)
local Home = require(App.Pages.Home)
local Validator = require(App.Pages.Validator)
local Cat = require(App.Pages.Cat)
local Notes = require(App.Pages.Notes)
local Fixer = require(App.Pages.Fixer)
local Skybox = require(App.Pages.Skybox)
local useOre = require(Hooks.useOre)

local New = Fusion.New
local Value = Fusion.Value
local Observer = Fusion.Observer
local Children = Fusion.Children

export type AppProps = {
  pluginState: Store.Store<Types.PluginState>
}

function AppComponent(props: AppProps)
  local pageIndex = Value(props.pluginState.tabIndex)
  local ore = useOre()

  local PAGES = {
    {
      title = "Home",
      order = 1,
      component = Home {}
    },
    {
      title = "Ore Validator",
      order = 2,
      component = Validator {
        ore = ore
      }
    },
    {
      title = "Ore Notes",
      order = 3,
      component = Notes {
        ore = ore
      }
    },
    {
      title = "Ore Fixer",
      order = 4,
      component = Fixer {
        ore = ore
      } 
    },
    {
      title = "Skyboxes",
      order = 5,
      component = Skybox {}
    },
    {
      title = "Cat Therapy",
      order = 6,
      component = Cat {}
    }
  }

  Observer(pageIndex):onChange(function()
    props.pluginState.tabIndex = pageIndex:get()
  end)

  return New "Frame" {
    Name = "Body",
    BackgroundColor3 = Theme "Background",
    Size = UDim2.new(1, 0, 1, 0),

    [Children] = Pages {
      pages = PAGES,
      layout = Padding(UDim.new(0, 12)),

      pageIndex = pageIndex,
    }
  }
end

return function(plugin: Plugin): (props: AppProps) -> ()
  return function(props: AppProps)
    local toolbar = Toolbar {
      plugin = plugin,
      name = `Fuse {Config.Version}`
    }

    local widget = Widget {
      plugin = plugin,

      title = `Fuse {Config.Version}`,
      dockState = Enum.InitialDockState.Float,
      enabled = props.pluginState.guiEnabled,
      floatSize = Vector2.new(250, 250),
      minSize = Vector2.new(250, 250)
    }

    local _, buttonState = ButtonToggle {
      toolbar = toolbar,

      id = "Fuse",
      toolTip = "Click to toggle the Fuse window",
      icon = "rbxassetid://17002766001",
      enabled = props.pluginState.guiEnabled,
      onToggle = function(state: Fusion.Value<boolean>)
        widget.Enabled = state:get()
        props.pluginState.guiEnabled = state:get()
      end
    }

    widget:BindToClose(function()
      buttonState:set(false)
    end)

    AppComponent(props).Parent = widget
  end
end