local vide = require(script.Parent.Parent.Parent.packages.vide)
local Text = require(script.Parent.Text)

export type SelectedOreProps = {
  ore: vide.Source<BasePart?>
}

local function SelectedOre(props: SelectedOreProps): TextLabel
  return Text {
    text = function()
      local ore = props.ore()
      local oreName = ore and ore:GetFullName() or "None"

      return `<i>Currently selected ore: <b>{oreName}</b></i>`
    end
  }
end

return SelectedOre