local slice = require(script.Parent.slice)

local function list(items: { string }, truncate: number?): string
	return table.concat(slice(items, 1, truncate and truncate + 1), ", ")
		.. (
			(truncate and #items > truncate)
				and `... +{#items - truncate} more`
			or ""
		)
end

return list
