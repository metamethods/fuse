local function map<I, T>(items: { I }, transform: (I) -> T): { T }
	local transformed = {}

	for i, item in items do
		transformed[i] = transform(item)
	end

	return transformed
end

return map
