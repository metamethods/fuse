local ChangeHistoryService = game:GetService("ChangeHistoryService")

local vide = require(script.Parent.Parent.Parent.packages.vide)
local types = require(script.Parent.Parent.Parent.types)
local Button = require(script.Parent.Parent.components.Button)
local Fragment = require(script.Parent.Parent.components.Fragment)
local HeaderText = require(script.Parent.Parent.components.HeaderText)
local ScrollingPage = require(script.Parent.Parent.components.ScrollingPage)
local Section = require(script.Parent.Parent.components.Section)
local SelectedOre = require(script.Parent.Parent.components.SelectedOre)
local Text = require(script.Parent.Parent.components.Text)
local TextBox = require(script.Parent.Parent.components.TextBox)

type ModifierProps = types.ModifierDefinition & {
	ore: vide.Source<BasePart?>,
}

local function Modifier(props: ModifierProps): TextButton
	local repeatCount = vide.source(1)

	local disabled = function()
		return not props.ore()
	end

	return Button({
		text = "",
		layout = {
			Name = props.title,
			Size = UDim2.fromScale(1, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
		},
		children = {
			Fragment({
				children = {
					HeaderText({ text = props.title }),
					Text({ text = props.description }),

					vide.create("Frame")({
						Name = "Break",
						Size = UDim2.fromOffset(0, 8),
					}),

					TextBox({
						placeholder = "Repeat Count (Default: 1, Max: 100)",
						layout = {
							BackgroundTransparency = 1,
						},
						paddingLayout = { UDim.new(0, 0) },
						onChanged = function(newText)
							repeatCount(
								math.clamp(tonumber(newText) or 1, 1, 100)
							)
						end,
					}),
				},
			}),
		},
		disabled = disabled,
		onClick = function()
			local ore = props.ore()
			if not ore then
				return
			end

			for _ = 1, repeatCount() do
				props.fn(ore)
			end

			ChangeHistoryService:SetWaypoint(
				`Used the "{props.title}" modifier on "{ore.Name}"`
			)
		end,
	})
end

export type OreModifierProps = {
	ore: vide.Source<BasePart?>,
}

local function OreModifier(props: OreModifierProps): ScrollingFrame
	return ScrollingPage({
		Section({
			headerText = "Ore Modifier",
			text = "Quickly modify the ore's properties with a single click!",
		}),

		SelectedOre({
			ore = props.ore,
		}),

		Fragment({
			padding = UDim.new(0, 8),
			listLayout = {
				SortOrder = Enum.SortOrder.Name,
			},
			children = vide.indexes(
				vide.source(script.modifiers:GetChildren()),
				function(module: vide.Source<ModuleScript>)
					local modifierDefinition: types.ModifierDefinition =
						require(module())

					return Modifier({
						ore = props.ore,
						title = modifierDefinition.title,
						description = modifierDefinition.description,
						fn = modifierDefinition.fn,
					})
				end
			),
		}),
	})
end

return OreModifier
