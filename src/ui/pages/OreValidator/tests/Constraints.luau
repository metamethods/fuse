local Test = require(script.Parent.Parent.Test)

return Test.define("Only Weld Constraints", "Checks if the ore only uses WeldConstraints, and not Weld", function(ore)
  local welds = {}

  for _, instance in ore:GetDescendants() do
    if not instance:IsA("Weld") then continue end
    table.insert(welds, instance)
  end

  if #welds > 0 then
    return Test.fail(`There seems to be <b>{#welds} Weld(s)</b> in the ore`, welds)
  else
    return Test.ok("It seems like theres no <b>Weld</b> instances present in the ore!")
  end
end)