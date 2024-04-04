local Store = require(script.Store)
local Types = require(script.Types)
local App = require(script.App)

local pluginStateStore = Store.new(plugin:GetSetting("PluginState") or {})
local defaultPluginStateStore: Types.PluginState = {
  guiEnabled = true,
  tabIndex = 1
}

for key, value in defaultPluginStateStore do
  if pluginStateStore:get()[key] == nil then
    pluginStateStore:get()[key] = value
  end
end

pluginStateStore:onChanged(function(newState)
  plugin:SetSetting("PluginState", newState)
end)

App(plugin) {
  pluginState = pluginStateStore
}