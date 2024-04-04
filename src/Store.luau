--!nocheck

local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages

local Fusion = require(Packages.fusion)

local Value = Fusion.Value
local Observer = Fusion.Observer

local Store = {}
Store.prototype = {}
Store.__index = Store.prototype

function Store.new<T>(initialData: T): Store<T>
  assert(typeof(initialData) == "table", "Store.new expects a table as the initial data")
  return setmetatable({
    _value = Value(initialData)
  }, {
    __index = function(self, k)
      if Store.prototype[k] then
        return Store.prototype[k]
      end
      return self._value:get()[k]
    end,
    __newindex = function(self, k, v)
      self._value:get()[k] = v
      self._value:set(self._value:get(), true)
    end
  }) :: any
end

function Store.prototype.update<T>(self: Store<T>, updater: () -> {any})
  local value = self._value:get(); assert(typeof(value) == "table", "_value is not a type of table")
  local updatedValues = updater()
  for k, v in pairs(updatedValues) do
    value[k] = v
  end
  self._value:set(value, true)
end

function Store.prototype.get<T>(self: Store<T>): T
  return self._value:get()
end

function Store.prototype.onChanged<T>(self: Store<T>, fn: (T) -> ()): Fusion.Observer
  local observer = Observer(self._value)
  observer:onChange(function() fn(self:get()) end)
  return observer
end

export type Store<T> = typeof(setmetatable(
  {} :: {
    _value: Fusion.Value<T>,
    update: (self: Store<T>, updater: () -> {any}) -> (),
    get: (self: Store<T>) -> T,
    onChanged: (self: Store<T>, fn: (T) -> ()) -> Fusion.Observer
  } & T,
  Store
))

return Store