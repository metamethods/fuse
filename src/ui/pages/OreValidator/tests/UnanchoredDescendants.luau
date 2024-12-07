local Test = require(script.Parent.Parent.Test)

return Test.define(
	"Unanchored Descendants",
	"Checks if all of the descendants in the ore are unanchored",
	function(ore)
		local anchoredDescendants = {}

		for _, instance in ore:GetDescendants() do
			if not instance:IsA("BasePart") then
				continue
			end
			if instance.Anchored then
				table.insert(anchoredDescendants, instance)
			end
		end

		if #anchoredDescendants > 0 then
			return Test.fail(
				`There seems to be <b>{#anchoredDescendants} anchored descendants</b> in the ore.`,
				anchoredDescendants
			)
		else
			return Test.ok("All of the descendants in the ore are unanchored")
		end
	end
)
