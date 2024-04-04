export type ToolbarProps = {
  plugin: Plugin,

  name: string
}

return function(props: ToolbarProps)
  return props.plugin:CreateToolbar(props.name)  
end