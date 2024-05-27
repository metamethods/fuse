local isClass = require(script.Parent.isClass)
local function getDescendantsOfClass(instance: Instance, ...: string): {Instance}
  local instances = {}
  
  for _, child in instance:GetDescendants() do
    if isClass(child, ...) then
      table.insert(instances, child)
    end
  end
  
  return instances
end

return getDescendantsOfClass