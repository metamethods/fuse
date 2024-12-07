local vide = require(script.Parent.Parent.packages.vide)

local function useOre(ore: vide.Source<BasePart?>): vide.Source<BasePart?>
	local clone = vide.source(ore() and (ore() :: BasePart):Clone() or nil)
	local lastOre = ore()

	vide.effect(function()
		local ore = ore()
		if not ore then
			clone(nil)
			lastOre = nil
			return
		end
		if ore == lastOre then
			return
		end

		lastOre = ore

		clone(ore:Clone())
	end)

	return clone
end

return useOre
