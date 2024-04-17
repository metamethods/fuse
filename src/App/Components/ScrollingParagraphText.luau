local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Components = Fuse.App.Components

local Text = require(Components.Text)
local ScrollingFrame = require(Components.ScrollingFrame)
local Padding = require(Components.Padding)
local Rounded = require(Components.Rounded)

local Theme = require(Fuse.App.Theme)

local vide = require(Packages.vide)

local create = vide.create
local changed = vide.changed
local source = vide.source
local action = vide.action

export type ScrollingParagraphTextProps = {
  Text: string,
  MaxHeight: number?,
  TextLayout: vide.vTextLabel?,
  ScrollingLayout: vide.vScrollingFrame?,
}

local function ScrollingParagraphText(props: ScrollingParagraphTextProps): Frame
  local textHeight = source(0)

  local function clampedScrollingFrameHeight()
    return UDim2.new(1, 0, 0, math.clamp(textHeight() + 16, 0, (props.MaxHeight or 100) + 16))
  end

  return create "Frame" {
    Name = "ScrollingParagraphText",
    BackgroundColor3 = Theme "BackgroundSecondary",
    Size = UDim2.fromScale(1, 0),
    AutomaticSize = Enum.AutomaticSize.Y,

    ScrollingFrame {
      Size = clampedScrollingFrameHeight,

      ClipsDescendants = true,

      props.ScrollingLayout,

      Text {
        Text = props.Text,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        
        RichText = true,

        action(function(textLabel: TextLabel)
          textHeight(textLabel.AbsoluteSize.Y)
        end),

        changed("AbsoluteSize", function(newAbsoluteSize)
          textHeight(newAbsoluteSize.Y)
        end),
        
        props.TextLayout
      },

      Padding { UDim.new(0, 8) }
    },

    Rounded {}
  }
end

return ScrollingParagraphText