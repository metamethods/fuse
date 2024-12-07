local vide = require(script.Parent.Parent.Parent.packages.vide)
local useTheme = require(script.Parent.Parent.Parent.util.useTheme)
local Fragment = require(script.Parent.Parent.components.Fragment)
local Padding = require(script.Parent.Parent.components.Padding)
local Round = require(script.Parent.Parent.components.Round)
local ScrollingPage = require(script.Parent.Parent.components.ScrollingPage)
local Section = require(script.Parent.Parent.components.Section)
local SelectedOre = require(script.Parent.Parent.components.SelectedOre)
local Text = require(script.Parent.Parent.components.Text)
local displayableOreInformation = require(script.displayableOreInformation)

export type OreInfoProps = {
	ore: vide.Source<BasePart?>,
}

-- TODO: Rewrite/Refactor this code

local function OreInfo(props: OreInfoProps): ScrollingFrame
	local oreExists = function()
		return props.ore() ~= nil
	end

	local instanceCounts = function()
		local ore = props.ore()

		if not ore then
			return {}
		end

		local instanceCounts = {}

		for _, instance in ore:GetDescendants() do
			if not instanceCounts[instance.ClassName] then
				instanceCounts[instance.ClassName] = 1
			else
				instanceCounts[instance.ClassName] += 1
			end
		end

		return instanceCounts
	end

	return ScrollingPage({
		Section({
			headerText = "Ore Info",
			text = "Welcome to the Ore Info tab, pretty much just get a report on stuff about your ore!",
		}),

		SelectedOre({
			ore = props.ore,
		}),

		vide.switch(oreExists)({
			[true] = function()
				if not oreExists() then
					return {}
				end

				return Fragment({
					padding = UDim.new(0, 8),
					children = {
						vide.indexes(
							vide.source(displayableOreInformation),
							function(information)
								return Text({
									text = function()
										local oreInfo = information()
										local ore = props.ore()

										if not ore then
											return ""
										end

										return `<b>{oreInfo.name}</b>: {oreInfo.fn(
											props.ore()
										)}`
									end,
									layout = {
										BackgroundColor3 = useTheme(
											Enum.StudioStyleGuideColor.Light
										),
										BackgroundTransparency = 0,

										Padding({}),
										Round({}),
									},
								})
							end
						),

						Text({
							text = "Instances",
						}),

						vide.indexes(instanceCounts, function(count, className)
							return Text({
								text = `<b>{className}</b>: {count()}`,
								layout = {
									BackgroundColor3 = useTheme(
										Enum.StudioStyleGuideColor.Light
									),
									BackgroundTransparency = 0,

									Padding({}),
									Round({}),
								},
							})
						end),
					},
				})
			end,
			[false] = function()
				return Text({ text = "<b>Please select an ore!</b>" })
			end,
		}),
	})
end

return OreInfo
