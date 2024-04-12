local OreValidator = script:FindFirstAncestor("OreValidator")

local Test = require(OreValidator.Test)

local DESCENDANTS_RECOMMENDED_LIMIT = 1_000

return Test.new(
  "Descendants",
  `Checks if the number of descendants is at least under the recommended limit of {DESCENDANTS_RECOMMENDED_LIMIT}`
)
  :setTestFn(function(ore: BasePart)
    local count = #ore:GetDescendants()
    if count > DESCENDANTS_RECOMMENDED_LIMIT then return false, `This ore is {count - DESCENDANTS_RECOMMENDED_LIMIT} descendants over the {DESCENDANTS_RECOMMENDED_LIMIT} recommended limit.` end
    return true, `This ore is currently has {count} descendants which is under the {DESCENDANTS_RECOMMENDED_LIMIT}.`
  end)