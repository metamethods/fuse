local OreValidator = script:FindFirstAncestor("OreValidator")

local Test = require(OreValidator.Test)

type Link<T> = {
  link0: T,
  link1: T
}

function linkedTo<T>(links: {Link<T>}, from: T, to: T, visited: {[T]: boolean}): boolean
  if visited[from] then return false end
  visited[from] = true

  for _, link in links do
    if 
      (link.link0 == from and link.link1 == to) or
      (link.link0 == to and link.link1 == from)
    then
      return true
    end
    
    if link.link0 ~= from and link.link1 == from and linkedTo(links, link.link0, to, visited) then
      return true
    end

    if link.link1 ~= from and link.link0 == from and linkedTo(links, link.link1, to, visited) then
      return true
    end
  end

  return false
end

function getUnconstrainedParts(target: BasePart): {BasePart}
  local constraints: {Constraint | WeldConstraint} = {}
  local parts: {BasePart} = {}
  local constraintTree: {Link<BasePart>} = {}

  for _, instance in target:GetDescendants() do
    if instance:IsA("Constraint") or instance:IsA("WeldConstraint") then
      table.insert(constraints, instance)
    end
    if instance:IsA("BasePart") then
      table.insert(parts, instance)
    end
  end

  for _, constraint in constraints do
    local object0, object1

    if constraint:IsA("Constraint") then
      object0 = constraint.Attachment0:FindFirstAncestorWhichIsA("BasePart")
      object1 = constraint.Attachment1:FindFirstAncestorWhichIsA("BasePart")
    else
      object0 = constraint.Part0
      object1 = constraint.Part1
    end

    table.insert(constraintTree, {
      link0 = object0,
      link1 = object1
    })
  end

  local unconstrainedParts = {}

  for _, part in parts do
    if not linkedTo(constraintTree, part, target, {}) then
      table.insert(unconstrainedParts, part)
    end
  end

  return unconstrainedParts
end

return Test.new(
  "Descendants are welded to Ore",
  "Checks if all of the descendants of the ore are constrained to the ore."
)
  :setTestFn(function(ore: BasePart)
    local unconstrainedParts = getUnconstrainedParts(ore)

    if #unconstrainedParts == 0 then return true, "All parts seem to be constrained to the ore!" end
    return false, `There are {#unconstrainedParts} unconstrained parts that was found in your ore.`, unconstrainedParts
  end)
  :setFixFn(function(ore: BasePart)
    local unconstrainedParts = getUnconstrainedParts(ore)

    for _, part in unconstrainedParts do
      local constraint = Instance.new("WeldConstraint")
      constraint.Part0 = part
      constraint.Part1 = ore
      constraint.Parent = part
    end
  end)