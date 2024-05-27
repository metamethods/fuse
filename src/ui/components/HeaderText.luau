local Text = require(script.Parent.Text)

local function HeaderText(props: Text.TextProps): TextLabel
  return Text {
    text = props.text,
    layout = {
      TextSize = 24,
      Font = Enum.Font.GothamBold,

      props.layout
    }
  }
end

return HeaderText
