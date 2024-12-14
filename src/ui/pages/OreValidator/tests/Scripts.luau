local Test = require(script.Parent.Parent.Test)

return Test.define(
	`Scrip count is utmost 1 or none`,
	`Checks if the total amount of scripts in a ore has utmost 1 script`,
	function(ore)
		local total = 0

		for _, instance in ore:GetDescendants() do
			if not instance:IsA("Script") then
				continue
			end
			total += instance.Segments
		end

		if total > 1 then
			return Test.fail(
				`The ore has a total of <b>{total} scripts</b>, which is more than <b>1 script</b>`
			)
		elseif total == 1 then
			return Test.ok("The ore has a script.")
		else
			return Test.ok("The ore doesn't seem to have a script")
		end
	end
)
