local vide = require(script.Parent.Parent.Parent.packages.vide)
local types = require(script.Parent.Parent.Parent.types)

export type Page = {
	name: string,
	component: types.Component,
}

export type PageContainerProps = {
	pageLayout: types.Components?,
	layout: vide.vFrame?,
	pageIndex: vide.Source<number>,
	pages: { Page },
}

local function PageContainer(props: PageContainerProps): Frame
	local pageComponents = {}

	for i, page in ipairs(props.pages) do
		pageComponents[i] = function()
			return page.component
		end
	end

	return vide.create("Frame")({
		Name = "PageContainer",
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),

		props.pageLayout,
		vide.switch(props.pageIndex)(pageComponents),

		props.layout,
	})
end

return PageContainer
