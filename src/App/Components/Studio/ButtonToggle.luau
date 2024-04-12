export type ButtonToggleProps = {
  toolbar: PluginToolbar,

  id: string,
  tooltip: string,
  icon: string,
  
  state: boolean,

  toggled: ((state: boolean) -> ())?
}

local function ButtonToggle(props: ButtonToggleProps)
  local button = props.toolbar:CreateButton(
    props.id,
    props.tooltip,
    props.icon
  )
  local state = props.state or false

  button:SetActive(state)
  button.Click:Connect(function()
    state = not state
    button:SetActive(state)
    if props.toggled then
      props.toggled(state)
    end
  end)

  return {
    setState = function(newState: boolean)
      state = newState
    end
  }
end

return ButtonToggle