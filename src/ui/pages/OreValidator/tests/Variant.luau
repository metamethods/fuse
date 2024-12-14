local Test = require(script.Parent.Parent.Test)

local funnyMessages = {
	"hammer attack imminent",
}

return Test.define(
	"Variant Checker",
	"Checks if the ore contains either the Spectralized or Ionized Variant attribute",
	function(ore)
		local funnyMessage = funnyMessages[math.random(#funnyMessages)]

		if ore:GetAttribute("Ionized") and ore:GetAttribute("Spectral") then
			return Test.fail(
				`WHY DO YOU HAVE <b>BOTH OF THE ATTRIBUTES</b> (Ionized & Spectral) IN YOUR ORE!!!!`
			)
		elseif ore:GetAttribute("Ionized") then
			return Test.fail(
				`{funnyMessage}. You have the <b>Ionized attribute</b> in your ore! Remove it!!`
			)
		elseif ore:GetAttribute("Spectral") then
			return Test.fail(
				`{funnyMessage}. You have the <b>Spectral attribute</b> in your ore! Remove it!!`
			)
		end

		return Test.ok("No variant attribute found!")
	end
)
