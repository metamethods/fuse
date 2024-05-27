local Test = require(script.Parent.Parent.Test)

return Test.define("Descendants Collision & Query is Disabled", "Checks if all of the descendants of the ore have the collision and query property disabled", function(ore)
  local descendants = {}

  for _, instance in ore:GetDescendants() do
    if not instance:IsA("BasePart") then continue end
    if instance.CanCollide or instance.CanQuery then
      table.insert(descendants, instance)
    end
  end

  if #descendants > 0 then
    return Test.fail(`There seems to be <b>{#descendants} descendant(s) with collision or query enabled</b> in the ore`, descendants)
  else
    return Test.ok("All of the descendants in the ore have collision and query disabled")
  end
end)