local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Fusion = require(Packages.fusion)

local Value = Fusion.Value
local Observer = Fusion.Observer

export type ButtonToggleProps = {
  toolbar: PluginToolbar,

  id: string,
  toolTip: string,
  icon: string,
  enabled: boolean,
  onToggle: (state: Fusion.Value<boolean>, button: PluginToolbarButton) -> ()
}

return function(props: ButtonToggleProps)
  local button = props.toolbar:CreateButton(
    props.id,
    props.toolTip,
    props.icon
  )
  local state = Value(props.enabled)
  local observer = Observer(state)
  
  observer:onChange(function()
    button:SetActive(state:get())
  end)
  observer:update()

  button.Click:Connect(function()
    state:set(not state:get())
    props.onToggle(state, button)
  end)

  return button, state
end