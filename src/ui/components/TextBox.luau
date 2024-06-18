local Padding = require(script.Parent.Padding)
local vide = require(script.Parent.Parent.Parent.packages.vide)
local types = require(script.Parent.Parent.Parent.types)
local useTheme = require(script.Parent.Parent.Parent.util.useTheme)
local Round = require(script.Parent.Round)

export type TextBoxProps = {
  readonly: boolean?,
  layout: vide.vTextBox?,
  selectOnClick: boolean?,
  text: types.SourcedAs<string>?,
  placeholder: types.SourcedAs<string>?,
  cornerLayout: vide.vUICorner?,
  paddingLayout: {UDim}?,
  onChanged: (string) -> ()?,
}

local function TextBox(props: TextBoxProps): TextBox
  return vide.create "TextBox" {
    Name = "TextBox",
    BackgroundColor3 = useTheme(Enum.StudioStyleGuideColor.ScriptBackground),
    Size = UDim2.fromScale(1, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    Text = props.text,
    PlaceholderText = props.placeholder,
    ClearTextOnFocus = false,
    TextEditable = not props.readonly,
    TextSize = 16,
    TextWrapped = true,
    FontFace = Font.fromName("Montserrat", Enum.FontWeight.Medium),
    RichText = true,
    TextColor3 = useTheme(Enum.StudioStyleGuideColor.MainText),
    PlaceholderColor3 = useTheme(Enum.StudioStyleGuideColor.SubText),
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,

    vide.changed("Text", function(newText: string)
      if props.onChanged then
        props.onChanged(newText)
      end
    end),

    Round { layout = props.cornerLayout },
    Padding(props.paddingLayout or {}),

    props.layout
  }
end

return TextBox