local Fragment = require(script.Parent.Fragment)
local HeaderText = require(script.Parent.HeaderText)
local types = require(script.Parent.Parent.Parent.types)
local Text = require(script.Parent.Text)

export type SectionProps = {
  headerText: types.SourcedAs<string>,
  text: types.SourcedAs<string>,
}

local function Section(props: SectionProps): Frame
  return Fragment {
    children = {
      HeaderText { text = props.headerText },
      Text { text = props.text }
    }
  }
end

return Section