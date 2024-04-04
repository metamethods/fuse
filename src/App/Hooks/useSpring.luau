local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Fusion = require(Packages.fusion)

local Spring = Fusion.Spring
local Value = Fusion.Value

export type UpdateValue<T> = (T) -> ()

return function<T>(initialValue: T, speed: number?, damping: number?): (Fusion.Spring<T>, UpdateValue<T>)
  local value = Value(initialValue)
  local spring = Spring(value, speed or 40, damping)

  local updateValue = function(newValue: T)
    value:set(newValue)
  end

  return spring, updateValue
end