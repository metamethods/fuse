export type WidgetProps = {
  plugin: Plugin,

  id: string,
  title: string,
  dockState: Enum.InitialDockState,
  enabled: boolean,
  floatSize: Vector2,
  minSize: Vector2,
}

local function Widget(props: WidgetProps): DockWidgetPluginGui
  local widget = props.plugin:CreateDockWidgetPluginGui(
    props.id,
    DockWidgetPluginGuiInfo.new(
      props.dockState,
      props.enabled,
      true,
      props.floatSize.X,
      props.floatSize.Y,
      props.minSize.X,
      props.minSize.Y
    )
  )

  widget.Title = props.title

  return widget
end

return Widget