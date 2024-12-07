local vide = require(script.Parent.Parent.Parent.packages.vide)
local ScrollingList = require(script.Parent.ScrollingList)
local Button = require(script.Parent.Button)
local Padding = require(script.Parent.Padding)

export type ListSelectorProps = {
	layout: vide.vScrollingFrame?,

	items: vide.Source<{ [number]: string }>,
	selected: vide.Source<number>,
	direction: ("Vertical" | "Horizontal")?,
}

local function ListSelector(props: ListSelectorProps): ScrollingFrame
	return ScrollingList({
		direction = props.direction,
		layout = props.layout,
		listLayout = {
			Padding = UDim.new(0, 8),
		},
		children = {
			vide.indexes(props.items, function(name, i)
				return Button({
					text = name,
					onClick = function()
						props.selected(i)
					end,
					active = function()
						return props.selected() == i
					end,
				})
			end),

			Padding({ UDim.new(0, 8) }),
		},
	})
end

return ListSelector
