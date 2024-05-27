local Selection = game:GetService("Selection")

local function useSelection(fn: (selection: {Instance}) -> ()): RBXScriptConnection
  fn(Selection:Get())
  return Selection.SelectionChanged:Connect(function()
    fn(Selection:Get())
  end)
end

return useSelection