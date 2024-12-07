local vide = require(script.Parent.Parent.Parent.packages.vide)
local ListSelector = require(script.Parent.ListSelector)
local PageContainer = require(script.Parent.PageContainer)
local types = require(script.Parent.Parent.Parent.types)

export type PagesProps = {
	pageIndex: vide.Source<number>,
	pageLayout: types.Components?,
	pages: { PageContainer.Page },
}

local function Pages(props: PagesProps): Frame
	local items = {}

	for i, page in ipairs(props.pages) do
		items[i] = page.name
	end

	return vide.create("Frame")({
		Name = "Pages",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		ListSelector({
			items = vide.source(items),
			selected = props.pageIndex,
			direction = "Horizontal",
			layout = {
				Size = UDim2.new(1, 0, 0, 50),
				ZIndex = 2,
			},
		}),

		PageContainer({
			layout = {
				Size = UDim2.new(1, 0, 1, -50),
				Position = UDim2.fromScale(0, 1),
				AnchorPoint = Vector2.new(0, 1),
			},
			pageLayout = props.pageLayout,
			pageIndex = props.pageIndex,
			pages = props.pages,
		}),
	})
end

return Pages
