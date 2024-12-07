local List = require(script.Parent.List)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local types = require(script.Parent.Parent.Parent.types)

local function Page(children: types.Components): Frame
	return vide.create("Frame")({
		Name = "Page",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		List({
			direction = "Vertical",
			padding = UDim.new(0, 8),
		}),

		children,
	})
end

return Page
