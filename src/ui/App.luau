local constants = require(script.Parent.Parent.constants)
local vide = require(script.Parent.Parent.packages.vide)
local cleanup = require(script.Parent.Parent.util.cleanup)
local useSelection = require(script.Parent.Parent.util.useSelection)
local Padding = require(script.Parent.components.Padding)
local Pages = require(script.Parent.components.Pages)
local OreInfo = require(script.Parent.pages.OreInfo)
local OreModifier = require(script.Parent.pages.OreModifier)
local OrePreview = require(script.Parent.pages.OrePreview)
local OreValidator = require(script.Parent.pages.OreValidator)
local Skyboxes = require(script.Parent.pages.Skyboxes)
local Therapy = require(script.Parent.pages.Therapy)
local Toolbar = require(script.Parent.studio.Toolbar)
local ToolbarButton = require(script.Parent.studio.ToolbarButton)
local Widget = require(script.Parent.studio.Widget)

export type AppProps = {
  plugin: Plugin
}

local function App(props: AppProps)
  local enabled = vide.source(false)
  local pageIndex = vide.source(1)
  local ore = vide.source(nil)

  local selectionConnection = useSelection(function(selection)
    if selection and #selection >= 1 then
      local object = selection[1]
      if object:IsA("BasePart") and #object:GetDescendants() <= 5_000 then
        ore(object)
      end
    else
      ore(nil)
    end
  end)

  local toolbar = Toolbar {
    plugin = props.plugin,
    name = `{constants.PLUGIN_NAME} {constants.VERSION}`
  }

  local open = ToolbarButton {
    toolbar = toolbar,
    id = "open",
    text = constants.PLUGIN_NAME,
    tooltip = `Click to toggle the {constants.PLUGIN_NAME} window`,
    icon = constants.PLUGIN_ICON_ID,
    active = enabled,
    onClick = function()
      enabled(not enabled())
    end
  }

  local widget = Widget {
    plugin = props.plugin,
    id = "main",
    title = constants.PLUGIN_NAME,
    dockState = Enum.InitialDockState.Float,
    enabled = enabled,
    floatSize = Vector2.new(400, 300),
    minSize = Vector2.new(200, 200),
    zIndexBehavior = Enum.ZIndexBehavior.Sibling,
    onClose = function()
      enabled(false)
    end,
    children = {
      Pages {
        pageIndex = pageIndex,
        pageLayout = {
          Padding { UDim.new(0, 0), UDim.new(0, 8), UDim.new(0, 8), UDim.new(0, 8) }
        },
        pages = {
          {
            name = "Ore Validator",
            component = OreValidator {
              ore = ore
            }
          },
          {
            name = "Ore Info",
            component = OreInfo {
              ore = ore
            }
          },
          {
            name = "Ore Modifier",
            component = OreModifier {
              ore = ore
            }
          },
          -- TODO: Figure a more optimized way to render/do this
          -- {
          --   name = "Ore Preview",
          --   component = OrePreview {
          --     ore = ore
          --   }
          -- },
          {
            name = "Skyboxes",
            component = Skyboxes {}
          },
          {
            name = "Therapy",
            component = Therapy {}
          }
        }
      }
    }
  }

  cleanup(toolbar, open, widget, selectionConnection)
end

return App