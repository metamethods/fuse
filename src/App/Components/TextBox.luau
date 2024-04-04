local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local App = Fuse.App
local Components = App.Components

local Fusion = require(Packages.fusion)
local Theme = require(App.Theme)
local Padding = require(Components.Padding)
local Border = require(Components.Border)
local Rounded = require(Components.Rounded)

local New = Fusion.New
local OnChange = Fusion.OnChange
local Children = Fusion.Children

export type TextBoxProps = {
  text: Fusion.Value<string>,
  placeholder: string?,

  textSize: number?,
}

return function(props: TextBoxProps)
  return New "TextBox" {
    Name = "TextBox",
    BackgroundColor3 = Theme "Background",
    Size = UDim2.new(1, 0, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    Text = props.text,
    ClearTextOnFocus = false,
    TextSize = props.textSize or 14,
    FontFace = Font.fromEnum(Enum.Font.Gotham),
    TextColor3 = Theme "Text",
    MultiLine = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    PlaceholderText = props.placeholder or "",
    TextWrapped = true,

    [OnChange "Text"] = function(newText: string)
      props.text:set(newText)
    end,

    [Children] = {
      Padding(UDim.new(0, 8)),
      Border(1),
      Rounded()
    }
  }
end