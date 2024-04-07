local Fuse = script:FindFirstAncestor("Fuse")

local Classes = Fuse.Classes
local Utils = Fuse.Utils

local DescribableObject = require(Classes.DescribableObject)
local concatTruncate = require(Utils.concatTruncate)

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
    
    if link.link0 ~= from and linkedTo(links, link.link0, to, visited) then
      return true
    end

    if link.link1 ~= from and linkedTo(links, link.link1, to, visited) then
      return true
    end
  end

  return false
end

return DescribableObject.new()
  :setName("Descendants are Welded to the Core/Ore")
  :setDescription("Checks if all of the descendants of the ore are constrained to the core/ore.")
  :setObject(function(ore: BasePart)
    local constraints: {Constraint | WeldConstraint} = {}
    local parts: {BasePart} = {}
    local constraintTree: {Link<BasePart>} = {}

    -- Insert all of our valid constraints into the tree
    for _, instance in ore:GetDescendants() do
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
      if not linkedTo(constraintTree, part, ore, {}) then
        table.insert(unconstrainedParts, part)
      end
    end

    if #unconstrainedParts <= 0 then return true, "All descendants are welded to the ore." end
    return false, `The following parts are not welded to the ore: {concatTruncate(unconstrainedParts, ", ", 20, function(part) return part:GetFullName() end)}`
  end)