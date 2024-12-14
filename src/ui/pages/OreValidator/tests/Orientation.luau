local Test = require(script.Parent.Parent.Test)

return Test.define(
	`Orientation is (0, 0, 0)`,
	`Checks if the ore's orientation is at (0, 0, 0) to prevent it from having an odd orientation when spawning in the game.`,
	function(ore)
		return if ore.Orientation ~= Vector3.new(0, 0, 0)
			then Test.fail(
				`The ore's <b> current orientation</b> is currently at <b>({ore.Orientation})</b> which isn't at the <b>ideal orientation of (0, 0, 0)</b>`
			)
			else Test.ok("The ore's orientation is at (0, 0, 0)!")
	end
)
