export type PluginState = {
  guiEnabled: boolean,
  tabIndex: number
}

export type TestFunction = (ore: BasePart) -> (boolean, string)

return nil