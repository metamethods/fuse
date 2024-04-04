local DescribableObject = {}
DescribableObject.__index = DescribableObject

function DescribableObject.new<ObjectT>(): DescribableObject<ObjectT>
  return setmetatable({
    name = "Object",
    description = "An object",
    object = nil
  }, DescribableObject) :: DescribableObject<ObjectT>
end

function DescribableObject.setName<ObjectT>(self: DescribableObject<ObjectT>, name: string): DescribableObject<ObjectT>
  self.name = name
  return self
end

function DescribableObject.setDescription<ObjectT>(self: DescribableObject<ObjectT>, description: string): DescribableObject<ObjectT>
  self.description = description
  return self
end

function DescribableObject.setObject<ObjectT>(self: DescribableObject<ObjectT>, object: ObjectT): DescribableObject<ObjectT>
  self.object = object
  return self
end

function DescribableObject.__tostring(self: DescribableObject<any>)
  return self.name
end

export type DescribableObject<ObjectT> = typeof(setmetatable(
  {} :: {
    name: string,
    description: string,
    object: ObjectT,
    setName: (self: DescribableObject<ObjectT>, name: string) -> DescribableObject<ObjectT>,
    setDescription: (self: DescribableObject<ObjectT>, description: string) -> DescribableObject<ObjectT>,
    setObject: (self: DescribableObject<ObjectT>, value: ObjectT) -> DescribableObject<ObjectT>
  },
  DescribableObject
))

return DescribableObject