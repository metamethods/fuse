local Test = {}
Test.__index = Test

function Test.new(name: string, description: string): Test
  return setmetatable({
    name = name,
    description = description,
    testFn = function() end,
    fixFn = nil,
  }, Test) :: Test
end

function Test.setTestFn(self: Test, testFn: (ore: BasePart) -> (boolean, string)): Test
  self.testFn = testFn
  return self
end

function Test.setFixFn(self: Test, fixFn: (ore: BasePart) -> ()): Test
  self.fixFn = fixFn
  return self
end

export type Test = typeof(setmetatable(
  {} :: {
    name: string,
    description: string,
    testFn: (ore: BasePart) -> (boolean, string),
    fixFn: ((ore: BasePart) -> ())?,
  },
  Test
))

return Test