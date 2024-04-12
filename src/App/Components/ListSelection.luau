local Fuse = script:FindFirstAncestor("Fuse")

local Packages = Fuse.Packages
local Components = Fuse.App.Components

local ScrollingListRow = require(Components.ScrollingListRow)
local Button = require(Components.Button)

local vide = require(Packages.vide)

local indexes = vide.indexes

export type ListSelectionProps = {
  Layout: vide.vScrollingFrame?,

  items: () -> {string},
  selected: (number?) -> number
}

local function ListSelection(props: ListSelectionProps): ScrollingFrame
  return ScrollingListRow {
    Children = indexes(props.items, function(name, i)
      return Button {
        Text = name,
        Active = function()
          return i == props.selected()
        end,

        clicked = function()
          props.selected(i)
        end
      }
    end),

    Layout = props.Layout
  }
end

return ListSelection