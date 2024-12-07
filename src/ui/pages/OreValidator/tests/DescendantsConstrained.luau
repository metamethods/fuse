local Test = require(script.Parent.Parent.Test)

type Link<T> = {
	link0: T,
	link1: T,
}

function linkedTo<T>(
	links: { Link<T> },
	from: T,
	to: T,
	visited: { [T]: boolean }
): boolean
	if visited[from] then
		return false
	end
	visited[from] = true

	for _, link in links do
		if
			(link.link0 == from and link.link1 == to)
			or (link.link0 == to and link.link1 == from)
		then
			return true
		end

		if
			link.link0 ~= from
			and link.link1 == from
			and linkedTo(links, link.link0, to, visited)
		then
			return true
		end

		if
			link.link1 ~= from
			and link.link0 == from
			and linkedTo(links, link.link1, to, visited)
		then
			return true
		end
	end

	return false
end

function getUnconstrainedParts(target: BasePart): { BasePart }
	local constraints: { Constraint | WeldConstraint | Motor } = {}
	local parts: { BasePart } = {}
	local constraintTree: { Link<BasePart> } = {}

	for _, instance in target:GetDescendants() do
		if
			instance:IsA("Constraint")
			or instance:IsA("WeldConstraint")
			or instance:IsA("Motor")
		then
			table.insert(constraints, instance)
		end
		if instance:IsA("BasePart") then
			table.insert(parts, instance)
		end
	end

	for _, constraint in constraints do
		local object0, object1

		if constraint:IsA("Constraint") then
			object0 =
				constraint.Attachment0:FindFirstAncestorWhichIsA("BasePart")
			object1 =
				constraint.Attachment1:FindFirstAncestorWhichIsA("BasePart")
		else
			object0 = constraint.Part0
			object1 = constraint.Part1
		end

		if not object0 or not object1 then
			warn(
				`{constraint} has a nil part0/part1. This will not count as a valid constraint`
			)
			continue
		end

		table.insert(constraintTree, {
			link0 = object0,
			link1 = object1,
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

function getDisabledConstraints(
	target: BasePart
): { Constraint | WeldConstraint }
	local disabledConstraints = {}

	for _, instance in target:GetDescendants() do
		if instance:IsA("Constraint") or instance:IsA("WeldConstraint") then
			if not instance.Enabled then
				table.insert(disabledConstraints, instance)
			end
		end
	end

	return disabledConstraints
end

return Test.define(
	"Descendants Constrained",
	"Checks if all of the descendants are constrained to the ore",
	function(ore)
		local unconstrainedParts = getUnconstrainedParts(ore)
		local disabledContraints = getDisabledConstraints(ore)

		if #unconstrainedParts == 0 then
			if #disabledContraints == 0 then
				return Test.ok("All descendants are welded to the ore!")
			else
				return Test.warn(
					`{#disabledContraints} disabled constraint(s) was found in your ore. You might expierence the ore falling apart if they aren't enabled.`,
					disabledContraints
				)
			end
		else
			return Test.fail(
				`{#unconstrainedParts} unconstrained part(s) was found in your ore.`,
				unconstrainedParts
			)
		end
	end
)
