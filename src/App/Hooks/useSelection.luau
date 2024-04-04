local SelectionService = game:GetService("Selection")

local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Fusion = require(Packages.fusion)

local Value = Fusion.Value
local Observer = Fusion.Observer

return function(onUpdate: ({Instance}) -> ()):Fusion.Observer
  local selected = Value(SelectionService:Get())
  local observer = Observer(selected)

  SelectionService.SelectionChanged:Connect(function()
    selected:set(SelectionService:Get())
  end)

  observer:onChange(function()
    onUpdate(selected:get())
  end)
  observer:update()

  return observer
end