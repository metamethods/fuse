export type WidgetProps = {
  plugin: Plugin,

  title: string,
  dockState: Enum.InitialDockState,
  enabled: boolean,
  floatSize: Vector2,
  minSize: Vector2,
}

return function(props: WidgetProps): DockWidgetPluginGui
  local widget = props.plugin:CreateDockWidgetPluginGui(
    props.title,
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