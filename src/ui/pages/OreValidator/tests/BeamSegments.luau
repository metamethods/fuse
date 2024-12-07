local Test = require(script.Parent.Parent.Test)

local MAX_BEAM_SEGMENTS = 42_000

return Test.define(
	`Total beam segments < {MAX_BEAM_SEGMENTS}`,
	`Checks if the total amount of segments in the ore is less than {MAX_BEAM_SEGMENTS}`,
	function(ore)
		local total = 0

		for _, instance in ore:GetDescendants() do
			if not instance:IsA("Beam") then
				continue
			end
			total += instance.Segments
		end

		if total > MAX_BEAM_SEGMENTS then
			return Test.fail(
				`The ore has a total of <b>{total} beam segments</b>, which is more than <b>{MAX_BEAM_SEGMENTS} segments</b>`
			)
		elseif total > MAX_BEAM_SEGMENTS / 2 then
			return Test.warn(
				`The ore has a total of <b>{total} beam segments</b>. You should consider <b>reducing the amount of segments</b> to improve performance.`
			)
		else
			return Test.ok(`The ore has a total of {total} beam segments`)
		end
	end
)
