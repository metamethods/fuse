--!nocheck

local State = {}
State.__index = State

function merge(default: {[any]: any}, data: {[any]: any}): any
  local merged = {}

  for key, value in pairs(default) do
    if typeof(value) == "table" then
      merged[key] = merge(value, data[key] or {})
    else
      merged[key] = data[key] or value
    end
  end

  return merged
end

function State.new<T>(default: T, data: {[any]: any}): State<T>
  return setmetatable({
    _raw = merge(default, data)
  }, State) :: State<T>
end

function State.__newindex<T>(self: State<T>, key: any, value: any)
  self._raw[key] = value
  self.changed(self._raw)
end

function State.__index<T>(self: State<T>, key: any): any
  return self._raw[key]
end

export type State<T> = typeof(setmetatable(
  {} :: {
    _raw: T,
    changed: (T) -> ()
  } & T,
  State
))

return State